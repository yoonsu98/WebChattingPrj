package com.gaon.prj.chatroom.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gaon.prj.chatroom.vo.ChatroomVO;

@Repository
public class ChatroomDAOImpl implements ChatroomDAO {
	@Inject
	private SqlSession sqlSession;	
	
	@Override
	public void add(Map<String, Object> param) {
		sqlSession.insert("mappers.ChatroomDAO-mapper.add", param);
	}
	
	@Override
	public List<ChatroomVO> roomList() {
		return sqlSession.selectList("mappers.ChatroomDAO-mapper.roomList");
	}
	
	@Override
	public String findOwner(int cno) {
		return sqlSession.selectOne("mappers.ChatroomDAO-mapper.findOwner",cno);
	}
	
	@Override
	public int findInfo(ChatroomVO vo) {
		return sqlSession.selectOne("mappers.ChatroomDAO-mapper.findInfo",vo);
	}
	
	@Override
	public int delRoom(int cno) {
		return sqlSession.delete("mappers.ChatroomDAO-mapper.delRoom",cno);
	}
	
	@Override
	public String keyword(int kno) {
		return sqlSession.selectOne("mappers.ChatroomDAO-mapper.keyword",kno);
	}
}
