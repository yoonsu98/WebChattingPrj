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
	function updateView(pnum){
		location.href = "${contextPath}/prj/board/updateViewForm?pnum="+pnum;
		}
	
function deleteView(pnum){
	let title = document.getElementById("title").value;
	let content = document.getElementById("content").value;
	
	const boardInfo = JSON.stringify({title:title,content:content});

	$.ajax({
		data :boardInfo,
		url : "${contextPath}/prj/board/deleteView",
		type : "post",
		dataType : "text",
		contentType : "application/json; charset = UTF-8",
		success : function(data){
			console.log(data);
			if(data == 1){
				alert("삭제가 완료되었습니다.");
				location.href = "${contextPath}/prj/board/boardList";}
			else{
				alert("삭제를 실패했습니다.");
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
		<table class="table" border="1" style="text-align: center;">
			<tr>
				<th class="text-center">글번호 : ${view.pnum }</th>
				<th class="text-center" colspan="2">제목 : ${view.title }</th>
			</tr>
			<tr>
				<th class="text-center">작성자 : ${view.writer }</th>
				<th class="text-center">조회수 : ${view.rcnt }</th>
				<th class="text-center">작성일 : ${view.wdate }</th>
			</tr>
			<tr>
				<th class="text-center" colspan="3">${view.content }</th>
			</tr>
		</table>
	</div>
	<div class="container">
		<input type="button" class="btn btn-default pull-right"
			onClick="location.href='/prj/board/boardList'" value="목록" />
		<c:if
			test="${!empty sessionScope.member && sessionScope.member.nickname ne view.writer }">
			<input type="button" class="btn btn-default pull-left" value="칭찬하기" />
			<input type="button" class="btn btn-default pull-left" value="신고하기" />
		</c:if>
	</div>

	<div class="container">
		<c:if test="${sessionScope.member.nickname eq view.writer }">
			<input type="button" class="btn btn-default pull-left"
				onClick="updateView(${view.pnum })" value="수정하기" />
			<input type="button" class="btn btn-default pull-left" value="삭제하기" />
		</c:if>


	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>
</html>
