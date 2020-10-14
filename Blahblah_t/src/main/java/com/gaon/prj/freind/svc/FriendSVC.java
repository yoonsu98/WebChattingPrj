package com.gaon.prj.freind.svc;

import java.util.List;

import com.gaon.prj.member.vo.MemberVO;


public interface FriendSVC {
	public List<MemberVO> getFollowingList(String id);
}
