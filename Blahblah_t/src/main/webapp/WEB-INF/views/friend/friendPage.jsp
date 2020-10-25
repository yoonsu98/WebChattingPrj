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
		var followerID = "${member.id}";
		var followingID = "${friend.id}";
		const IDInfo = JSON.stringify({
			followingID : followingID,
			followerID : followerID
		});
		$.ajax({
			url : "${contextPath}/prj/friend/setFollowing",
			type : "post",
			data : IDInfo,
			dataType : "json",
			contentType : "application/json",
			success : function(data) {
				if (data.chkResult) {
					alert("성공");
				} else {
					{
						alert("실패");
					}
				}
			},
			error : function(errorThrown) {
				alert(errorThrown.statusText);
			}
		})
	}
	function sendDM(){
		if (idCheck()) {
			let messageFrom = "${member.id}";
 			let messageTo = document.getElementById('MessageTo').value;
 			let messageTitle = document.getElementById('MessageTitle').value;
 			let messageContent = document.getElementById('MessageContent').value;
			const messageInfo = JSON.stringify({
			
				messageTo : messageTo,
				messageFrom: messageFrom,
				messageTitle: messageTitle,
				messageContent :messageContent
			});
			debugger;
 			$.ajax({
				data : messageInfo,
				url : "${contextPath}/prj/friend/sendDM",
				type : "post",
				dataType : "json",
				contentType : "application/json; charset=UTF-8",
				success : function(data) {
					if (data.chkResult) {
						alert('Sending Completed!  ;->');
					} else {

						alert('errorrr ;-<');
					}
				},
				error : function(e) {
					console.log("실패");
				}
			});  
		}
		else{
			alert('잘못된 아이디 정보입니다!');
		}
	}
	function idCheck(){
		var result;
		let id = document.getElementById('MessageTo').value;
		const IDInfo = JSON.stringify({id:id}); 
	   	$.ajax({
			url:"${contextPath}/prj/member/getIDInfo" ,
			type: "post",
			data:IDInfo,
			async:false,
			dataType: "json",
			contentType:"application/json",
			success: function(data){
				if (data.chkResult){
					result = false;
				}
				else{
					result= true;
				}
			},
			error: function(errorThrown){
				alert(errorThrown.statusText);
			}
		});

		console.log(result);
		return result;
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
					<button class="btn btn-primary" type="button"
						onClick="friendFollow()">Follow</button>
					<button class="btn btn-primary" type="button" id="sendDMbtn">DM</button>
					<a href="/prj/chatting/singlechattingForm/${friend.id}">
					
					<button class="btn btn-primary" type="button" >Chatting</button></a>
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
	<!-- The Modal -->
	<div id="sendDMPopup" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<div>
				<span class="close">&times;</span>
				<p>Direct Message</p>
			</div>
			<div class="form-group">
				<label for="MessageTo">TO.</label> <input type="text"
					class="form-control" id="MessageTo" name="MessageTo"
					value="${friend.id}"> <label for="MessageTitle">Title.</label>
				<input type="text" class="form-control" id="MessageTitle"
					name="MessageTitle" placeholder="제목"><label
					for="MessageContent">Content.</label>
				<textarea class="form-control" rows="8" id="MessageContent"
					name="MessageContent" placeholder="내용"></textarea>
			</div>
			<div>
				<button type="button" onClick="sendDM();" class="btn btn-default">Send
					^0^</button>
			</div>
		</div>

	</div>

	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>


</body>
<script>
	// Get the modal
	var modal = document.getElementById('sendDMPopup');
	// Get the button that opens the modal
	var btn = document.getElementById("sendDMbtn");
	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];
	// When the user clicks on the button, open the modal 
	btn.onclick = function() {
		modal.style.display = "block";
	}
	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
		modal.style.display = "none";
	}
	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
		if (event.target == modal) {
			modal.style.display = "none";
		}
	}
</script>
</html>