package com.gaon.prj.common;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

@Component
@RequestMapping(value = "/socket", method = RequestMethod.GET)
public class WebRTCSocketHandler extends TextWebSocketHandler {

	List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();
	//private List<Map<String, Object>> sessionList = new ArrayList<Map<String, Object>>();
	//ObjectMapper objectMapper = new ObjectMapper();

	@Override
	// 서버로 메세지 전송
	public void handleTextMessage(WebSocketSession session, TextMessage message)
			throws InterruptedException, IOException {

		System.out.println("세셔너어어엉" + session);
		System.out.println("메세지이이이이" + message);

		 for (WebSocketSession webSocketSession : sessions) { if
		 (webSocketSession.isOpen() &&
		 !session.getId().equals(webSocketSession.getId())) {
		 webSocketSession.sendMessage(message); } }
		 
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessions.add(session);
		System.out.println("세션연결완료" + session.getId());
	}

	// 클라이언트 연결을 끊었을 떄 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		sessions.remove(session); System.out.println("세션끝"+session.getId());
		 

	}
}