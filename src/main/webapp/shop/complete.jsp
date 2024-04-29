<%@page import="shop.dao.ProductIORepository"%>
<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
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
		String orderPw = "";
		
		// 세션에 저장된 주문,배송정보 불러오기
		Order order = (Order)session.getAttribute("order");
		List<Product> cartList = (List<Product>)session.getAttribute("cartList");
	
		// 비회원인 경우
		if( loginId == null || loginId.equals("") ) {
			// (비회원용)주문비밀번호 세션에 저장했던 order에 세팅한 후 다시 세션세팅
			orderPw = request.getParameter("orderPw");
			order.setOrderPw(orderPw);
			
			session.setAttribute("order", order);
			order = (Order)session.getAttribute("order");
		}
		
		// order테이블에 주문 등록
		OrderRepository orderDAO = new OrderRepository();
		orderDAO.insert(order);
		
		int maxNo = orderDAO.lastOrderNo();
		
		// product_io 출고 등록 & product 남은 재고수 변경
		ProductIORepository productIO = new ProductIORepository();
		
		for(Product item : cartList) {
			item.setOrderNo(maxNo);
			productIO.insert(item);
		}
		
	
	%>


	<!-- 헤더 -->
	<jsp:include page="/layout/header.jsp" />
	
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">주문 완료</h1>
	</div>
	
	<div class="mt-5 text-center">
		<h3 class="text-center d-flex justify-content-center">주문이 완료되었습니다.</h3>
		<div style="width=500px">
			<table class='table'>
				<tr>
					<td>주문번호: </td>
					<td><%=maxNo%></td>
				</tr>
				<tr>
					<td>배송지: </td>
					<td><%=order.getAddress() %></td>
				</tr>
			</table>
		</div>
	</div>
	
	
	
	<!-- 푸터, 스크립트 -->
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	
</body>
</html>