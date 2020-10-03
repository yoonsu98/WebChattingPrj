package com.gaon.prj.board.controller;

import java.util.HashMap;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaon.prj.board.svc.BoardSVC;
import com.gaon.prj.board.vo.BoardVO;

@Controller
@RequestMapping(value="/board/*")
public class BoardController {
	@Inject
	BoardSVC boardSVC;
	/**
	 * 게시판으로 이동
	 * @return
	 */	
	@RequestMapping("/boardList")
	public String boardList() {
		return "board/boardList";
	}
	/**
	 * 게시판으로 이동
	 * @return
	 */	
	@RequestMapping("/writeBoard")
	public String writingBoardForm() {
		return "board/writeBoard";
	}
	/**
	 * 게시글 작성글 보기
	 * @return
	 */	
	@RequestMapping("/viewBoard")
	public String viewBoard() {
		return "board/viewBoard";
	}
	/**
	 * 글쓰기 처리
	 * @param writeBoardInfo
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@ResponseBody	
	@RequestMapping(value = "/writeTextBoard", method = RequestMethod.POST,produces = "application/json")
	public int writeTextBoard(@RequestBody HashMap<String,String> writeBoardInfo, BoardVO boardVO) {
		boardVO.setWriter(writeBoardInfo.get("writer"));
		boardVO.setTitle(writeBoardInfo.get("title"));
		boardVO.setContent(writeBoardInfo.get("content"));
		return boardSVC.writeBoard(boardVO);
	}
}
