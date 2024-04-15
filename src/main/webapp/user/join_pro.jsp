<!-- 
	회원 가입 처리
 -->
<%@page import="java.nio.file.attribute.UserPrincipalLookupService"%>
<%@page import="shop.dao.UserRepository"%>
<%@page import="shop.dto.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String birth = year.substring(2, 4) + month + day;
	String email = request.getParameter("email1")+ "@" + request.getParameter("email2");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	
	
	User user = new User();
	user.setId(id);
	user.setPassword(pw);
	user.setName(name);
	user.setGender(gender);
	user.setBirth(birth);
	user.setMail(email);
	user.setPhone(phone);
	user.setAddress(address);

	UserRepository userDAO = new UserRepository();
	int result = userDAO.insert(user);
	
	String root = request.getContextPath();
	
	if (result > 0) {
		System.out.println("가입 성공: " + user.getId());
		response.sendRedirect(root + "/user/complete.jsp?msg=1");
	} else {
		System.out.println("가입 실패");
		response.sendRedirect(root + "/user/join.jsp?msg=0");
	}
	
%>
    
    

    
    
    
    
    
    