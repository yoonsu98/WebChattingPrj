<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>웹소켓 채팅</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.js"></script>
<script type="text/javascript">
	window.onload = function() {
		$('#message').focus();
	}
	var webSocket = {
		init : function(param) {
			this._url = param.url;
			this._initSocket();
		},
		sendChat : function() {
			this._sendMessage('${param.bang_id}', 'CMD_MSG_SEND', $('#message')
					.val(), $('#userid').val());
			cmmd($('#message').val());
			$('#message').val('');
		},
		sendEnter : function() {
			this._sendMessage('${param.bang_id}', 'CMD_ENTER', $('#message')
					.val(), $('#userid').val());
			$('#message').val('');
		},
		
		receiveMessage : function(msgData) {

			// 정의된 CMD 코드에 따라서 분기 처리
			if (msgData.cmd == 'CMD_MSG_SEND') {
				$('#divChatData').append('<div>' + msgData.msg + '</div>');
				scroll_down();
			}
			// 입장
			else if (msgData.cmd == 'CMD_ENTER') {
				$('#divChatData').append('<div>' + msgData.msg + '</div>');
				scroll_down();
			}
			// 퇴장
			else if (msgData.cmd == 'CMD_EXIT') {
				$('#divChatData').append('<div>' + msgData.msg + '</div>');
				scroll_down();
			}
		},
		closeMessage : function(str) {
			$('#divChatData').append('<div>' + '연결 끊김 : ' + str + '</div>');
			scroll_down();
		},
		disconnect : function() {
			this._socket.close();
		},
		_initSocket : function() {
			this._socket = new SockJS(this._url);
			this._socket.onopen = function(evt) {
				webSocket.sendEnter();
			};
			this._socket.onmessage = function(evt) {
				webSocket.receiveMessage(JSON.parse(evt.data));
			};
			this._socket.onclose = function(evt) {
				webSocket.closeMessage(JSON.parse(evt.data));
			}
		},
		_sendMessage : function(bang_id, cmd, msg, userid) {
			var msgData = {
				bang_id : bang_id,
				cmd : cmd,
				msg : msg,
				userid : userid
			};
			var jsonData = JSON.stringify(msgData);
			this._socket.send(jsonData);
		}
	};

	function exitRoom() {
		webSocket.disconnect();
		setTimeout(
				function() {
					location
							.replace('${pageContext.request.contextPath}/chatroom/chatList.do');
				}, 300);
	}
	function scroll_down() {
		document.querySelector('.divChat').scrollTop = document
				.querySelector('.divChat').scrollHeight;
	}
	function cmmd(cmd) {
		if (cmd == '/도움말') {
			var strHelp = '<font color="red">&nbsp;&nbsp;<b>[도움말]</b></font><br>'
					+ '<font color="red">* 글초기화 : /지우개</font><br>'
					+ '<font color="red">* 대화가 어색할땐? : /제시어</font><br>'
					+ '<font color="red">* 도움말 : /도움말</font><br>';
			$('#divChatData').append('<div>' + strHelp + '</div>');
			scroll_down();
			return;
		} else if (cmd == '/지우개') {
			$('#divChatData').empty();
			$('#divChatData').append(
					'<div style="margin-bottom: 3px;"><font color="orange">'
							+ '대화내용을 지웠습니다.' + '</font></div>');
			$('#message').val('');
			$('#message').focus();
			return;
		} else if (cmd == '/제시어'){
			var num = Math.ceil(Math.random()*16);
			const numInfo = JSON.stringify({num:num});
			$.ajax({
				data : numInfo,
				url : "${pageContext.request.contextPath}/chatroom/keyword.do",
				type : "post",
				dataType : "text",
				contentType : "application/json; charset=UTF-8",
				success : function(data){
					var str = '<font color="blue"> 다음 제시어로 대화를 해보세요 : '+data+'</font><br>'
					$('#divChatData').append('<div>' + str + '</div>');
				},
				error : function(data){
					var str = '<font color="red"> 제시어를 불러오는데 실패했습니다. </font><br>'
					$('#divChatData').append('<div>' + str + '</div>');
				}
			})
		}
	}
</script>
<script type="text/javascript">
	$(window).on('load', function() {
		webSocket.init({
			url : '<c:url value="/chat" />'

		});
	});
</script>
<style type="text/css">
.panel-title {
	text-align: center;
}
</style>
</head>
<body>
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<%@ include file="/resources/include/main/nav.jsp"%>
	<h2 class="container-fluid text-center bg-grey">대화방</h2>
	<div class="container-fluid text-center bg-grey">
		<div class="divChat"
			style="width: 100%; height: 71%; padding: 10px; overflow-y: scroll; word-break: break-all; border-bottom: solid 1px #e1e3e9;">
			<div id="divChatData">
				<font color="red">&nbsp;&nbsp;<b>[알림]</b></font><br> <font
					color="red">* 도움이 필요하시면 /도움말 입력하세요!!</font><br> <font
					color="red">* 즐거운 채팅 되세요 ^_^</font><br>
			</div>
		</div>
		<div style="width: 100%; height: 10%; padding: 10px;">
			<input type="text" id="message" size="110"
				onkeypress="if(event.keyCode==13){webSocket.sendChat();}" /> <input
				type="button" class="btn btn-primary" id="btnSend" value="채팅전송"
				onclick="webSocket.sendChat()" /> <input type="hidden" id="userid"
				value="${sessionScope.member.id }" />
		</div>
		<div>
			<c:choose>
				<c:when test="${owner eq sessionScope.member.id }">
					<input type="button" class="btn btn-primary" value="채팅종료"
						onClick="location.href='${pageContext.request.contextPath}/chatroom/del.do/${cno }'">
				</c:when>
				<c:otherwise>
					<input type="button" class="btn btn-primary" value="채팅종료"
						onClick="exitRoom()">
				</c:otherwise>
			</c:choose>
		</div>
	</div>


	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>
</html>