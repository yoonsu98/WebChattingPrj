package com.gaon.prj.friend.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaon.prj.friend.svc.FriendSVC;
import com.gaon.prj.friend.vo.MessageVO;
import com.gaon.prj.member.vo.MemberVO;
import com.gaon.prj.paging.PagingVO;

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
	@RequestMapping("/DMSendList")
	public String DMSendList(Model model, HttpServletRequest request) {
		Object temp_memberVO = request.getSession().getAttribute("member");
		memberVO = (MemberVO)temp_memberVO;
		List<MessageVO> sendMessageList = friendSVC.getSendMessageList(memberVO.getId());
		model.addAttribute("sendMessageList",sendMessageList);
		return "friend/DMSendList";
	}
	@RequestMapping("/DMRecieveList")
	public String DMRecieveList(Model model, HttpServletRequest request) {
		Object temp_memberVO = request.getSession().getAttribute("member");
		memberVO = (MemberVO)temp_memberVO;
		List<MessageVO> receiveMessageList = friendSVC.getReceiveMessageList(memberVO.getId());
		System.out.println(receiveMessageList);
		model.addAttribute("receiveMessageList",receiveMessageList);
		return "friend/DMRecieveList";
	}
	@GetMapping("/DMDetail/{id}")
	public String DMDetail(@PathVariable("id") String id, Model model) {
		return "friend/DMDetail";
	}
	@RequestMapping("/followingList")
	public String followingList(Model model, HttpServletRequest request,PagingVO paging,@RequestParam(defaultValue="1") int curPage) {
		Object temp_memberVO= request.getSession().getAttribute("member");
		memberVO= (MemberVO)temp_memberVO;
		
		int totalFiid =  friendSVC.countFiidList();
		
		paging = new PagingVO(totalFiid,curPage);
		List<MemberVO> followingList = friendSVC.getFollowingList(memberVO.getId());
		model.addAttribute("followingList",followingList);
		model.addAttribute("paging",paging);
		return "friend/followingList";
	}
	@RequestMapping("/followerList")
	public String followerist(Model model, HttpServletRequest request,PagingVO paging,@RequestParam(defaultValue="1") int curPage) {
		Object temp_memberVO= request.getSession().getAttribute("member");
		memberVO= (MemberVO)temp_memberVO;
		int totalFeid =  friendSVC.countFeidList();
		paging = new PagingVO(totalFeid,curPage);
		List<MemberVO> followerList = friendSVC.getFollowerList(memberVO.getId());
		model.addAttribute("followerList",followerList);
		model.addAttribute("paging",paging);
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
	@RequestMapping(value="/setUnFollowing", method= RequestMethod.POST)
	public @ResponseBody Map<String, Boolean> setUnFollowing(@RequestBody HashMap<String, String> IDInfo) throws Exception {
		return friendSVC.setUnFollowing(IDInfo);
	}
	@RequestMapping(value="/chkFollowState", method= RequestMethod.POST)
	public @ResponseBody Map<String, Boolean> getFollowState(@RequestBody HashMap<String,String> IDInfo) throws Exception {
		return friendSVC.getFollowState(IDInfo);
	}
	@RequestMapping(value="/sendDM", method= RequestMethod.POST)
	public @ResponseBody Map<String, Boolean> sendDM(@RequestBody HashMap<String, String> messageInfo) throws Exception {
		return friendSVC.sendDM(messageInfo);
	}
	@RequestMapping(value="/getDMDetail", method= RequestMethod.POST)
	public @ResponseBody MessageVO getDMDetail(@RequestBody HashMap<String, String> messageID) throws Exception {
		return friendSVC.getDMDetail(messageID.get("mid"));
	}
}