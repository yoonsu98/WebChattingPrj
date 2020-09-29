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
		<form>
			<select name="search">
				<option value="title" selected>제목</option>
				<option value="writer">작성자</option>
			</select> <input type="text" name="search" value="" /> <input type="submit"
				value="검색" />
		</form>
		<table class="table" style="text-align: center;">
			<thead>
				<tr>
					<th class="text-center">번호</th>
					<th class="text-center">제목</th>
					<th class="text-center">작성자</th>
					<th class="text-center">작성일</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>2</td>
					<td>이렇게 할거야!!</td>
					<td>윤수현</td>
					<td>2020-09-25</td>
				</tr>
				<tr>
					<td>1</td>
					<td>이렇게 할거야</td>
					<td>윤수현</td>
					<td>2020-09-24</td>
				</tr>
			</tbody>
		</table>
		<input type="button" class="btn btn-default pull-right"
			onClick="location.href='/prj/board/writeText'" value="글쓰기" />
	</div>

	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>
</html>
