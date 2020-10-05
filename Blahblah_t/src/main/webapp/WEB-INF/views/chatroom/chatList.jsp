<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Home</title>
<style>
.panel-title {
	text-align: center;
}
</style>
</head>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
</script>
<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>
	
	<main>
		<div class="container">
			<ul class="list-group">
				<li class="list-group-item">방제목<span class="badge">접속자</span><span class="badge">아이디</span></li>
				<c:forEach var="row" items="${list }">
				<li class="list-group-item"><a href="#">${row.title }</a><span class="badge">0</span><span class="badge">${row.id }</span></li>
				</c:forEach>
			</ul>
		<button type="button" class="btn btn-primary" onClick="location.href='${pageContext.request.contextPath}/service/chat/add'">방생성</button>
		</div>
	</main>

	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>

</body>
</html>