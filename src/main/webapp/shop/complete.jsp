<%@page import="shop.dao.OrderRepository"%>
<%@page import="shop.dto.Order"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문 완료</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<%
		String loginId = (String)session.getAttribute("loginId");
	
		// 비회원인 경우
		if( loginId == null || loginId.equals("") ) {
			// (비회원용)주문비밀번호 세션에 저장했던 order에 세팅한 후 다시 세션세팅
			String orderPw = request.getParameter("orderPw");
			
			Order order = (Order)session.getAttribute("order");
			order.setOrderPw(orderPw);
			
			session.setAttribute("order", order);
		}
		
		// 세션에 저장된 주문,배송정보 불러오기
		Order order = (Order)session.getAttribute("order");
		
		OrderRepository orderDAO = new OrderRepository();
		orderDAO.insert(order);
		
	
	%>


	<!-- 헤더 -->
	<jsp:include page="/layout/header.jsp" />
	
	<h1>비회원 주문 비밀번호: <%=order.getOrderPw() %></h1>
	
	
	
	<!-- 푸터, 스크립트 -->
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	
</body>
</html>