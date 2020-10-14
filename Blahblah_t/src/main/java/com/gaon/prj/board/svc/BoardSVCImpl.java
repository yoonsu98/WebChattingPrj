package com.gaon.prj.board.svc;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.gaon.prj.board.dao.BoardDAO;
import com.gaon.prj.board.vo.BoardVO;
import com.gaon.prj.paging.PagingVO;

@Service
public class BoardSVCImpl implements BoardSVC {

	@Inject	
	@Qualifier("boardDAOImpl")
	BoardDAO boardDAO;
	
	@Override
	public int writeBoard(BoardVO boardVO) {
		return boardDAO.writeBoard(boardVO);
	}
	@Override
	public Integer countBoard() {
		return boardDAO.countBoard();
	}
	
	@Override
	public List<BoardVO> boardList(PagingVO paging){
		List<BoardVO> list = null;
		list = boardDAO.boardList(paging);
		return list;
	}
	
	@Override
	public BoardVO viewBoard(int pnum) {
		boardDAO.increaseRcnt(pnum);
		return boardDAO.viewBoard(pnum);
	}
	
	public void increaseRcnt(int pnum) {
		return;
	}
}
