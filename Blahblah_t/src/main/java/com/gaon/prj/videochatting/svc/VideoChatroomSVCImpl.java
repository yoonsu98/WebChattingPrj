package com.gaon.prj.videochatting.svc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.gaon.prj.chatroom.vo.ChatroomVO;
import com.gaon.prj.videochatting.dao.VideoChatroomDAO;
import com.gaon.prj.videochatting.vo.VideoChatroomVO;

@Service
public class VideoChatroomSVCImpl implements VideoChatroomSVC {
	@Inject
	@Qualifier("videoChatroomDAOImpl")
	VideoChatroomDAO videoChatroomDAO;

	@Override
	public List<VideoChatroomVO> getchatList() {
		return videoChatroomDAO.getchatList();
	}

	@Override
	public Map<String, Object> addVideoChatRoom(Map<String, Object> roomInfo) {
		videoChatroomDAO.addVideoChatRoom(roomInfo);
		Map<String, Object> rs = new HashMap<>();
		rs.put("resultCode", "S-1");
		rs.put("msg", "채팅방이 생성되었습니다.");
		rs.put("id", roomInfo.get("id"));
		return null;
	}

	@Override
	public int findInfo(VideoChatroomVO vo) {
		return videoChatroomDAO.findInfo(vo);
	}
	@Override
	public String findOwner(int vcno) {
		return videoChatroomDAO.findOwner(vcno);
	}
	@Override
	public int deleteRoomInfo(int vcno) {
		return videoChatroomDAO.deleteRoomInfo(vcno);
	}
}
