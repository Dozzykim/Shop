<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="shop.dao.ProductRepository"%>
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
	<title>상품 목록</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<%
		ProductRepository productDAO = new ProductRepository();
		List<Product> productList = productDAO.list();
		
		String root = request.getContextPath();
	%>
	<!-- 헤더 -->
	<jsp:include page="/layout/header.jsp" />
	
	<div class="container">
		<div class="inner_Container p-5">
			<h1 class="text-center">상품 목록</h1>
			<p class="text-center">쇼핑몰 상품 목록 입니다.</p>
			<div class="d-flex justify-content-center gap-2">
				<a href="" class="btn btn-primary">상품 등록</a>	
				<a href="" class="btn btn-success">상품 편집</a>
				<a href="" class="btn btn-warning">장바구니</a>	
			</div>
		</div>
		
		<!-- 카드뷰 -->
		<div class="product_Container">
			<div class="row">
				<%
					for(Product product : productList) {
				%>
				<div class="col-12 col-md-6 col-xl-4 col-xxl-3 pb-3">
					<form action="<%=root%>/shop/product.jsp" method="post">
						<div class="card">
							<div class="img-content">
								<img class="p-3" alt="" src="..<%=product.getFile()%>">
							</div>
							<div class="content">
								<h3 class="text-center"><%=product.getName() %></h3>
								<p class="text-center"><%=product.getDescription() %></p>
								<div class="me-3">
									<p class="price text-end">₩ <%=product.getUnitPrice() %></p>
								</div>
								<div class="d-flex justify-content-around mb-2">
									<input type="hidden" name="product_id" value="<%=product.getProductId()%>"/>
									<button class="rounded border border-primary bg-light-subtle text-primary"><span class="material-symbols-outlined p-2">shopping_bag</span></button>
									<a href="<%=root%>/shop/product.jsp?product_id=<%=product.getProductId()%>" class="btn btn-outline-primary">상세 정보</a>
								</div>
							</div>
						</div>
					</form>	
				</div>
				<%
					}
				%>
				</div>
			</div>
		</div>
	<!-- 푸터 -->
	<jsp:include page="/layout/footer.jsp" />
</body>
</html>
	