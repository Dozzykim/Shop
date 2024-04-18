<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.util.List"%>
<%@page import="shop.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<%	
	String root = request.getContextPath();
	
	// 세션에 저장한 장바구니 상품리스트 빼오기
	List<Product> cartList = (List<Product>)request.getAttribute("cartList");
	
	// 카트가 null인지 확인
	if (cartList == null) {
	    cartList = new ArrayList<>(); // 새로운 카트 생성
	}
	
	%>
	<!-- 헤더 -->
	<jsp:include page="/layout/header.jsp" />

	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">장바구니</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">장바구니 목록 입니다.</p>
		</div>
	</div>
	<h1>장바구니: <%=cartList.size()%>개</h1>
	<!-- 장바구니 영역 -->
	<div class="container order">
		<!-- 장바구니 목록 -->
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
			if(cartList.isEmpty()) {
			%>	
				</tbody>
				<tfoot>
					<tr>
						<td>추가된 상품이 없습니다.</td>
					</tr>
				</tfoot>
			<%
			} else {
				for(Product product : cartList) {
			%>
				<tr>
					<td><%=product.getName()%></td>			
					<td><%=product.getUnitPrice()%></td>			
					<td><%=product.getQuantity()%></td>			
					<td><%=product.getQuantity()*product.getUnitPrice()%></td>			
					<td><a href="deleteCart.jsp?id=<%=product.getProductId()%>" class="btn btn-danger">삭제</a></td>			
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
					<td id="cart-sum">348136</td>
					<td></td>
				</tr>
				
			</tfoot>
			<%
			}
			%>
		</table>
	
		<!-- 버튼 영역 -->
		<div class="d-flex justify-content-between align-items-center p-3">
			<a href="deleteCart.jsp?cartId=<%=root%>" class="btn btn-lg btn-danger ">전체삭제</a>

			<a href="javascript:;" class="btn btn-lg btn-primary" onclick="order()">주문하기</a>
		</div>
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>