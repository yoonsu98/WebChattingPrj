package com.gaon.prj.videochatting.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaon.prj.member.vo.MemberVO;
import com.gaon.prj.videochatting.svc.VideoChatroomSVC;
import com.gaon.prj.videochatting.vo.VideoChatroomVO;

@Controller
@RequestMapping("/videochatting/*")
public class VideochattingController {

	@Inject
	VideoChatroomSVC videochatroomSVC;

	
	@RequestMapping("/videochatList")
	public String getchatList(Model model) {
		List<VideoChatroomVO> list = videochatroomSVC.getchatList();
		System.out.println("list임니당 : "+list);
		model.addAttribute("list", list);
		return "videochatting/videochatList";
	}
 
	@RequestMapping(value = "/addRoom", method = RequestMethod.GET)
	public String showAdd() {
		return "videochatting/addRoom";
	}
	@RequestMapping(value = "/doAdd", method = RequestMethod.POST)
	public String doAdd(@RequestParam Map<String, Object> roomInfo) throws UnsupportedEncodingException {	
		Map<String, Object> rs = videochatroomSVC.addVideoChatRoom(roomInfo);
		VideoChatroomVO vo = new VideoChatroomVO();
		vo.setVcid(String.valueOf(roomInfo.get("id")));
		vo.setVctitle(String.valueOf(roomInfo.get("title")));
		int cno = videochatroomSVC.findInfo(vo);
		String bang_id = URLEncoder.encode(vo.getVctitle(), "UTF-8");
		System.out.println(bang_id);
		return "redirect:/videochatting/videochatroom/"+cno+"?bang_id="+(bang_id.replaceAll(" ","%20"));
	}
	@RequestMapping(value = "/videochatroom/{vcno}", method = RequestMethod.GET)
	public String videochatroom(@PathVariable int vcno, HttpServletRequest request, HttpServletResponse response,HttpSession session) throws Exception {
		HashMap<String,Object> roomInfo = new HashMap<String,Object>();
		String owner = videochatroomSVC.findOwner(vcno);
		roomInfo.put("vcno",vcno);
		roomInfo.put("owner",owner);
		session.setAttribute("roomInfo",roomInfo);
		return "videochatting/videochatroom";
	}

	/*
	 * @RequestMapping(value= "/deleteRoomInfo",method = RequestMethod.POST)
	 * public @ResponseBody int deleteRoomInfo(@RequestBody HashMap<String, String>
	 * roomInfo,HttpSession session) throws Exception{ int id =
	 * Integer.parseInt(roomInfo.get("vcno")); System.out.println("id임니당 : " + id);
	 * int result = videochatroomSVC.deleteRoomInfo(id);
	 * session.removeAttribute("roomInfo"); return result;
	 
	}*/
	@RequestMapping(value="/deleteRoomInfo", method= RequestMethod.POST)
	public @ResponseBody int setFollowing(@RequestBody HashMap<String, Integer> roomInfo ,HttpSession session) throws Exception {
		session.removeAttribute("roomInfo");
		return videochatroomSVC.deleteRoomInfo(roomInfo.get("vcno"));
	}
}
