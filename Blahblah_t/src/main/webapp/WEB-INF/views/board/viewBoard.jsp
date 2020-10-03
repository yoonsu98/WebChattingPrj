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
		<input type="button" class="btn btn-default pull-right" value="칭찬하기" />
		<input type="button" class="btn btn-default pull-right" value="신고하기" />
		<table class="table table-bordered" style="text-align: center;">
			<tr>
				<td colspan="6">이렇게 할거야</td>
			</tr>
			<tr>
				<td bgcolor="skyblue">작성자</td>
				<td>윤수현</td>
				<td bgcolor="skyblue">작성일</td>
				<td>2020-09-24</td>
				<td bgcolor="skyblue">조회수</td>
				<td>912</td>
			</tr>

		</table>
		<input type="button" class="btn btn-default pull-right"
			onClick="location.href='/prj/board/boardForm'" value="뒤로" />
	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>
</html>
