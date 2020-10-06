<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Home</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>
	<!-- main -->
	<div class="container text-center">
		<table class="table" style="text-align: center;">
		 <caption>follower</caption>
			<thead>
				<tr>
					<th class="text-center">NickName</th>
					<th class="text-center">photo</th>
					<th class="text-center">country</th>
				</tr>
<%-- 				<c:forEach var="board" items="${list}">
					<tr>
						<th class="text-center">${board.pnum }</th>
						<th class="text-center"><a href="viewBoard/${board.pnum}">${board.title }</a></th>
						<th class="text-center">${board.writer }</th>
						<th class="text-center">${board.rcnt }</th>
						<th class="text-center">${board.wdate }</th>
					</tr>
				</c:forEach> --%>
			</thead>
		</table>
	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>

</body>
</html>