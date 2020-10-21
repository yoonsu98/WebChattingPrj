package com.gaon.prj.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

@RequestMapping(value="/echo", method=RequestMethod.GET)
public class WebSocketHandler extends TextWebSocketHandler {
	
	
	
	// 세션 리스트
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	private Logger log = LoggerFactory.getLogger(WebSocketHandler.class);
	
	private Map<String, Object> userMap;
	
	ObjectMapper mapper = new ObjectMapper();
	
	
	public WebSocketHandler() {
		userMap = new HashMap<String, Object>();
		
	}
	
	// 클라이언트가 연결 되면 실행
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		log.info("{} 연결됨" , session.getId());
	}
	 
	//클라이언트가 웹 소켓 서버로 메시지를 전송했을 때 실행
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
		
		JSONObject object = mapper.readValue(message.getPayload(), JSONObject.class);
		String type = (String)object.get("type");
		
		//1:1 chat - 등록
		if(type.equals("register")) {
			Map<String, Object> map;
			map = session.getAttributes();
			
			System.out.println(map.get("member"));
				
			//String userid = (String)map.get("member");
			
			System.out.println("등록");
			String user = (String)object.get("userid");
			userMap.put(user, session);
			
			
			System.out.println(userMap.keySet().toArray()); //세션에 들어온 사람들 
		
		}
		
		//1:1 chat - 채팅
		else if(type.equals("chat")){
			System.out.println("서버에서 메시지보냄");
			String target = (String)object.get("target");
			WebSocketSession ws = (WebSocketSession)userMap.get(target);
			System.out.println(ws);
			String msg = (String)object.get("message");
			
			if(ws != null) {
				ws.sendMessage(new TextMessage(msg));
			}
		}
		
		else {
			//모든 유저에게 메시지 출력
			for(WebSocketSession sess : sessionList) {
				sess.sendMessage(new TextMessage(message.getPayload()));
				}
		}
	}
	
	// 클라이언트 연결을 끊었을 떄 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		log.info("{} 연결 끊김.", session.getId());
	}
	
	
}	