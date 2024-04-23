<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
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
	<title>주문정보</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<%
		String root = request.getContextPath();
	
		// 세션에 저장한 장바구니, 배송정보
		List<Product> cartList = (List<Product>)session.getAttribute("cartList");
		Order order = (Order)session.getAttribute("order");
		
		boolean isLoggin = session.getAttribute("loginId") != null ? true : false;
		
		String userType = "";
				
		if(isLoggin) {
			userType = "회원";
		} else {
			userType = "비회원";
		}
		
	%>
	<!-- 헤더 -->
	<jsp:include page="/layout/header.jsp" />
	
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">주문 정보</h1>
	</div>
	<div class="container order mb-5">
		<form action="complete.jsp" method="post">
			<!-- 배송정보 -->
			<div class="ship-box">
				<table class="table ">
					<tbody><tr>
						<td>주문 형태 :</td>
						<td><%=userType%> 주문</td>
					</tr>
					<tr>
						<td>성 명 :</td>
						<td><%=order.getShipName()%></td>
					</tr>
					<tr>
						<td>우편번호 :</td>
						<td><%=order.getZipCode()%></td>
					</tr>
					<tr>
						<td>주소 :</td>
						<td><%=order.getAddress() %></td>
					</tr>
					<tr>
						<td>배송일 :</td>
						<td><%=order.getDate() %></td>
					</tr>
					<tr>
						<td>전화번호 :</td>
						<td><%=order.getPhone()%></td>
					</tr>
				<!-- 비회원 주문시 표시될 영역 -->
				<c:if test="${sessionScope.loginId == null }">
					<tr>
						<td>주문 비밀번호 :</td>
						<td>
							<input type="password" class="form-control" name="orderPw">
						</td>
					</tr>
				</c:if>
				<!-- 끝 -->
					
				</tbody></table>
			</div>
			
			<!-- 주문목록 -->
			<div class="cart-box">
				<table class="table table-striped table-hover table-bordered text-center align-middle">
					<thead>
						<tr class="table-primary">
							<th>상품</th>
							<th>가격</th>
							<th>수량</th>
							<th>소계</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<%
						for(Product product : cartList) {
						%>
						<tr>
							<td><%=product.getName()%></td>			
							<td><%=product.getUnitPrice()%></td>			
							<td><%=product.getQuantity()%></td>			
							<td><%=product.getQuantity()*product.getUnitPrice()%></td>			
							<td></td>			
						</tr>
						<%
						}
						%>
					</tbody>
					<tfoot>
						
						<tr>
							<td></td>
							<td></td>
							<td>총액</td>
							<td><%=order.getTotalPrice()%></td>
							<td></td>
						</tr>
						
					</tfoot>
				</table>
		
			</div>
			
			<!-- 버튼 영역 -->
			<div class="d-flex justify-content-between mt-5 mb-5">
				<div class="item">
					<a href="<%=root%>/shop/ship.jsp" class="btn btn-lg btn-success">이전</a>
					<!-- 취소 프로세스는 이어서... -->				
					<a href="<%=root%>/index.jsp" class="btn btn-lg btn-danger">취소</a>				
				</div>
				<div class="item">
					<input type="hidden" name="login" value="<%=isLoggin%>">
					<input type="hidden" name="totalPrice" value="<%=order.getTotalPrice()%>">
					<input type="submit" class="btn btn-lg btn-primary" value="주문완료">	
				</div>
			</div>
		</form>
	</div>
	
	<!-- 푸터, 스크립트 -->
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	
</body>
</html>