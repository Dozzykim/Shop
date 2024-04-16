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
		<div class="row">
			<div class="col-6">
				<div class="card">
					<div class="img-content">
						<img alt="" src="../static/img/JAVA.jpg">
					</div>
					<div class="content">
						<h3 class="text-center">자바 프로그래밍</h3>
						<p></p>
					</div>
				</div>
			</div>
			<div class="col-6">
				<div class="card">
					123
				</div>
				
			</div>
		</div>
	</div>
	
	<!-- 푸터 -->
	<jsp:include page="/layout/footer.jsp" />
</body>
</html>
	