<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Home</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/custom.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>
	<!-- main -->
	<div class="container text-center">
			<div class="div_people">
			<div class="div_person_detail">
				<div class="div_img">
					<img
						src="${pageContext.request.contextPath}/resources/img/spongebob.jpg"
						class="img_people">
				</div>
				<div class="div_info">${member.nickname }</div>
				<div class="div_info">한국</div>
				<div class="div_info">레벨</div>
			</div>
				<div class="div_btn " >
					<div class="dropdown" style="display:inline;">
					  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					    Friend!
					  </button>
					  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
					    <a class="dropdown-item" href="${pageContext.request.contextPath }/friend/followingList">FollowingList</a><br>

					    <a class="dropdown-item" href="${pageContext.request.contextPath }/friend/followerList">FollowerList</a><br>
					  </div>
					</div>
					<div class="dropdown" style="display:inline;">
					  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					    Direct Message!
					  </button>
					  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
					    <a class="dropdown-item" href="${pageContext.request.contextPath }/friend/DMSendList">SendMessage</a><br>

					    <a class="dropdown-item" href="${pageContext.request.contextPath }/friend/DMRecieveList">RecieveMessage</a><br>
					  </div>
					</div>
				</div>
		</div>

	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>

</body>
</html>