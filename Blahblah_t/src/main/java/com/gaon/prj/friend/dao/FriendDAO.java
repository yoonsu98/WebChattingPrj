package com.gaon.prj.friend.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gaon.prj.member.vo.MemberVO;

public interface FriendDAO {
	public List<MemberVO> getFollowingList(String id);
	public List<MemberVO> getFollowerList(String id);
	public List<MemberVO> getMemberList();
	public MemberVO getOneMemberInfo(String id);
	public Map<String, Boolean> setFollowing(HashMap<String, String> IDInfo);
	public Map<String, Boolean> sendDM(HashMap<String, String> messageInfo);
}
