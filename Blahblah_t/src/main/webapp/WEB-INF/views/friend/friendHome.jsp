<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Home</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>
	<!-- main -->
	<div class="container text-center">
		<br>
		<br>
		<br>
		<a href="${pageContext.request.contextPath }/friend/followingList"><input type="button" class="btn btn-primary btn-lg"
			style="height: 100px; width: 200px;" value="Following"></a>
		<a href="${pageContext.request.contextPath }/friend/followerList"><input type="button" class="btn btn-primary btn-lg"
			style="height: 100px; width: 200px;" value="Follower"></a>
		<br>
		<br>
		<br>
	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>

</body>
</html>