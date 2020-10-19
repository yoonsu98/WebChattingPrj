<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	<!-- nav바 -->
	<nav class="navbar navbar-inverse navbar-static-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<div class="navbar-header">
					<a class="navbar-brand" href="${pageContext.request.contextPath }">BlahBlah</a>
				</div>
				<c:if test="${empty sessionScope.member}">
				<ul class="nav navbar-nav">
					<li><a href="${contextPath}/prj/board/boardList">자유게시판</a></li>
					<li><a href="${contextPath}/prj/chatting/chattingForm">채팅</a></li>
					<li><a href="#">QnA</a></li>
					<li><a href="${contextPath}/prj/member/loginForm ">로그인</a></li>
				</ul>
				</c:if>
				<c:if test="${not empty sessionScope.member}">
				<ul class="nav navbar-nav">
					<li><a href="${contextPath}/prj/board/boardList">자유게시판</a></li>
					<li><a href="${contextPath}/prj/chatting/chattingForm">채팅</a></li>
					<li><a href="#">QnA</a></li>
					<li><a href="${contextPath}/prj/friend/myPage">마이페이지</a></li>
					<li><a href="${contextPath}/prj/member/logout">로그아웃</a></li>
				</ul>
				</c:if>
			</div>
		</div>
	</nav>
</body>
<script>
console.log(window.sessionStorage);
</script>
</html>