package com.gaon.prj.friend.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaon.prj.board.vo.BoardVO;
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
	public String friendHome(Model model) {
		List<MemberVO> memberList = friendSVC.getMemberList();
		model.addAttribute("memberList",memberList);
		return "friend/friendHome";
	}
	@RequestMapping("/myPage")
	public String myPage() {
		return "friend/myPage";
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
	public String followerist(Model model, HttpServletRequest request) {
		Object temp_memberVO= request.getSession().getAttribute("member");
		memberVO= (MemberVO)temp_memberVO;
		List<MemberVO> followerList = friendSVC.getFollowingList(memberVO.getId());
		model.addAttribute("followerList",followerList);
		return "friend/followerList";
	}
	@GetMapping("/friendPage/{id}")
	public String friendInfo(@PathVariable("id") String id, Model model) {
		MemberVO memberVO = friendSVC.getOneMemberInfo(id);
		model.addAttribute("friend", memberVO);
		return "friend/friendPage";
	}
	@RequestMapping(value="/setFollowing", method= RequestMethod.POST)
	public @ResponseBody Map<String, Boolean> setFollowing(@RequestBody HashMap<String, String> IDInfo) throws Exception {
		return friendSVC.setFollowing(IDInfo);
	}
}