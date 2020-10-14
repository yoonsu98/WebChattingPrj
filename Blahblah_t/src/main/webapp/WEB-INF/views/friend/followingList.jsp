<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Home</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

<script>
console.log("dd");
console.log(${followingList});
</script>
</head>
<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>
	<!-- main -->
	<div class="container text-center">
		<table class="table" style="text-align: center;">
		 <caption>following list</caption>
			<thead>
				<tr>
					<th class="text-center">id</th>
					<th class="text-center">nickname</th>
					<th class="text-center">country</th>
				</tr>
 				<c:forEach var="member" items="${followingList}">
					<tr>
						<th class="text-center">${member.id }</th>
						<th class="text-center">${member.nickname }</th>
					</tr>
				</c:forEach>
			</thead>
		</table>
	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>

</body>
</html>