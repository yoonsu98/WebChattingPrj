package com.gaon.prj.board.dao;

import java.util.List;

import com.gaon.prj.board.vo.BoardVO;

public interface BoardDAO {
	public int writeBoard(BoardVO boardVO);
	public List<BoardVO> boardList();
}
