<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>single chatting</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>


<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet">

<style>
<%@ include file="/resources/css/singlechat.css"%>
</style>
	
</head>
 

<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>
	<main>
	<!-- 채팅폼 -->
	<div class="container">
		<div class="msg_history">
			<div id="messageArea">sad<br>asdasdads<br>dasdasdas<br></div> 
         </div>
      <div class="type_msg">
      <div class="input_msg_write">
            <input type="text" class="write_msg" id="message" placeholder="Type a message" />
            <button class="msg_send_btn" type="button" id="sendBtn" onClick="sendMessage()"><i class="fa fa-paper-plane-o" aria-hidden="ture"></i></button>
      </div>
      </div>
     </div>
	</main>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>
</html>
