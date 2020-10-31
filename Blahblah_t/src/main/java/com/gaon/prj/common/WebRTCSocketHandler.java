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
	ObjectMapper objectMapper = new ObjectMapper();
	private List<Map<String, Object>> sessionList = new ArrayList<Map<String, Object>>();
	//ObjectMapper objectMapper = new ObjectMapper();

	@Override
	// 서버로 메세지 전송
	public void handleTextMessage(WebSocketSession session, TextMessage message)throws InterruptedException, IOException {
		Map<String, String> receiveMsg = objectMapper.readValue(message.getPayload(), Map.class);
		System.out.println(receiveMsg);
		Map<String,Object> sessionInfo = new HashMap<String,Object>();
		switch(receiveMsg.get("event")) {
		case "enter" :
			sessionInfo.put("vcno", receiveMsg.get("vcno"));
			sessionInfo.put("id", receiveMsg.get("id"));
			sessionInfo.put("session", session);
			sessionList.add(sessionInfo);

			System.out.println(sessionInfo);
			System.out.println(sessionList);
			/*
			 * for (Map<String,Object> sess : sessionList) { if(sess.get("vcno")==
			 * receiveMsg.get("vcno")) { WebSocketSession websock =
			 * (WebSocketSession)sess.get("session"); websock.sendMessage(message); } }
			 * break;
			 */
			break;
		}
		String vcno = null;
		for (Map<String,Object> sess : sessionList) {
			WebSocketSession websock = (WebSocketSession)sess.get("session");
			System.out.println("리스트에 저장되어있는아이 :" +websock.getId());
			System.out.println("리스트에 저장되지않은아이 :" +session.getId());
			System.out.println("vc 아이뒤:" +sess.get("vcno"));
			if(websock.getId().equals(session.getId())) {
				System.out.println("같쟈나");
				vcno = (String) sess.get("vcno");
				System.out.println(vcno);
				System.out.println("같쟈나");
				break;
			}
		}
		System.out.println(vcno);
		for (Map<String,Object> sess : sessionList) {
			WebSocketSession websock = (WebSocketSession)sess.get("session");
			String temp = (String)sess.get("vcno");
			if(temp.equals(vcno)&&!session.getId().equals(websock.getId())) {
				System.out.println(websock.getId());
				websock.sendMessage(message);
			}
		}
		//websock.sendMessage(message);
		
		
		
		
		
		
		/*
		 * for (WebSocketSession webSocketSession : sessions) {
		 * if(webSocketSession.isOpen()
		 * &&!session.getId().equals(webSocketSession.getId())) {
		 * webSocketSession.sendMessage(message); } }
		 */ 
	}
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//sessions.add(session);
		//System.out.println("세션연결완료" + session.getId());
	}

	// 클라이언트 연결을 끊었을 떄 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		Map<String,Object> sessionInfo = new HashMap<String,Object>();
		for (Map<String,Object> sess : sessionList) {
			WebSocketSession websock = (WebSocketSession)sess.get("session");
			String vcno = (String)sess.get("vcno");
			if(websock.getId()== session.getId()) {
				sessionInfo.put("event","close");
				sessionInfo.put("vcno",vcno);
				String jsonStr = objectMapper.writeValueAsString(sessionInfo);
				websock.sendMessage(new TextMessage(jsonStr));
				sessionList.remove(session); System.out.println("세션끝"+session.getId());
			}
		}
		//sessions.remove(session); System.out.println("세션끝"+session.getId());
		 

	}
}