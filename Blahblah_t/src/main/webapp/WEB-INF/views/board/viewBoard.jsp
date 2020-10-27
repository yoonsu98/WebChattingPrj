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
		location.href="${contextPath}/prj/board/deleteView?pnum="+pnum;
		alert("삭제되었습니다.");
		location.href="${contextPath}/prj/board/boardList";
		
	function danMem(){
		alert("오키");
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
			<input type="hidden" id="writer" name="writer" value="${view.writer}"
				readonly="readonly" />
			<button class="btn btn-default pull-left" data-toggle="modal"
				data-target="#praiseModal">칭찬하기</button>
			<button class="btn btn-default pull-left" data-toggle="modal"
				data-target="#danModal">신고하기</button>
		</c:if>
	</div>


	<div class="container">
		<c:if test="${sessionScope.member.nickname eq view.writer }">
			<input type="button" class="btn btn-default pull-left"
				onClick="updateView(${view.pnum })" value="수정하기" />
			<input type="button" class="btn btn-default pull-left"
				onclick="deleteView(${view.pnum})" value="삭제하기" />
		</c:if>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="praiseModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<input type="text" class="form-control" id="praiseReason"
						name="praiseReason" placeholder="칭찬하는 이유가 무엇인가요?"></input>
				</div>
				<div class="modal-footer">
					<button type="button" id="praiseBtn" onClick="praiseMem()"
						class="btn btn-primary">칭찬하기</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소하기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="danModal" role="dialog">
		<!-- 사용자 지정 부분① : id명 -->
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">×</button>
					<!-- 사용자 지정 부분② : 타이틀 -->
				</div>
				<div class="modal-body">
					<input type="text" class="form-control" id="danReason"
						name="danReason" placeholder="신고하는 이유가 무엇인가요?">
					<!-- 사용자 지정 부분③ : 텍스트 메시지 -->
				</div>
				<div class="modal-footer">
					<button type="button" id="danBtn" class="btn btn-default"
						onClick="danMem()">신고하기</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소하기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>

<script>
	// Get the modal
	var modal = document.getElementById('praiseModal');
	// Get the button that opens the modal
	var btn = document.getElementById("praiseBtn");
	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];
	// When the user clicks on the button, open the modal 
	/* 	btn.onclick = function() {
		modal.style.display = "block";
	} */
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

	function praiseMem(){
		modal.style.display = "none";
		let nickname = document.getElementById('writer').value;
		var praiseComment = $('#praiseReason');

		if (praiseComment.val() == "") {
			alert("입력해주세요.");
			return;
		}
		else{
		location.href= "${contextPath}/prj/board/praiseMem?nickname="+nickname;
		alert("의견 감사합니다.");
		location.href= "${contextPath}/prj/board/boardList";
		}
	}
</script>

<script>
	// Get the modal
	var modal = document.getElementById('danModal');
	// Get the button that opens the modal
	var btn = document.getElementById("danBtn");
	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];
	// When the user clicks on the button, open the modal 
	/* 	btn.onclick = function() {
		modal.style.display = "block";
	} */
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

	function danMem(){
		modal.style.display = "none";
		let nickname = document.getElementById('writer').value;
		var danComment = $('#danReason');

		if (danComment.val() == "") {
			alert("입력해주세요.");
			return;
		}
		else{
		location.href= "${contextPath}/prj/board/danMem?nickname="+nickname;
		alert("의견 감사합니다.");
		location.href= "${contextPath}/prj/board/boardList";
		}
	}
</script>
</html>
