<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>VideoChattingRoom</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
	
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/custom.css">
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<meta charset="utf-8">
<meta name="description" content="WebRTC code samples">
<meta name="viewport"
	content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=1">
<meta itemprop="description" content="Client-side WebRTC code samples">
<meta itemprop="image" content="../../../images/webrtc-icon-192x192.png">
<meta itemprop="name" content="WebRTC code samples">
<meta name="mobile-web-app-capable" content="yes">
<meta id="theme-color" name="theme-color" content="#ffffff">

<base target="_blank">

<title>getUserMedia</title>
<style>
.chat_div {
	border-style: solid;
	border-width: 2px;
	border-radius: 10px;
	border-color: gray;
	margin-left: 10%;
	margin-right: 10%;
	margin-top: 10px;
	width: 80%;
	height: 30%;
	display: none;
	text-align: left;
	overflow: auto;
}
</style>
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

	<div class="container text-center">
		<h3>FaceTime</h3>
		<video id="localVideo" autoplay width="480px"></video>
		<video id="remoteVideo" autoplay width="480px"></video>
		<div id="chattinglog" style="display:block;" class="chat_div" ></div>
		<br />
		<br />
		<!--WebRTC related code-->
		<br />
		<br /> <input id="messageInput" type="text" 
			class="form-control" placeholder="message"><br />
		<button id="msgbtn" type="button" 
			onClick='sendMessage();'>SEND</button>
		<button id="closebtn" type="button" 
			onClick='sendClose();'>CLOSE</button>
		<!--WebRTC related code-->

	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
	
		<!-- The Modal -->
	<div id="ExitPopup" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<div>
				<span class="close">&times;</span>
				<p>알림</p>
			</div>
			<div id="exitDiv" class="form-group">
			</div>
			<div>
				<button type="button" onClick="directClose();" class="btn btn-default">나가기</button>
			</div>
		</div>

	</div>
	
</body>
<script>

//for WebRTC Connectione
let localStream;
const configuration = {
		  iceServers: [{ url: 'stun:stun2.1.google.com:19302' }]
		}
var friendId ; 
var callee =  new RTCPeerConnection();
var caller = new RTCPeerConnection(configuration);
var dataChannel;
var input = document.getElementById("messageInput");
var localVideo = document.getElementById("localVideo");
var remoteVideo = document.getElementById("remoteVideo");
var exitCount = 5;
//Get the modal
var modal = document.getElementById('ExitPopup');
// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

navigator.getUserMedia({
    video: true,
    audio: false
}, getUserMediaSuccess, getUserMediaError);
//connecting to our signaling server 
var conn = new WebSocket("ws://localhost:8080/prj/socket");
conn.onopen = function() {
    console.log("Connected to the signaling server");
 	let vcno = "${roomInfo.vcno}";
 /*    var setting_data = JSON.stringify({
		vcno : "${roomInfo.vcno}",
		id : '${member.id}'
		}); */
    send({
        event : "enter",
		vcno : "${roomInfo.vcno}",
		id : '${member.id}'
    });
    $('#chattinglog').append("<t/><p> "+'${member.id}'+" 님이 입장하셨습니다.</p>");
    $('#chattinglog').scrollTop($("#chattinglog")[0].scrollHeight);
    initialize();
};
function getUserMediaSuccess(stream) {
    localVideo.srcObject = stream;
    stream.getTracks().forEach(track => {
    caller.addTrack(track, stream);});
}
function getUserMediaError(e){
    console.log(e);
}
conn.onmessage = function(msg) {
    console.log("Got message", msg.data);
    var content = JSON.parse(msg.data);
    var data = content.data;
    switch (content.event) {
    case "chat":
        receiveChat(data,content.id);
        break;
     case "enter":
    	receiveEnter(content.id);
    	debugger;
        break; 
    // when somebody wants to call us -> SDP 정보교환을 위함
    case "offer":
        receiveOffer(data);
        break;
    case "answer":
    	receiveAnswer(data);
        break;
    // when a remote peer sends an ice candidate to us
    case "candidate":
        handleCandidate(data);
        break;
    case "close":
        receiveClose(content.vcid);
        break;
    default:
        break;
    }
};
function send(message) {
	console.log(message);
    conn.send(JSON.stringify(message));
}

async function initialize() {
    // Setup ice handling
    //네트워크 정보 송신을 위함
    caller.onicecandidate = function(event) {
        if (event.candidate) {
            send({
                event : "candidate",
                data : event.candidate
            });
	//caller.addIceCandidate(event.candidate);
        }
    };

}
caller.ontrack = handleCalleeOnTrack;
function handleCalleeOnTrack(event){
	
	remoteVideo.srcObject = event.streams[0];

}

