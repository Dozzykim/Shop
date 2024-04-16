<%@page import="shop.dao.UserRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String id = request.getParameter("id");

	UserRepository userDAO = new UserRepository();
	
	int result = userDAO.delete(id);
	
	String root = request.getContextPath();
	
	if (result > 0) {
		
		System.out.println("탈퇴 성공");
		response.sendRedirect(root + "/user/complete.jsp?msg=3");
		
		/* 세션 무효화... (탈퇴했으니 로그인 풀리면서 세션도 해제해주어야함)*/
		session.invalidate();
		
	} else {
		
		System.out.println("탈퇴 실패");
		response.sendRedirect(root + "/user/update.jsp?msg=0");
	}
	
%>
