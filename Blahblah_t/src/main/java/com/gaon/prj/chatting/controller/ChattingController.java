package com.gaon.prj.chatting.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/chatting/*")
public class ChattingController {
	/**
	 * 채팅화면으로 이동
	 * @return
	 */	
	@RequestMapping("/chattingForm")
	public String chattingForm() {
		return "chatting/chattingForm";
	}

}
