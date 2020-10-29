package com.gaon.prj.videochatting.svc;

import java.util.List;
import java.util.Map;

import com.gaon.prj.chatroom.vo.ChatroomVO;
import com.gaon.prj.member.vo.MemberVO;
import com.gaon.prj.videochatting.vo.VideoChatroomVO;

public interface VideoChatroomSVC {
	public List<VideoChatroomVO> getchatList();
	public Map<String, Object> addVideoChatRoom(Map<String, Object> roomInfo);
	public int findInfo(VideoChatroomVO vo);
	public String findOwner(int vcno);
}