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
		<table class="table" style="text-align: center;">
			<thead>
				<tr>
					<th class="text-center">번호</th>
					<th class="text-center">제목</th>
					<th class="text-center">작성자</th>
					<th class="text-center">조회수</th>
					<th class="text-center">작성일</th>
					<th class="text-center">내용</th>
				</tr>
					<tr>
						<th class="text-center">${view.pnum }</th>
						<th class="text-center">${view.title }</th>
						<th class="text-center">${view.writer }</th>
						<th class="text-center">${view.rcnt }</th>
						<th class="text-center">${view.wdate }</th>
						<th class="text-center">${view.content }</th>
					</tr>
			</thead>
		</table>

	<div class="container">
		<input type="button" class="btn btn-default pull-right" value="칭찬하기" />
		<input type="button" class="btn btn-default pull-right" value="신고하기" />
		<input type="button" class="btn btn-default pull-right"
			onClick="location.href='/prj/board/boardList'" value="목록" />
	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>
</html>
