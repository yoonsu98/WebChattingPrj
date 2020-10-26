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

	function praiseMem(){
			alert("오키");

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
	<div class="modal fade" id="praiseModal" role="dialog">
		<!-- 사용자 지정 부분① : id명 -->
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">×</button>
					<!-- 사용자 지정 부분② : 타이틀 -->
				</div>
				<div class="modal-body">
					<input type="text" class="form-control" id="praiseReason"
						name="praiseReason" placeholder="칭찬하는 이유가 무엇인가요?">
					<!-- 사용자 지정 부분③ : 텍스트 메시지 -->
				</div>
				<div class="modal-footer">
					<a id="praiseBtn" type = "button" class="btn btn-default" onClick="praiseMem()">칭찬하기</a>
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
						name="danReason" placeholder="신고하는하는 이유가 무엇인가요?">
					<!-- 사용자 지정 부분③ : 텍스트 메시지 -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" onClick="danMem()">칭찬하기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>
</html>
