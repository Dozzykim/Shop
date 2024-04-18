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
			<h1 class="text-center"><%=loginId %>님 환영 합니다.</h1>
			<div class="btn-box d-flex justify-content-center p-5">
				<a href="<%=root%>" class="btn btn-lg btn-primary">메인 화면</a>
			</div>	
		</c:if>
		<c:if test="${ param.msg==1 }">
			<!-- 회원가입 성공 -->
			<h1>회원 가입이 완료되었습니다.</h1>
			<button onclick="moveToMain()">메인화면</button>
		</c:if>
		<c:if test="${ param.msg==2 }">
			<!-- 회원정보 수정 성공 -->
			<h1>회원 정보가 수정되었습니다.</h1>
			<button onclick="moveToMain()">메인화면</button>
		</c:if>
		<c:if test="${ param.msg==3 }">
			<!-- 회원탈퇴 성공 -->
			<h1>회원 정보가 삭제되었습니다.</h1>
			<button onclick="moveToMain()">메인화면</button>
		</c:if>
		
			
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	
	<script >
	    function moveToMain() {
	    	window.location.href="<%=root%>/index.jsp";
		}
	    
    </script>
</body>
</html>







