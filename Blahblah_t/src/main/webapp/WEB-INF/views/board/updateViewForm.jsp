<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Board</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

</head>

<script>
function updateView(){
	let title = document.getElementById("title").value;
	let content = document.getElementById("content").value;
	
	const boardInfo = JSON.stringify({title:title,content:content});

	$.ajax({
		data : boardInfo,
		url : "${contextPath}/prj/board/updateView",
		type : "post",
		dataType : "text",
		contentType : "application/json; charset = UTF-8",
		success : function(data){
			console.log(data);
			if(data == 1){
				alert("수정이 완료되었습니다.");
				location.href = "${contextPath}/prj/board/boardList";}
			else{
				alert("수정을 실패했습니다.");
			}
		},
		error : function(data){
			alert("error")
		}
	})
}

</script>

<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>
	<div class="container">
	
	<input type="hidden" id="writer" name="writer" value="${sessionScope.member.nickname}" readonly="readonly" />
			<input type="text" id="title" name="title"class="form-control mt-4 mb-2" value="${upview.title}">
		<div class="form-group">
			<textarea class="form-control" rows="25" id="content" name="content" style="resize: none;">
			<c:out value="${upview.content}"/></textarea>
		</div>
		<button class="btn btn-default pull-right"
			onClick="updateView()">수정</button>
	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>
</html>