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
	<!-- uppermost -->
	<div id="myCarousel" class="carousel slide" data-ride="carousel">
		<!-- Indicators -->
		<ol class="carousel-indicators">
			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="1"></li>
			<li data-target="#myCarousel" data-slide-to="2"></li>
		</ol>

		<!-- Wrapper for slides -->
		<div class="carousel-inner" role="listbox">
			<div class="item active">
				<img src="${pageContext.request.contextPath}/resources/img/main1.jpg" style="width:100%; height:400; " alt="pic1">
				<div class="carousel-caption">
					<h3>소통</h3>
					<p>BlahBlah에서 외국인과 친구가 되어보세요.</p>
				</div>
			</div>

			<div class="item">
				<img src="${pageContext.request.contextPath}/resources/img/main2.jpg" style="width:100%; height:400; " alt="pic2">
				<div class="carousel-caption">
					<h3>여행</h3>
					<p>새로 사귄 친구들과 여행을 가보는건 어때요?</p>
				</div>
			</div>

			<div class="item">
				<img src="${pageContext.request.contextPath}/resources/img/main3.jpg" style="width:100%; height:400; " alt="pic3">
				<div class="carousel-caption">
					<h3>우정</h3>
					<p>무슨일이든 친구와 함께 해보아요.</p>
				</div>
			</div>
		</div>

		<!-- Left and right controls -->
		<a class="left carousel-control" href="#myCarousel" role="button"
			data-slide="prev"> <span class="glyphicon glyphicon-chevron-left"
			aria-hidden="true"></span> <span class="sr-only">Previous</span>
		</a> <a class="right carousel-control" href="#myCarousel" role="button"
			data-slide="next"> <span
			class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>
</body>
</html>