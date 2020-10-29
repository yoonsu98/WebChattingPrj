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
    <meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=1">
    <meta itemprop="description" content="Client-side WebRTC code samples">
    <meta itemprop="image" content="../../../images/webrtc-icon-192x192.png">
    <meta itemprop="name" content="WebRTC code samples">
    <meta name="mobile-web-app-capable" content="yes">
    <meta id="theme-color" name="theme-color" content="#ffffff">

    <base target="_blank">

    <title>getUserMedia</title>
<style>
.chat_div{
	border-style:solid;
	border-width:2px;
	border-radius: 10px;
	border-color:gray;
	margin-left:10%; 
	margin-right:10%; 
	margin-top:10px; 
	width: 80%; 
	height:30%; 
	display:none;
	text-align:left;
	overflow: auto;
}
</style>
</head>
<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>
 
	<div class="container text-center" >
  <h3>
	FaceTime
  </h3>
        <video id="localVideo"  autoplay width="480px"></video>
        <video id="remoteVideo" style="display:none;"  width="480px" autoplay></video>
 <div id="chattinglog" class="chat_div">
 </div>
 <br/><br/>
  <!--WebRTC related code-->
  <button id="connectbtn" type="button"  onClick='createOffer();'>
   접속하기</button><br/><br/>
  <input id="messageInput" type="text" style="display:none;" class="form-control"
   placeholder="message"><br/>
  <button id="msgbtn" type="button"  style="display:none;" onClick='sendMessage();'>SEND</button>
  <!--WebRTC related code-->

 </div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>
<script>
const constraints = window.constraints = {
		  audio: false,
		  video: true
		};
//connecting to our signaling server 
var conn = new WebSocket("ws://localhost:8080/prj/socket");
conn.onopen = function() {
    console.log("Connected to the signaling server");
    initialize();
};
conn.onmessage = function(msg) {
    console.log("Got message", msg.data);
    var content = JSON.parse(msg.data);
    var data = content.data;
    switch (content.event) {
    // when somebody wants to call us -> SDP 정보교환을 위함
    case "offer":
        handleOffer(data);
        break;
    case "answer":
        handleAnswer(data);
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

// for WebRTC Connection
var peerConnection;
var dataChannel;
var input = document.getElementById("messageInput");

async function initialize() {
	//사용자 media stream 가져오기
	const localStream = await navigator.mediaDevices.getUserMedia(constraints);
	//사용자 media stream을 local video에 출력
	handleSuccess(localStream);
    var configuration = null;
	//rtc 연결을 위한 peer connection 생성
    peerConnection = new RTCPeerConnection(configuration);
    //localStream을 tracking하기 위함
    localStream.getTracks().forEach(track => {
        peerConnection.addTrack(track, localStream);
    });
    //상대 (remote)/원격 stream을 받아와서 remoteVideo에 출력
    const remoteStream = new MediaStream();
    const remoteVideo = document.querySelector('#remoteVideo');
    remoteVideo.srcObject = remoteStream;
    peerConnection.addEventListener('track', async (event) => {
        remoteStream.addTrack(event.track, remoteStream);
    });
    // Setup ice handling
    //네트워크 정보 송신을 위함
    peerConnection.onicecandidate = function(event) {
        if (event.candidate) {
            send({
                event : "candidate",
                data : event.candidate
            });
        }
    };
    //상대방(원격)이 datachannel을 생성했을 때 발생하는 이벤트에 대한 핸들러
    peerConnection.ondatachannel = function(event) {
        var receiveChannel = event.channel;
        receiveChannel.onmessage = function(event) {
           console.log("ondatachannel message:", event.data);

           $('#chattinglog').append("<t/><p> New Friend: "+event.data+"</p>");
           $('#chattinglog').scrollTop($("#chattinglog")[0].scrollHeight);
        };
        
     };
   
    // creating data channel
    dataChannel = peerConnection.createDataChannel("dataChannel", {
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
function handleSuccess(stream) {
	//local 사용자 media 정보를 localvideo에 출력
	  const video = document.querySelector('#LocalVideo');
	  const videoTracks = stream.getVideoTracks();
	  console.log('Got stream with constraints:', constraints);
	  console.log(`Using video device: ${videoTracks[0].label}`);
	  window.stream = stream; // make variable available to browser console
	  video.srcObject = stream;
	}
function createOffer() {
	//제안생성
    peerConnection.createOffer(function(offer) {
        send({
            event : "offer",
            data : offer
        });
        peerConnection.setLocalDescription(offer);
    }, function(error) {
        alert("Error creating an offer");
    });
}

function handleOffer(offer) {
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

};

function handleCandidate(candidate) {
    peerConnection.addIceCandidate(new RTCIceCandidate(candidate));
};

function handleAnswer(answer) {
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
    
};
//생성된 datachannel에 데이터보내기
function sendMessage() {
	
    dataChannel.send(input.value);
    $('#chattinglog').append("<t/><p> Me: "+input.value+"</p>");

    $('#chattinglog').scrollTop($("#chattinglog")[0].scrollHeight);
    input.value = "";
}
</script>
</html>