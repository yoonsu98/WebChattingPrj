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

<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>

	<div class="container">
		<form>
			<select name="search">
				<option value="title" selected>제목</option>
				<option value="content">내용</option>
				<option value="writer">작성자</option>
			</select> <input type="text" name="search" value="" />
			<button onClick="#">검색</button>
		</form>
		<table class="table" style="text-align: center;">
			<thead>
				<tr>
					<th class="text-center">번호</th>
					<th class="text-center">제목</th>
					<th class="text-center">작성자</th>
					<th class="text-center">조회수</th>
					<th class="text-center">작성일</th>
				</tr>
				<c:forEach var="board" items="${list}">
					<tr>
						<th class="text-center">${board.pnum }</th>
						<th class="text-center"><a href="viewBoard/${board.pnum}">${board.title }</a></th>
						<th class="text-center">${board.writer }</th>
						<th class="text-center">${board.rcnt }</th>
						<th class="text-center">${board.wdate }</th>
					</tr>
				</c:forEach>
			</thead>
		</table>
		<form method="post" action="loginWriteBoard" encType="UTF-8">
			<input type="submit" class="btn btn-default pull-right" value="글쓰기" />
		</form>

	</div>

	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>
</html>
