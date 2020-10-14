package com.gaon.prj.friend.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gaon.prj.friend.svc.FriendSVC;
import com.gaon.prj.friend.vo.FriendVO;
import com.gaon.prj.member.vo.MemberVO;

@Controller
@RequestMapping("/friend/*")
public class FriendController {
	@Inject
	FriendSVC friendSVC;
	MemberVO memberVO;

	@RequestMapping("/friendHome")
	public String friendHome() {
		return "friend/friendHome";
	}
	@RequestMapping("/followingList")
	public String followingList(Model model, HttpServletRequest request) {
		Object temp_memberVO= request.getSession().getAttribute("member");
		memberVO= (MemberVO)temp_memberVO;
		List<MemberVO> followingList = friendSVC.getFollowingList(memberVO.getId());
		model.addAttribute("followingList",followingList);
		return "friend/followingList";
	}
	@RequestMapping("/followerList")
	public String followerList() {
		return "friend/followerList";
	}
}