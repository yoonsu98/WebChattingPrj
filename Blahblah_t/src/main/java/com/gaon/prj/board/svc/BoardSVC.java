package com.gaon.prj.board.svc;

import java.util.List;

import com.gaon.prj.board.vo.BoardVO;
import com.gaon.prj.paging.PagingVO;

public interface BoardSVC {
	public int writeBoard(BoardVO boardVO);
	public List<BoardVO> boardList(PagingVO paging);
	public BoardVO viewBoard(int pnum);
	public int countBoard(PagingVO paging);
	public void increaseRcnt(int pnum);
	public void deleteView(int pnum);
	public int updateView(BoardVO boardVO);
}
