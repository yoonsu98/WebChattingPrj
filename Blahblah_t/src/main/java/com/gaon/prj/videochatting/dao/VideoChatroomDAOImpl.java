package com.gaon.prj.videochatting.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gaon.prj.chatroom.vo.ChatroomVO;
import com.gaon.prj.member.vo.MemberVO;
import com.gaon.prj.videochatting.vo.VideoChatroomVO;

@Repository
public class VideoChatroomDAOImpl implements VideoChatroomDAO {

	@Inject
	private SqlSession sqlSession;

	@Override
	public List<VideoChatroomVO> getchatList() {
		System.out.println("ddd");
		List<VideoChatroomVO> chatRoomInfo = sqlSession.selectList("mappers.VideoChatroomDAO-mapper.getchatList");
		System.out.println(chatRoomInfo);
		return chatRoomInfo;
	}

	@Override
	public void addVideoChatRoom(Map<String, Object> roomInfo) {
		sqlSession.insert("mappers.VideoChatroomDAO-mapper.addVideoChatRoom", roomInfo);
	}

	@Override
	public int findInfo(VideoChatroomVO vo) {
		return sqlSession.selectOne("mappers.VideoChatroomDAO-mapper.findInfo",vo);
	}
	@Override
	public String findOwner(int vcno) {
		return sqlSession.selectOne("mappers.VideoChatroomDAO-mapper.findOwner",vcno);
	}
	@Override
	public int deleteRoomInfo(int vcno) {
		int result = sqlSession.delete("mappers.VideoChatroomDAO-mapper.deleteRoomInfo",vcno);
		return result;
	}
}
