package com.gaon.prj.board.svc;

import java.util.List;

import com.gaon.prj.board.vo.BoardVO;

public interface BoardSVC {
	public int writeBoard(BoardVO boardVO);
	public List<BoardVO> boardList();
}
