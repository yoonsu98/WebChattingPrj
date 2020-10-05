package com.gaon.prj.board.controller;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	@RequestMapping("/boardList")
	public String boardList(Model model) {
		List<BoardVO> list = boardSVC.boardList();
		model.addAttribute("list",list);
		return "board/boardList";
	}

	@RequestMapping("/writeBoard")
	public String writingBoardForm() {
		return "board/writeBoard";
	}

	@GetMapping("/viewBoard/{pnum}")
	public String viewBoard(@PathVariable("pnum") int pnum, BoardVO view, Model model){
		view = boardSVC.viewBoard(pnum);
		boardSVC.increaseRcnt(pnum);
		model.addAttribute("view",view);
		return "board/viewBoard";
	}

	@ResponseBody	
	@RequestMapping(value = "/writeTextBoard", method = RequestMethod.POST,produces = "application/json")
	public int writeTextBoard(@RequestBody HashMap<String,String> writeBoardInfo, BoardVO boardVO) {
		boardVO.setWriter(writeBoardInfo.get("writer"));
		boardVO.setTitle(writeBoardInfo.get("title"));
		boardVO.setContent(writeBoardInfo.get("content"));
		return boardSVC.writeBoard(boardVO);
	}
}