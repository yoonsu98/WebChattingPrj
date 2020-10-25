package com.gaon.prj.board.dao;

import java.util.List;

import com.gaon.prj.board.vo.BoardVO;
import com.gaon.prj.paging.PagingVO;

public interface BoardDAO {
	public int writeBoard(BoardVO boardVO);
	public List<BoardVO> boardList(PagingVO paging);
	public BoardVO viewBoard(int pnum);
	public void increaseRcnt(int pnum);
	public Integer countBoard();
	public void deleteView(int pnum);
	public int updateView(BoardVO boardVO);
}
