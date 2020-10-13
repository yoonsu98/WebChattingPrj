<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<html>
<head>
<meta charset="UTF-8">
<title>chatting</title>
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
	
	<div class="container text-center" >
		<br><br><br>
		<button type="submit" class="btn btn-primary btn-lg" onClick="location.href='/prj/chatting/singlechattingForm'" 
		style="height:100px; width:200px;">1:1 chatting</button>
		<button type="submit" class="btn btn-primary btn-lg" style="height:100px; width:200px;">1:n chatting</button>
		<br><br><br>
	</div>
	
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
	
</body>
</html>