function createOffer() {
	//제안생성
    caller.createOffer(function(offer) {
        send({
            event : "offer",
            data : offer
        });
    caller.setLocalDescription(offer);
	//callee.setRemoteDescription(offer);

    }, function(error) {
        alert("Error creating an offer");
    });
}
function sendClose(){
	send({
        event : "close"
    });
	caller.close();
	caller.onicecandidate=null;
	caller.ontrack=null;
    conn.close();
    location.href= "${pageContext.request.contextPath }/videochatting/videochatList";
}
function receiveChat(chat,id){
	  var hours = (new Date()).getHours();
	   var minutes = (new Date()).getMinutes();

	   if (hours.toString().length==1){
	      hours = '0'+hours;
	   }
	   if (minutes.toString().length==1){
	      minutes = '0'+minutes;
	   }
	   
	   $('#chattinglog').append(' <div class="incoming_msg">'+
	         '<div class="incoming_msg_img">'+
	         '<img src="https://ptetutorials.com/images/user-profile.png" alt="sunil">'+
	         '<p>'+id+'</p>'+
	         '</div>'+
	         ' <div class="received_msg">'+
	         '<div class="received_withd_msg">'+
	         ' <p>'+
	         chat+
	           '</p>'+
	           ' <span class="time_date"> '+
	           hours+':'+minutes+
	           '</span>'+
	           '</div>'+
	           '</div>'+
	           '</div>'
	         )
		
    //$('#chattinglog').append("<t/><p> "+id+":"+ chat+"</p>");
    $('#chattinglog').scrollTop($("#chattinglog")[0].scrollHeight);

}
function receiveEnter(id){

	debugger;
    console.log("Entered successfully!!");
    friendId = id;
    setTimeout(function(){
        createOffer();
      }, 1000);
    $('#chattinglog').append("<t/><p> "+id+" 님이 입장하셨습니다.</p>");
    $('#chattinglog').scrollTop($("#chattinglog")[0].scrollHeight);
	
}
function receiveOffer(sdp){
	caller.setRemoteDescription(new RTCSessionDescription(sdp));
	//callee.setRemoteDescription(sdp);
	createAnswer();
}
function createAnswer(){
	caller.createAnswer(function(answer) {
		caller.setLocalDescription(answer);
        send({
            event : "answer",
            data : answer
        });
    }, function(error) {
        alert("Error creating an answer");
    });

}

function receiveAnswer(sdp){
    caller.setRemoteDescription(new RTCSessionDescription(sdp));
    console.log("connection established successfully!!");
}

function receiveClose(){
	caller.close();
	caller.onicecandidate=null;
	caller.ontrack=null;
	conn.close();
    $('#chattinglog').append("<t/><p> Goodbye! </p>");
    $('#chattinglog').scrollTop($("#chattinglog")[0].scrollHeight);

	removeRoomID();
    modal.style.display = "block";
    //removeRoomID();
    setInterval(function(){
    	exit_Timer();
      }, 1000);
}
function handleCandidate(candidate) {
    caller.addIceCandidate(new RTCIceCandidate(candidate));
};

function sendMessage() {
	var hours = (new Date()).getHours();
	   var minutes = (new Date()).getMinutes();

	   if (hours.toString().length==1){
	      hours = '0'+hours;
	   }
	   if (minutes.toString().length==1){
	      minutes = '0'+minutes;
	   }
	   
		
    send({
        event : "chat",
        data : input.value,
        id : "${member.id}"
    });
    $('#chattinglog').append('<div class="outgoing_msg">'+
            '<div class="sent_msg">'+
            ' <p>'+
            input.value+
            '</p>'+
            ' <span class="time_date"> '+
            hours+':'+minutes+
            '</span>'+
            '</div>'+
            '</div>'
            );
     
    //$('#chattinglog').append("<t/><p> Me: "+input.value+"</p>");
    $('#chattinglog').scrollTop($("#chattinglog")[0].scrollHeight);
    input.value = "";
}


// exit modal pop up 
// When the user clicks on <span> (x), close the modal
span.onclick = function() {
	modal.style.display = "none";
}
function exit_Timer(){
	if(exitCount == 0){
		location.href="${pageContext.request.contextPath }/videochatting/videochatList";;
	}
	$('#exitDiv').html("<t/><p>"+exitCount+" 초 후에 방이 종료됩니다. </p>");
	exitCount = exitCount -1;

}
function directClose(){
	location.href="${pageContext.request.contextPath }/videochatting/videochatList";
}
function removeRoomID(){
 	let vcno = "${roomInfo.vcno}";
	const roomInfo = JSON.stringify({
		vcno : vcno
	});
	console.log(roomInfo);
	$.ajax({
		data : roomInfo,
		url : "${contextPath}/prj/videochatting/deleteRoomInfo",
		type : "post",
		dataType : "text",
		contentType : "application/json; charset=UTF-8",
		success : function(data) {
			console.log(data);
		},
		error : function(data) {
			alert("실패");
		}
	});
	
}
</script>
</html>
