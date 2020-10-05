<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
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
				onClick="location.href='/prj/board/boardList'" value="목록"/>
		<c:if test="${!empty sessionScope.member }">
			<input type="button" class="btn btn-default pull-right" value="칭찬하기" />
			<input type="button" class="btn btn-default pull-right" value="신고하기" />
		</c:if>
	</div>

	<div class="container">
		<c:if test="${sessionScope.member.nickname eq view.writer }">
			<input type="button" class="btn btn-default pull-right" value="수정하기" />
			<input type="button" class="btn btn-default pull-right" value="삭제하기" />
		</c:if>


	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>
</html>
