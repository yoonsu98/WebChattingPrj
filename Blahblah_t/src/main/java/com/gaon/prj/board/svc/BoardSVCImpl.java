package com.gaon.prj.board.svc;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.gaon.prj.board.dao.BoardDAO;
import com.gaon.prj.board.vo.BoardVO;

@Service
public class BoardSVCImpl implements BoardSVC {

	@Inject	
	@Qualifier("boardDAOImpl")
	BoardDAO boardDAO;
	
	@Override
	public int writeBoard(BoardVO boardVO) {
		return boardDAO.writeBoard(boardVO);
	}
}
