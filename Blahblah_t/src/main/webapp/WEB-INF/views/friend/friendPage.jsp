<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>친구정보</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/custom.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

<script>
	function friendFollow() {
		var followerID= "${member.id}";
		var followingID = "${friend.id}";
		const IDInfo = JSON.stringify({followingID:followingID, followerID:followerID}); 
		console.log(IDInfo);
	   	$.ajax({
			url:"${contextPath}/prj/friend/setFollowing" ,
			type: "post",
			data:IDInfo,
			dataType: "json",
			contentType:"application/json",
			success: function(data){
				if (data.chkResult){
					alert("성공");
				}
				else{
					{
						alert("실패");
					}}
			},
			error: function(errorThrown){
				alert(errorThrown.statusText);
			}
		})
	}
</script>
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
				<div class="div_info">${friend.nickname }</div>
				<div class="div_info">한국</div>
				<div class="div_info">레벨</div>
			</div>
			<c:if test="${not empty sessionScope.member}">
				<div class="div_btn">
					<input class="btn btn-primary" type="button" value="Follow" onClick="friendFollow()"/>
					 <input class="btn btn-primary" type="button" value="DM"/> 
					 <input class="btn btn-primary" type="button" value="Chatting"/>
				</div>
			</c:if>
			<c:if test="${empty sessionScope.member}">
				<div class="div_btn">
					<a href="${contextPath}/prj/member/loginForm">로그인 해서 채팅을
						시작해보세요!</a>
				</div>
			</c:if>
		</div>
	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>

</body>
</html>