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

<script type="text/javascript" src="http://www.google.com/jsapi"></script>
 
 
<script type="text/javascript">

 	var ws;
	var userid = '${member.id}';

	
	$(document).ready(function(){
        $("#chatMsg").keypress(function (e){
        	if (e.which == 13){
        		sendMsg()
        		$("#chatMsg").val('');	
	        }
        });

        $("#sendBtn").click(function(){
        	sendMsg()
    		$("#chatMsg").val('');	
        	
        });
     
        $("#transBtn").click(function(){

     
        	let aft_transchat;
       		let chat = document.getElementById('chatMsg').value;
       		const bef_transchat = JSON.stringify({chat:chat}); 

       	   	$.ajax({
       			url:"${contextPath}/prj/chatting/getTransChat" ,
       			type: "post",
       			data: bef_transchat,
       			async:false,
       			dataType: "json",
       			contentType:"application/json",
       			success: function(data){
           			aft_transchat = data.trans_chat;
       			},
       			error: function(errorThrown){
           			
       				alert(errorThrown.statusText);
       			}
       	   	})
       	 	$("#chatMsg").val(aft_transchat);
 	
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
		//$("#msgArea").append(userid+"님이 입장하셨습니다.<br/>");
		register();
	}

 	function addMsg(msg){
 		
 		var hours = (new Date()).getHours();
		var minutes = (new Date()).getMinutes();
		if (hours.toString().length==1){
			hours = '0'+hours;
		}
		if (minutes.toString().length==1){
			minutes = '0'+minutes;
		}
		var data = msg.data;
		//$('#msgArea').append(data+"<br/>");

		$('#msgArea').append(' <div class="incoming_msg">'+
				'<div class="incoming_msg_img">'+
				'<img src="https://ptetutorials.com/images/user-profile.png" alt="sunil">'+
				'<p>${recv_id}</p>'+
				'</div>'+
				' <div class="received_msg">'+
				'<div class="received_withd_msg">'+
				' <p>'+
				data+
            	'</p>'+
            	' <span class="time_date"> '+
            	hours+':'+minutes+
            	'</span>'+
            	'</div>'+
            	'</div>'+
            	'</div>'
				)
		$("#msg_his").scrollTop($("#msg_his")[0].scrollHeight);
	
 	}
 	
	function register(){
		var msg = {
				type : 'register',
				userid : '${member.id}'
		};
		sock.send(JSON.stringify(msg));
	}

	function sendMsg(){
		var hours = (new Date()).getHours();
		var minutes = (new Date()).getMinutes();

		if (hours.toString().length==1){
			hours = '0'+hours;
		}
		if (minutes.toString().length==1){
			minutes = '0'+minutes;
		}
		
		var msg = {
			type : 'chat',
			target :  '${recv_id}',
			message : $("#chatMsg").val()

		}

		if($("#chatMsg").val()==""){
        	alert("메시지를 입력해주세요.");
        }
        else{
        	
        	$('#msgArea').append('<div class="outgoing_msg">'+
                	'<div class="sent_msg">'+
                	' <p>'+
                	$("#chatMsg").val()+
                	'</p>'+
                	' <span class="time_date"> '+
                	hours+':'+minutes+
                	'</span>'+
                	'</div>'+
                	'</div>'
                	);
        	
        	
    		sock.send(JSON.stringify(msg));
    	
        }
       
		
	};
	function onClose(evt){
		$("#msgArea").append(userid+"님이 퇴장하셨습니다.<br/>");
	}


</script>
</head>

<body>
	<span class="notranslate">
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>
	</span>
	<!-- 채팅폼 -->
	<div class="container">
	<h3 class=" text-center">Messaging</h3>
	<div id="google_translate_element"></div>
	
	<div class="messaging">
      <div class="inbox_msg">
          
        <div class="mesgs">
          <div class="msg_history" id="msg_his">
          	<div id="msgArea"></div>
 
          </div>
          <div class="type_msg">
            <div class="input_msg_write">
              <input type="text" class="write_msg" id="chatMsg" placeholder="Type a message" />
              <button class="translate_btn" type="button"  id="transBtn" >Eng</button>
              <button class="msg_send_btn"  id="sendBtn"><i class="fa fa-paper-plane-o" aria-hidden="true"></i></button>
            </div>
          </div>
        </div>
      </div>
    </div></div>
    <span class="notranslate">
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
	</span>
</body>
</html>

<script>
	function googleTranslateElementInit() {
		new google.translate.TranslateElement({
			pageLanguage: 'ko',	
			includedLanguages: 'ko,zh-CN,zh-TW,ja,vi,th,tl,km,my,mn,ru,en,fr,ar',
			layout: google.translate.TranslateElement.InlineLayout.SIMPLE,
			autoDisplay: false
		}, 'google_translate_element');
	}
</script>
<script src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>