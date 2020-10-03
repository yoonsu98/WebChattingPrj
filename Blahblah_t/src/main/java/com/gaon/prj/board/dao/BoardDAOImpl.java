package com.gaon.prj.board.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gaon.prj.board.vo.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sqlSession;
	@Override
	public int writeBoard(BoardVO boardVO) {
		return sqlSession.insert("mappers.BoardDAO-mapper.writeBoard",boardVO);
	}
}
