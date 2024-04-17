<!-- 로그인 처리 -->
<%@page import="java.util.UUID"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	UserRepository userDAO = new UserRepository();
	User loginUser = userDAO.login(id, pw);
	
	String root = request.getContextPath();
	
	// 로그인 실패
	if (loginUser == null) {
		response.sendRedirect(root + "/user/login.jsp?error=0");
		return;
	}
	
	/*아이디 저장*/
	String rememberId = request.getParameter("remember-id");
	Cookie cookieRememberId = new Cookie("rememberId", ""); // 아이디 저장여부
	Cookie cookieUserId = new Cookie("userId", ""); // 저장된 아이디
	
	// 아이디저장 체크 시, 값 : on
	if (rememberId != null && rememberId.equals("on")) {
		// 쿠키 생성 => UTF-8로 인코딩하여 값 저장
		cookieRememberId.setValue(URLEncoder.encode(rememberId, "UTF-8"));
		cookieUserId.setValue(URLEncoder.encode(id, "UTF-8"));
	
	} else {
		// 아이디저장 미체크 시,
		// 쿠키 삭제
		cookieRememberId.setMaxAge(0);
		cookieUserId.setMaxAge(0);
	}
	
	// 쿠키 전달
	response.addCookie(cookieRememberId);
	response.addCookie(cookieUserId);
	
	/*아이디 저장 끝*/
	
	/* 자동 로그인 */
	String rememberMe = request.getParameter("remember-me");
	Cookie cookieRememberMe = new Cookie("rememberMe", "");
	Cookie cookieToken = new Cookie("token", "");
	
	// 자동로그인 체크 여부, 토큰 쿠키에 대한 경로설정
	cookieRememberMe.setPath("/");
	cookieToken.setPath("/");
	
	// 쿠키 유효기간 설정
		cookieRememberMe.setMaxAge(7*60*60*24);		// 초단위 --> 7일
		cookieToken.setMaxAge(7*60*60*24);
	
	// 체크 여부에 따라 쿠키 생성 또는 삭제
	if (rememberMe != null && rememberMe.equals("on")) {
		// 자동 로그인 체크 => 토큰 발행
		// 없었으면 새로 생성 / 있었으면 새로 업데이트
		String tokenValue = userDAO.refreshToken(id);
		// 쿠키 생성 => UTF-8로 인코딩하여 값 저장
		cookieRememberMe.setValue(URLEncoder.encode(rememberMe, "UTF-8"));
		cookieToken.setValue(URLEncoder.encode(tokenValue, "UTF-8"));
	
	} else {
		// 자동로그인 미체크
		// 쿠키 삭제
		cookieRememberMe.setMaxAge(0);
		cookieToken.setMaxAge(0);
	}
	
	// 응답에 쿠키 등록
	response.addCookie(cookieRememberMe);
	response.addCookie(cookieToken);
	/* 자동 로그인 끝 */
	
	if( loginUser != null) {
		// 로그인 성공
		// 세션에 아이디 등록 후, 메인 페이지로 이동
		System.out.println("세션아이디: " + loginUser.getId());
		session.setAttribute("loginId", loginUser.getId() );
		response.sendRedirect( root + "/user/complete.jsp?msg=0" );
	}

%>





