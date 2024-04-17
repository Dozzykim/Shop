<%@page import="shop.dto.Product"%>
<%@page import="shop.dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보</title>
<jsp:include page="/layout/meta.jsp" />
<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<%
	String root = request.getContextPath();

	// 요청 파라미터
	String product_id = request.getParameter("product_id");

	// 요청 제품 정보 받아오기
	ProductRepository productDAO = new ProductRepository();
	Product product = productDAO.getProductById(product_id);
	%>

	<!-- 헤더 -->
	<jsp:include page="/layout/header.jsp" />

	<div class="container mx-auto">
		<div class="top_Container">
			<div class="d-flex flex-column mb-3 p-5">
				<h1 class="text-center fw-bold">상품 정보</h1>
				<p class="text-center fs-5">Shop 쇼핑몰 입니다.</p>
				<a href="<%=root%>/shop/products.jsp" id="list" class="btn btn-primary col align-self-center">상품목록</a>
			</div>
		</div>

		<form>
			<div class="product_Container d-flex justify-content-center">
				<img class="img_Content" alt="" src="..<%=product.getFile()%>">
				<div class="d-flex flex-column ms-5">
					<h3 class="mb-4 pb-2"><%=product.getName()%></h3>
					<p class="border-bottom">상품ID:<span class="ms-3"><%=product.getProductId()%></span></p>
					<p class="border-bottom">제조사:<span class="ms-3"><%=product.getManufacturer()%></span></p>
					<p class="border-bottom">분류:<span class="ms-4"><%=product.getCategory()%></span></p>
					<p class="border-bottom">상태:<span class="ms-4"><%=product.getCondition()%></span></p>
					<p class="border-bottom">재고 수:<span class="ms-3"><%=product.getUnitsInStock()%></span></p>
					<p class="border-bottom">가격:<span class="ms-4"><%=product.getUnitPrice()%></span></p>
					
					<div class="mt-4">
						<button class="btn btn-warning me-2" id="cart" onclick="addToCart()">장바구니</button>
						<button class="btn btn-success ms-2" id="order" onclick="ordering()">주문하기</button>
					</div>
					
				</div>
			</div>
		</form>
		
	</div>


	<!-- 푸터 -->
	<jsp:include page="/layout/footer.jsp" />

	<script type="text/javascript">
		function MoveToList() {
			window.location.href="<%=root%>/shop/products.jsp";
		}
		// 장바구니
		function addToCart() {
			alert('장바구니');
			window.location.href="<%=root%>/shop/cart.jsp";
		}
		// 주문하기
		function ordering() {
			alert('주문하기');
			/* 장바구니 처리 cart_pro로 요청보내기 */
		}
		
	</script>
</body>
</html>