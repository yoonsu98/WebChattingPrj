package com.gaon.prj.board.controller;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaon.prj.board.svc.BoardSVC;
import com.gaon.prj.board.vo.BoardVO;
import com.gaon.prj.paging.PagingVO;

@Controller
@RequestMapping(value = "/board/*")
public class BoardController {
	@Inject
	BoardSVC boardSVC;

	@RequestMapping("/boardList")
	public String boardList(Model model,PagingVO paging,@RequestParam(defaultValue="1") int curPage) {
		int totalCnt =  boardSVC.countBoard();

		paging = new PagingVO(totalCnt,curPage);
		List<BoardVO> list = boardSVC.boardList(paging);
		
		model.addAttribute("paging",paging);
		model.addAttribute("list", list);
		return "board/boardList";
	}

	@RequestMapping("/writeBoard")
	public String writingBoardForm() {
		return "board/writeBoard";
	}

	@GetMapping(value = "/viewBoard/{pnum}")
	public String viewBoard(@PathVariable("pnum") int pnum, BoardVO view, Model model) {
		view = boardSVC.viewBoard(pnum);
		boardSVC.increaseRcnt(pnum);
		model.addAttribute("view", view);
		return "board/viewBoard";
	}

	@ResponseBody
	@RequestMapping(value = "/writeTextBoard", method = RequestMethod.POST, produces = "application/json")
	public int writeTextBoard(@RequestBody HashMap<String, String> boardInfo, BoardVO boardVO) {
		boardVO.setWriter(boardInfo.get("writer"));
		boardVO.setTitle(boardInfo.get("title"));
		boardVO.setContent(boardInfo.get("content"));
		return boardSVC.writeBoard(boardVO);
	}

	@RequestMapping(value = "/loginWriteBoard", method = RequestMethod.POST)
	public String loginWriteBoard(HttpSession session) {
		if (session.getAttribute("member")!= null) {
			return "board/writeBoard";
		}
		else {
			return "member/loginForm";
		}
	}
	
	@GetMapping(value = "/updateViewForm")
	public String updateViewForm(Model model,@RequestParam("pnum") int pnum) {
		model.addAttribute("upview", boardSVC.viewBoard(pnum));
		return "board/updateViewForm";
	}
	
	@ResponseBody
	@RequestMapping(value="/updateView", method=RequestMethod.POST, produces = "application/json")
	public int updateView(@RequestBody HashMap<String, String> boardInfo,BoardVO boardVO)
	{
		boardVO.setPnum(Integer.parseInt(boardInfo.get("pnum")));
		boardVO.setWriter(boardInfo.get("writer"));
		boardVO.setTitle(boardInfo.get("title"));
		boardVO.setContent(boardInfo.get("content"));
		return boardSVC.updateView(boardVO);
	}
	
	@GetMapping(value="/deleteView")
	public String deleteView(@RequestParam("pnum") int pnum) {
		boardSVC.deleteView(pnum);
		return "board/boardList";
	}
}