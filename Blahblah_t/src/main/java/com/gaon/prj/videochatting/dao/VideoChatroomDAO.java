package com.gaon.prj.videochatting.dao;

import java.util.List;
import java.util.Map;

import com.gaon.prj.chatroom.vo.ChatroomVO;
import com.gaon.prj.videochatting.vo.VideoChatroomVO;

public interface VideoChatroomDAO {
	public List<VideoChatroomVO> getchatList();
	public void addVideoChatRoom(Map<String, Object> roomInfo);

	public String findOwner(int vcno);
	public int findInfo(VideoChatroomVO vo);
	
}