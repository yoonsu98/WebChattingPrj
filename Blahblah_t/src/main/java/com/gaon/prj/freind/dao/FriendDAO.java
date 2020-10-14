package com.gaon.prj.freind.dao;

import java.util.List;

import com.gaon.prj.member.vo.MemberVO;


public interface FriendDAO {
	public List<MemberVO> getFollowingList(String id);
}
