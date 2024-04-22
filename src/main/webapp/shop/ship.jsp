<%@page import="shop.dto.Product"%>
<%@page import="java.util.List"%>
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
	<title>배송 정보</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
	
	<!-- jQuery CDN 방식으로 포함하기 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript">
		function validateForm() {
			// 이름
			var name = document.getElementById('name').value;
			if (name == "") {
				alert("이름을 입력해주세요.");
				return false;
			}
			// 배송일
			var shippingDate = document.getElementById("shippingDate").value;
			if (shippingDate == "") {
				alert("배송일을 입력해주세요.");
				return false;
			}
			// 국가명
			var country = document.getElementById("country").value;
			if (country == "") {
				alert("국가명을 입력해주세요.");
				return false;
			}
			// 우편번호
			var zipCode = document.getElementById("zipCode").value;
			if (zipCode == "") {
				alert("우편변호를 입력해주세요.");
				return false;
			}
			// 주소
			var addressName = document.getElementById("addressName").value;
			if (addressName == "") {
				alert("주소를 입력해주세요.");
				return false;
			}
			// 전화번호
			var phone = document.getElementById("phone").value;
			if (phone == "") {
				alert("전화번호를 입력해주세요.");
				return false;
			}
			return true;
		}
	</script>
</head>
<body>
	<%
		String root = request.getContextPath();
	%>
	<!-- 헤더 -->
	<jsp:include page="/layout/header.jsp" />
	
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">배송 정보</h1>
	</div>
	
	<!-- 배송 정보 입력 -->
	<div class="container shop mb-5 p-4">
		<form action="order.jsp" class="form-horizontal" method="post" onsubmit="return validateForm()">
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">성명</label>
				<input type="text" class="form-control col-md-10" id="name" name="name" value="">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">배송일</label>
				<input type="text" class="form-control col-md-10" id="shippingDate" name="shippingDate" value="">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">국가명</label>
				<input type="text" class="form-control col-md-10" id="country" name="country" value="">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">우편번호</label>
				<input type="text" class="form-control col-md-10" id="zipCode" name="zipCode" value="">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">주소</label>
				<input type="text" class="form-control col-md-10" id="addressName" name="addressName" value="">
			</div>
			<div class="input-group mb-3 row">
				<label class="input-group-text col-md-2" id="">전화번호</label>
				<input type="text" class="form-control col-md-10" id="phone" name="phone" value="">
			</div>
			
			<!-- 버튼 영역 -->
			<div class="d-flex justify-content-between mt-5 mb-5">
				<div class="item">
					<a href="<%=root%>/shop/cart.jsp" class="btn btn-lg btn-success">이전</a>
					<!-- 취소 프로세스는 이어서... -->				
					<a href="<%=root%>/index.jsp" class="btn btn-lg btn-danger">취소</a>				
				</div>
				<div class="item">
					<input type="submit" class="btn btn-lg btn-primary" value="등록">
				</div>
			</div>
			
		</form>
	</div>

	<!-- 푸터, 스크립트 -->
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>