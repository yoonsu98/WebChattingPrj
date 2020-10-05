package com.gaon.prj.chatroom.svc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gaon.prj.chatroom.dao.ChatroomDAO;
import com.gaon.prj.chatroom.vo.ChatroomVO;
@Service
public class ChatroomSVCImpl implements ChatroomSVC {
	@Inject
	ChatroomDAO chatroomDAO;
	
	@Override
	public Map<String, Object> doAdd(Map<String, Object> param) {
		chatroomDAO.add(param);
		
		Map<String, Object> rs = new HashMap<>();
		rs.put("resultCode", "S-1");
		rs.put("msg", "채팅방이 생성되었습니다.");
		rs.put("id", param.get("id"));
		return null;
	}
	
	@Override
	public List<ChatroomVO> roomList() {
		return chatroomDAO.roomList();
	}
}
