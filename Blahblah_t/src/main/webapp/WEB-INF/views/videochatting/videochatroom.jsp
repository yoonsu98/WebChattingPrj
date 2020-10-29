<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>VideoChattingRoom</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
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
</head>
<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>

	<div class="container text-center">
		<h3>FaceTime</h3>
		<video id="localVideo" autoplay width="480px"></video>
		<video id="remoteVideo"
		 style="display:none;" autoplay width="480px"></video>
		<div id="chattinglog" class="chat_div"></div>
		<br />
		<br />
		<!--WebRTC related code-->
		<button id="connectbtn" type="button" onClick='createOffer();'>
			접속하기</button>
		<br />
		<br /> <input id="messageInput" type="text" style="display: none;"
			class="form-control" placeholder="message"><br />
		<button id="msgbtn" type="button" style="display: none;"
			onClick='sendMessage();'>SEND</button>
		<!--WebRTC related code-->

	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>
<script>

//for WebRTC Connectione
let localStream;
var callee =  new RTCPeerConnection();
var caller = new RTCPeerConnection();
var dataChannel;
var input = document.getElementById("messageInput");
var localVideo = document.getElementById("localVideo");
var remoteVideo = document.getElementById("remoteVideo");
//connecting to our signaling server 
var conn = new WebSocket("ws://localhost:8080/prj/socket");
conn.onopen = function() {
    console.log("Connected to the signaling server");
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
    // when somebody wants to call us -> SDP 정보교환을 위함
    case "offer":
        sendOffer(data);
        break;
    case "answer":
        sendAnswer(data);
        break;
    // when a remote peer sends an ice candidate to us
    case "candidate":
        handleCandidate(data);
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
	caller.addIceCandidate(event.candidate);
        }
    };
    navigator.getUserMedia({
        video: true,
        audio: false
    }, getUserMediaSuccess, getUserMediaError);
    //상대방(원격)이 datachannel을 생성했을 때 발생하는 이벤트에 대한 핸들러
        caller.ondatachannel = function(event) {
        var receiveChannel = event.channel;
        receiveChannel.onmessage = function(event) {
           console.log("ondatachannel message:", event.data);
           $('#chattinglog').append("<t/><p> New Friend: "+event.data+"</p>");
           $('#chattinglog').scrollTop($("#chattinglog")[0].scrollHeight);
        };
     };
   
    // creating data channel
    dataChannel = caller.createDataChannel("dataChannel", {
        reliable : true
    });

    dataChannel.onerror = function(error) {
        console.log("Error occured on datachannel:", error);
    };

    // when we receive a message from the other peer, printing it on the console
    dataChannel.onmessage = function(event) {
        console.log("message:", event.data);
    };

    dataChannel.onclose = function() {
        console.log("data channel is closed");
    };

}
caller.ontrack = handleCalleeOnTrack;
function handleCalleeOnTrack(event){
	remoteVideo.srcObject = event.streams[0];
	remoteVideo.onloadedmetadata = function(e) {
		remoteVideo.play();
	  };

}

function createOffer() {
	//제안생성

    caller.createOffer(function(offer) {
        send({
            event : "offer",
            data : offer
        });
    caller.setLocalDescription(offer);
	callee.setRemoteDescription(offer);

    }, function(error) {
        alert("Error creating an offer");
    });
}
function sendOffer(sdp){
	caller.setRemoteDescription(new RTCSessionDescription(sdp));
	callee.setRemoteDescription(sdp);
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
function createAnswerSuccess(sdp){
    callee.setLocalDescription(sdp);
    sendAnswer(sdp)// send SDP to Caller
}

function sendAnswer(sdp){
    caller.setRemoteDescription(sdp);
    console.log("connection established successfully!!");
    jQuery('#remoteVideo').show();
    jQuery('#messageInput').show();
    jQuery('#msgbtn').show();
    jQuery('#chattinglog').show();
    $('#connectbtn').css("display","none");
}
/* function handleOffer(offer) {
	//지정된 세션에 대한 설명 
    peerConnection.setRemoteDescription(new RTCSessionDescription(offer));

    // create and send an answer to an offer
    peerConnection.createAnswer(function(answer) {
        peerConnection.setLocalDescription(answer);
        send({
            event : "answer",
            data : answer
        });
    }, function(error) {
        alert("Error creating an answer");
    });

}; */

function handleCandidate(candidate) {
    callee.addIceCandidate(new RTCIceCandidate(candidate));
};

/* function handleAnswer(answer) {
    peerConnection.setRemoteDescription(new RTCSessionDescription(answer));
    console.log("connection established successfully!!");
    jQuery('#remoteVideo').show();
    jQuery('#messageInput').show();
    jQuery('#msgbtn').show();
    jQuery('#chattinglog').show();
    $('#connectbtn').css("display","none");
     const remoteStream = new  MediaStream();
    const remoteVideo = document.querySelector('#remoteVideo');
    remoteVideo.srcObject = remoteStream;

    peerConnection.addEventListener('track', async (answer) => {
        remoteStream.addTrack(answer.track, remoteStream);
    });  
    
}; */
//생성된 datachannel에 데이터보내기
function sendMessage() {
    dataChannel.send(input.value);
    $('#chattinglog').append("<t/><p> Me: "+input.value+"</p>");
    $('#chattinglog').scrollTop($("#chattinglog")[0].scrollHeight);
    input.value = "";
}
</script>
</html>
