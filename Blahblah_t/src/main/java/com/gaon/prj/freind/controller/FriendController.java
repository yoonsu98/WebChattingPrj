package com.gaon.prj.freind.controller;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.gaon.prj.chatroom.vo.ChatroomVO;
import com.gaon.prj.freind.svc.FriendSVC;

@Controller
@RequestMapping("/friend/*")
public class FriendController {
	//@Inject
	//FriendSVC friendSVC;


	@RequestMapping("/friendHome")
	public String friendHome() {
		return "friend/friendHome";
	}
	@RequestMapping("/followingList")
	public String followingList() {
		return "friend/followingList";
	}
	@RequestMapping("/followerList")
	public String followerList() {
		return "friend/followerList";
	}
}
