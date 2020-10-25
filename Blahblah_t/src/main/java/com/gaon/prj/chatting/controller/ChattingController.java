package com.gaon.prj.chatting.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	@GetMapping("/singlechattingForm/{id}")
	public String singlechattingForm(@PathVariable("id") String id, Model model) {
		
		model.addAttribute("recv_id", id);
		return "chatting/singlechattingForm";
	}

}
