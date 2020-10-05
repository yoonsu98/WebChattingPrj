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
		sqlSession.insert("mappers.ServiceDAO-mapper.add", param);
	}
	
	@Override
	public List<ChatroomVO> roomList() {
		return sqlSession.selectList("mappers.ServiceDAO-mapper.roomList");
	}
}
