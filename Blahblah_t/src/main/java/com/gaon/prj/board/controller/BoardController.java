package com.gaon.prj.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/board/*")
public class BoardController {
	
	/**
	 * 게시판으로 이동
	 * @return
	 */	
	@RequestMapping("/boardForm")
	public String boardForm() {
		return "board/boardForm";
	}
	
	/**
	 * 게시글 작성하러 이동
	 * @return
	 */	
	@RequestMapping("/writeText")
	public String writeText() {
		return "board/writeText";
	}
	
	
}
