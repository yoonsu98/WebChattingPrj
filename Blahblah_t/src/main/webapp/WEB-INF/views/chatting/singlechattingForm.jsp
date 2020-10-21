<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script type="text/javascript">
 	var ws;
 	//var userid = '${param.id}';
	var userid = '${member.id}';
	
	$(document).ready(function(){
        $("#sendBtn").click(function(){
        	sendMsg();
        });
    });
	
	$(document).ready(function(){
        $("#refresh").click(function(){
        	console.log("새로고침");
        	
        	
        });
    });

	
	//websocket을 지정한 URL로 연결
    var sock= new SockJS("<c:url value="/echo"/>");
    //websocket 서버에서 메시지를 보내면 자동으로 실행된다.
    sock.onmessage = addMsg;
    //websocket 과 연결을 끊고 싶을때 실행하는 메소드
    sock.onclose = onClose;
	sock.onopen = onOpen;
	
    function onOpen(evt){
    	    
		$("#msgArea").append("연결됨<br/>");
		register();
	}

 	function addMsg(msg){
		var data = msg.data;
		$('#msgArea').append(data+"<br/>");
 	 	
 	}
 	
	function register(){
		var msg = {
				type : 'register',
				userid : '${member.id}'
		};
		sock.send(JSON.stringify(msg));
	}

	function sendMsg(){
		console.log("메세지 보냄");
		var msg = {
			type : 'chat',
			target :  $("#targetUser").val(),
			message : $("#chatMsg").val()

		};

		if($("#chatMsg").val()==""){
        	alert("메시지를 입력해주세요.");
        }
        else{
        	$('#msgArea').append($("#chatMsg").val()+"<br/>");
    		sock.send(JSON.stringify(msg));
        }
       
		
		};
	function onClose(evt){
		$("#msgArea").append("연결 끊김");
	}
    
    
</script>

    
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
			<div id="msgArea"></div>
         </div>
      <div class="type_msg">
      <div class="input_msg_write">
            <input type="text" class="write_msg" id="chatMsg" placeholder="Type a message" />
            <input type ="text" id="targetUser">
            
            <button class="msg_send_btn" type="button" id="sendBtn"><i class="fa fa-paper-plane-o" aria-hidden="ture"></i></button>
      </div>
      </div>
     </div>
	</main>
	
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>
</html>
