package com.gaon.prj.chatroom.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.gaon.prj.chatroom.svc.ChatroomSVC;
import com.gaon.prj.chatroom.vo.ChatroomVO;

@Controller
@RequestMapping("/chatroom/*")
@EnableWebMvc
public class ChatroomController {
	@Inject
	ChatroomSVC chatroomSVC;
	
	/**
	 * (중고거래)채팅방 리스트 페이지 이동
	 * @return
	 */
	@RequestMapping(value = "chatList", method = RequestMethod.GET)
	public String chatList(Model model, ChatroomVO vo) {
		List<ChatroomVO> list = chatroomSVC.roomList();
		model.addAttribute("list",list);
		return "chatroom/chatList";
	}
	/**
	 * (중고거래)채팅방 만들기 페이지 이동
	 * @return
	 */
	@RequestMapping(value = "/chat/add", method = RequestMethod.GET)
	public String showAdd() {
		return "chatroom/add";
	}
	
	/**
	 * (중고거래) 채팅방 만들기 처리
	 * @param param
	 * @return
	 */
	@RequestMapping(value = "/chat/doAdd", method = RequestMethod.POST)
	public String doAdd(@RequestParam Map<String, Object> param) {	
		Map<String, Object> rs = chatroomSVC.doAdd(param);
		return "redirect:/service/chatList";
	}
	
}
