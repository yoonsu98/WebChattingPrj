package com.gaon.prj.friend.svc;

import java.util.List;

import com.gaon.prj.member.vo.MemberVO;

public interface FriendSVC {
	public List<MemberVO> getFollowingList(String id);
	public List<MemberVO> getFollowerList(String id);
	public List<MemberVO> getMemberList();
}