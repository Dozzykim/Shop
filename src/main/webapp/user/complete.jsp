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
	<title>Shop</title>
	<jsp:include page="/layout/meta.jsp" /> <jsp:include page="/layout/link.jsp" />
</head>
<body>   
	<%
	String root = request.getContextPath();
	String error = request.getParameter("msg");
	String loginId = (String) session.getAttribute("loginId");
	%>
	
	<jsp:include page="/layout/header.jsp" />
	<div class="px-4 py-5 my-5 text-center">
		<h1 class="display-5 fw-bold text-body-emphasis">회원 정보</h1>
	</div>
	
	<!-- 로그인완료, 회원 가입/수정/탈퇴 완료 -->
	<div class="container mb-5">
		<c:if test="${ param.msg==0 }">
			<!-- 로그인 성공 -->
			<h1><%=loginId %>님 환영합니다.</h1>
		</c:if>
		<c:if test="${ param.msg==1 }">
			<!-- 회원가입 성공 -->
			<h1>회원가입이 완료되었습니다!</h1>
		</c:if>
		
			
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>







