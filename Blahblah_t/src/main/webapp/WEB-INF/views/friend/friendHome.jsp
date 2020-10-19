<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Home</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/custom.css">
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
	<h2> 추천 친구 </h2>
		<div class="div_people">
			<div class="div_person">
				<div class="div_img">
					<img
						src="${pageContext.request.contextPath}/resources/img/spongebob.jpg"
						class="img_people">
				</div>
				<div class="div_info">이름</div>
				<div class="div_info">국가</div>
				<div class="div_info">레벨</div>
			</div>
			<div class="div_person">
				<div class="div_img">
					<img
						src="${pageContext.request.contextPath}/resources/img/spongebob.jpg"
						class="img_people">
				</div>
				<div class="div_info">이름</div>
				<div class="div_info">국가</div>
				<div class="div_info">레벨</div>
			</div>
			<div class="div_person">
				<div class="div_img">
					<img
						src="${pageContext.request.contextPath}/resources/img/spongebob.jpg"
						class="img_people">
				</div>
				<div class="div_info">이름</div>
				<div class="div_info">국가</div>
				<div class="div_info">레벨</div>
			</div>
			<div class="div_person">
				<div class="div_img">
					<img
						src="${pageContext.request.contextPath}/resources/img/spongebob.jpg"
						class="img_people">
				</div>
				<div class="div_info">이름</div>
				<div class="div_info">국가</div>
				<div class="div_info">레벨</div>
			</div>
			<div class="div_person">
				<div class="div_img">
					<img
						src="${pageContext.request.contextPath}/resources/img/spongebob.jpg"
						class="img_people">
				</div>
				<div class="div_info">이름</div>
				<div class="div_info">국가</div>
				<div class="div_info">레벨</div>
			</div>
			<div class="div_person">
				<div class="div_img">
					<img
						src="${pageContext.request.contextPath}/resources/img/spongebob.jpg"
						class="img_people">
				</div>
				<div class="div_info">이름</div>
				<div class="div_info">국가</div>
				<div class="div_info">레벨</div>
			</div>
		</div>

	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>

</body>
</html>