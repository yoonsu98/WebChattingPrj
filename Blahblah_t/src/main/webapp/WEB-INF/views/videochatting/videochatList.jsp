<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>videoChatList</title>
<style>
.panel-title {
	text-align: center;
}
</style>
</head>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
</script>
<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	
	<main>
		<div class="container">
			<ul class="list-group">
				<li class="list-group-item">방제목<span class="badge">아이디</span></li>
				<c:forEach var="row" items="${list}">
				<c:if test="${row.vcpeople eq 2}">
				<li class="list-group-item"><span style="color:gray">${row.vctitle }</span><span class="badge">${row.vcpeople }/2</span><span class="badge">${row.vcid }</span></li>
				</c:if>
				<c:if test="${row.vcpeople eq 1}">
				<li class="list-group-item"><a onclick="enterChatroom(${row.vcno});" href="${pageContext.request.contextPath }/videochatting/videochatroom/${row.vcno}?bang_id=${row.vctitle}">${row.vctitle }</a><span class="badge">${row.vcpeople }/2</span><span class="badge">${row.vcid }</span></li>
				</c:if>
				<%-- <li class="list-group-item"><a onclick="enterChatroom(${row.vcno});" href="${pageContext.request.contextPath }/videochatting/videochatroom/${row.vcno}?bang_id=${row.vctitle}">${row.vctitle }</a><span class="badge">${row.vcpeople }</span><span class="badge">${row.vcid }</span></li> --%>
				</c:forEach>
			</ul>
		 <button type="button" class="btn btn-primary" onClick="location.href='${pageContext.request.contextPath}/videochatting/addRoom'">방생성</button>
		</div>
	</main>

	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>

</body>
<script>
function enterChatroom(vcno){
	const roomInfo = JSON.stringify({
		vcno : vcno
	});
	console.log(roomInfo);
 	$.ajax({
		data : roomInfo,
		url : "${contextPath}/prj/videochatting/peopleCount",
		type : "post",
		dataType : "text",
		contentType : "application/json; charset=UTF-8",
		success : function(data) {
			console.log(data);
		},
		error : function(data) {
			alert("실패");
		}
	}); 
	
}
</script>
</html>