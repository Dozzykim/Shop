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
	<title>Shop</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
</head>
<body>
	<%
	String root = request.getContextPath();
	%>
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">메인화면</h1>
		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">Shop 쇼핑몰 입니다.</p>
			<div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
				<a href="<%=root%>/shop/products.jsp" class="btn btn-primary btn-lg px-4 gap-3">상품목록</a>
				<!-- 로그인 시, 로그인 버튼 안보임 -->
				<c:if test="${sessionScope.loginId != null }">
					<a href="<%=root%>/user/logout.jsp" class="btn btn-outline-danger btn-lg px-4">로그아웃</a>
				</c:if>
				<!-- 로그인 시, 로그인 버튼 안보임 -->
				<c:if test="${sessionScope.loginId == null }">
					<a href="<%=root%>/user/login.jsp" class="btn btn-outline-secondary btn-lg px-4">로그인</a>
				</c:if>
			</div>
		</div>
	</div>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	
</body>
</html>





