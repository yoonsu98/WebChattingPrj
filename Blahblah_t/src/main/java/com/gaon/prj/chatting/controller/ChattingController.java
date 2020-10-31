package com.gaon.prj.chatting.controller;


import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaon.prj.chatting.svc.SingleChatSVC;



@Controller
@RequestMapping(value="/chatting/*")
public class ChattingController {
	@Inject
	SingleChatSVC singlechatSVC;
	
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
	
	@RequestMapping(value="/getTransChat", method= RequestMethod.POST)
	public @ResponseBody Map<String, String> getTransChat(@RequestBody  HashMap<String, String> chat) throws Exception {
		System.out.println("컨트롤러"+chat);
		return singlechatSVC.getTransChat(chat);
	}
	

}
