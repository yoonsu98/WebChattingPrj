package com.gaon.prj.chatroom.dao;

import java.util.List;
import java.util.Map;

import com.gaon.prj.chatroom.vo.ChatroomVO;

public interface ChatroomDAO {
	/**
	 * (중고거래)채팅방 생성
	 * @param param
	 */
	public void add(Map<String, Object> param);
	public List<ChatroomVO> roomList();
}
