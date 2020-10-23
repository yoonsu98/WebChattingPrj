package com.gaon.prj.board.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gaon.prj.board.vo.BoardVO;
import com.gaon.prj.paging.PagingVO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sqlSession;

	@Override
	public int writeBoard(BoardVO boardVO) {
		return sqlSession.insert("mappers.BoardDAO-mapper.writeBoard", boardVO);
	}

	@Override
	public Integer countBoard() {
		return sqlSession.selectOne("mappers.BoardDAO-mapper.countBoard");
	}

	@Override
	public List<BoardVO> boardList(PagingVO paging) {
		return sqlSession.selectList("mappers.BoardDAO-mapper.boardList", paging);
	}

	@Override
	public BoardVO viewBoard(int pnum) {
		return sqlSession.selectOne("mappers.BoardDAO-mapper.viewBoard", pnum);
	}

	@Override
	public void increaseRcnt(int pnum) {
		sqlSession.update("mappers.BoardDAO-mapper.increaseRcnt", pnum);
	}

	@Override
	public int updateView(BoardVO boardVO) {
		return sqlSession.update("mappers.BoardDAO-mapper.updateView", boardVO);
	}

	@Override
	public void deleteView(int pnum) {
		sqlSession.delete("mappers.BoardDAO-mapper.deleteView", pnum);
	}

}
