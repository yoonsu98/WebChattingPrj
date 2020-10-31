package com.gaon.prj.chatroom.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.gaon.prj.board.vo.BoardVO;
import com.gaon.prj.chatroom.svc.ChatroomSVC;
import com.gaon.prj.chatroom.vo.ChatroomVO;
import com.gaon.prj.paging.PagingVO;

@Controller
@RequestMapping("/chatroom/*")
@EnableWebMvc
public class ChatroomController {
	@Inject
	ChatroomSVC chatroomSVC;
	
	@RequestMapping(value = "/chatList.do", method = RequestMethod.GET)
	public String chatList(Model model, ChatroomVO vo, PagingVO paging, @RequestParam(defaultValue="1") int curPage) {
		int totalCnt = chatroomSVC.total();
		System.out.println(totalCnt);
		paging = new PagingVO(totalCnt,curPage);
		List<ChatroomVO> list = chatroomSVC.roomList(paging);
		model.addAttribute("list",list);
		model.addAttribute("paging",paging);
		System.out.println(paging.toString());
		return "chatroom/chatList";
	}
	
	/**
	 * 채팅방 만들기 페이지 이동
	 * @return
	 */
	@RequestMapping(value = "/add.do", method = RequestMethod.GET)
	public String showAdd() {
		return "chatroom/add";
	}
	/**
	 * 채팅방 만들기 처리
	 * @param param
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value = "/doAdd.do", method = RequestMethod.POST)
	public String doAdd(@RequestParam Map<String, Object> param) throws UnsupportedEncodingException {	
		Map<String, Object> rs = chatroomSVC.doAdd(param);
		ChatroomVO vo = new ChatroomVO();
		vo.setId(String.valueOf(param.get("id")));
		vo.setTitle(String.valueOf(param.get("title")));
		int cno = chatroomSVC.findInfo(vo);
		String bang_id = URLEncoder.encode(vo.getTitle(), "UTF-8");
		return "redirect:/chatroom/chat.do/"+cno+"?bang_id="+(bang_id.replaceAll(" ","%20"));
	}
	
	// 채팅방 입장
	@RequestMapping(value = "/chat.do/{cno}", method = RequestMethod.GET)
	public String view_chat(@PathVariable int cno, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		String owner = chatroomSVC.findOwner(cno);
		model.addAttribute("owner" , owner);
		return "chatroom/room";
	}
	// 채팅방 삭제
	@RequestMapping(value = "/del.do/{cno}", method = RequestMethod.GET)
	public String del(@PathVariable int cno) {
		chatroomSVC.delRoom(cno);
		return "redirect:/chatroom/chatList.do";
	}
	
	@ResponseBody
	@RequestMapping(value = "/keyword.do", method = RequestMethod.POST, produces = "application/json")
	public String keyword(@RequestBody HashMap<String, String> map) throws Exception{
		int num = Integer.parseInt(map.get("num"));
		return chatroomSVC.keyword(num);
	}
}
