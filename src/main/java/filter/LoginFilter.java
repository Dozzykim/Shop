package filter;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import shop.dao.UserRepository;
import shop.dto.PersistentLogin;

public class LoginFilter extends HttpFilter implements Filter {
	
	Cookie[] cookies;
	UserRepository userDAO;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		userDAO = new UserRepository();
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// request 객체로부터 자동 로그인 쿠키 확인
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		cookies = httpRequest.getCookies();
		
		String rememberMe = null; 	// 자동 로그인 여부
		String token = null;		// 인증 토큰
		
		if ( cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				String cookieName = cookie.getName();
				String cookieValue = URLDecoder.decode( cookie.getValue(), "UTF-8");
				switch (cookieName) {
				case "rememberMe" 	: rememberMe = cookieValue; break;
				case "token"		: token = cookieValue;		break;
				}
			}
		}
		
		// 로그
		System.out.println("LoginFilter 실행...");
		System.out.println("rememberMe : " + rememberMe);
		System.out.println("token : " + token);

		// 자동로그인 쿠키가 검증되면, 로그인 처리
		HttpSession session = httpRequest.getSession();
		if (rememberMe != null && token != null) {
			PersistentLogin persistentLogin = userDAO.selectTokenByToken(token);
			if ( persistentLogin != null ) {
				// 인증되면, 세션에 등록 후 로그인 처리
				session.setAttribute("loginId", persistentLogin.getUserId());
			}
		}
		chain.doFilter(request, response);
	}
	
	@Override
	public void destroy() {
		
	}
	
}
