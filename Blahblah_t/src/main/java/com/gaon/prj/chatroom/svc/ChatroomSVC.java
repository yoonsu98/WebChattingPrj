package com.gaon.prj.chatroom.svc;

import java.util.List;
import java.util.Map;

import com.gaon.prj.chatroom.vo.ChatroomVO;
import com.gaon.prj.paging.PagingVO;

public interface ChatroomSVC {
	public Map<String, Object> doAdd(Map<String, Object> param);
	public List<ChatroomVO> roomList(PagingVO paging);
	public String findOwner(int cno);
	public int findInfo(ChatroomVO vo);
	public int delRoom(int cno);
	public String keyword(int kno);
	public int total();
}
