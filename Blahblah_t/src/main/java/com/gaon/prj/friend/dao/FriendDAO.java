package com.gaon.prj.friend.dao;

import java.util.List;

import com.gaon.prj.member.vo.MemberVO;

public interface FriendDAO {
	public List<MemberVO> getFollowingList(String id);
	public List<MemberVO> getFollowerList(String id);
	public List<MemberVO> getMemberList();
}
