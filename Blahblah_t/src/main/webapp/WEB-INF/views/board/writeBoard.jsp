
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>Post</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

</head>

<script>
	function writeTextToTheBoard(){
		let writer = document.getElementById("writer").value;
		let title = document.getElementById("title").value;
		let content = document.getElementById("content").value;
		
		const writeBoardInfo = JSON.stringify({writer:writer, title:title,content:content});

		$.ajax({
			data : writeBoardInfo,
			url : "${contextPath}/prj/board/writeTextBoard",
			type : "post",
			dataType : "text",
			contentType : "application/json; charset = UTF-8",
			success : function(data){
				console.log(data);
				if(data == 1){
					alert("등록이 완료되었습니다.");
					location.href = "${contextPath}/prj/board/boardList";}
				else{
					alert("등록을 실패했습니다.");
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
		<input type="text" id = "title" name="title" class="form-control mt-4 mb-2" placeholder="제목을 입력해주세요.">
		<div class="form-group">
			<textarea class="form-control" rows="25" id = "content" name="content"
				placeholder="여기를 눌러서 글을 작성할 수 있습니다." style="resize: none;"></textarea>
		</div>
		<button class="btn btn-default pull-right"
			onClick="writeTextToTheBoard()">등록</button>
	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>
</html>
