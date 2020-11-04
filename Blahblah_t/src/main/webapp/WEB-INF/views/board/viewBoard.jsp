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
	}
	
	function insertComment(){
		let bnum = document.getElementById('pnum').value;
		let cid = document.getElementById('nickname').value;
		let reply = document.getElementById('commentContent').value;	
		const commentInfo = JSON.stringify({bnum:bnum, cid:cid,reply:reply});
		$.ajax({
			data : commentInfo,
			url : "${contextPath}/prj/board/insertComment",
			type : "post",
			dataType : "text",
			contentType : "application/json; charset = UTF-8",
			success : function(data){
				console.log(data);
				if(data == 1){
					alert("등록이 완료되었습니다.");
					location.href = "${contextPath}/prj/board/viewBoard/"+bnum;}
				else{
					alert("등록을 실패했습니다.");
				}
			},
			error:function(request,status,error){
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			   }
		})
	}
	
	function deleteComment(cnum){
		location.href="${contextPath}/prj/board/deleteComment?cnum="+cnum;
		alert("삭제되었습니다.");
		location.href="${contextPath}/prj/board/boardList";
		}
	
	function modifyComment(cnum) {
		let comment = document.getElementById('modalContent').value;
		const commentInfo = JSON.stringify({cnum:cnum, comment:comment
		});
		$.ajax({
			data : commentInfo,
			url : "${contextPath}/prj/board/modifyComment",
			type : "POST",
			dataType : "text",
			contentType : "application/json; charset = UTF-8",
			success : function(data) {
				console.log(data);
				if (data == 1) {
					alert("수정이 완료되었습니다.");
					location.href = "${contextPath}/prj/board/boardList";
				} else {
					alert("수정을 실패했습니다.");
				}
			},
			 error:function(request,status,error){
				    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				   }
		})
	}
	
	function replyComment(cnum){
		let bnum = document.getElementById('rpnum').value;
		let cid = document.getElementById('rnickname').value;
		let reply = document.getElementById('modalReplyContent').value;	
		let parent = document.getElementById('parent').value;

		const commentInfo = JSON.stringify({bnum:bnum, cid:cid,reply:reply,parent:parent});
		$.ajax({
			data : commentInfo,
			url : "${contextPath}/prj/board/replyComment",
			type : "post",
			dataType : "text",
			contentType : "application/json; charset = UTF-8",
			success : function(data){
				console.log(data);
				if(data == 1){
					alert("등록이 완료되었습니다.");
					location.href = "${contextPath}/prj/board/viewBoard/"+bnum;}
				else{
					alert("등록을 실패했습니다.");
				}
			},
			error:function(request,status,error){
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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
		<c:if test="${sessionScope.member.nickname eq view.writer }">
			<input type="button" class="btn btn-default pull-left"
				onClick="updateView(${view.pnum })" value="수정하기" />
			<input type="button" class="btn btn-default pull-left"
				onclick="deleteView(${view.pnum})" value="삭제하기" />
		</c:if>
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
			<tr height="500px">
				<th class="text-center" colspan="3">${view.content }</th>
			</tr>
		</table>
	</div>

	<!--  댓글  -->
	<div class="container">
		<table class="table" border="1" style="text-align: center;">
			<c:forEach items="${replyList}" var="replyList">
				<tr>
					<c:if test="${replyList.depth == 0 }">
						<th class="text-center">${replyList.reply }</th>
					</c:if>
					<c:if test="${replyList.depth ne 0 }">
						<th class="text-center">-> ${replyList.reply }</th>
					</c:if>
					<th class="text-center" width="200px">${replyList.cid }</th>
					<th class="text-center" width="200px">${replyList.cdate }</th>

					<td align="center" width="80px"><c:if
							test="${sessionScope.member.nickname eq replyList.cid }">
							<button type="button"
								onclick="openCommentModal(${replyList.cnum}, '${replyList.reply}' )"
								class="btn btn-xs btn-circle">
								<i class="glyphicon glyphicon-pencil" aria-hidden="true"></i>
							</button>
							<button type="button"
								onClick="openReplyModal(${replyList.cnum},${replyList.parent})"
								class="btn btn-xs btn-circle">
								<i class="glyphicon glyphicon-hand-right" aria-hidden="true"></i>
							</button></c:if></td>
				</tr>
			</c:forEach>
		</table>
	</div>

	<div class="container">
		<label for="content">comment</label>
		<div class="input-group">
			<input type="hidden" name="pnum" id="pnum" value="${view.pnum}" /> <input
				type="hidden" name="nickname" id="nickname"
				value="${sessionScope.member.nickname}" /> <input type="text"
				class="form-control" id="commentContent" name="commentContent"
				placeholder="내용을 입력하세요."> <span class="input-group-btn">
				<button type="button" class="btn btn-default pull-right"
					onClick="insertComment()">등록</button>
			</span>
		</div>
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

	<!-- Modal -->
	<div id="commentModal" class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="commentModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="modalContent" class="col-form-label">내용</label>
							<textarea id="modalContent" class="form-control"
								placeholder="내용을 입력해 주세요." style="resize: none;"></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" id="btnCommentModify" class="btn btn-default"
						onclick="modifyComment()">수정하기</button>
					<button type="button" id="btnCommentDelete" class="btn btn-default">삭제하기</button>
					<button type="button" id="btnModalCancel" class="btn btn-default"
						data-dismiss="modal">취소하기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div id="replyModal" class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="commentModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<c:forEach items="${replyList}" var="replyList">
								<input type="hidden" name="rpnum" id="rpnum"
									value="${view.pnum}" />
								<input type="hidden" name="rnickname" id="rnickname"
									value="${sessionScope.member.nickname}" />
								<input type="hidden" name="parent" id="parent"
									value="${replyList.parent }" />
							</c:forEach>
							<label for="modalReplyContent" class="col-form-label">내용</label>
							<textarea id="modalReplyContent" class="form-control"
								placeholder="내용을 입력해 주세요." style="resize: none;"></textarea>

						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" id="btnReplyComment" class="btn btn-default"
						onclick="replyComment()">답글달기</button>
					<button type="button" id="btnModalCancel" class="btn btn-default"
						data-dismiss="modal">취소하기</button>
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

<script>
	function openCommentModal(cnum, comment) {

		$("#commentModal").modal("toggle");

		document.getElementById("modalContent").value = comment;

		document.getElementById("btnCommentModify").setAttribute("onclick", "modifyComment("+ cnum +")");
		document.getElementById("btnCommentDelete").setAttribute("onclick", "deleteComment("+ cnum +")");
	}
</script>

<script>
	function openReplyModal(cnum, parent) {

		$("#replyModal").modal("toggle");

		document.getElementById("parent").value = parent;
		
		document.getElementById("btnReplyComment").setAttribute("onclick", "replyComment("+ cnum + ")");
	}
</script>

</html>