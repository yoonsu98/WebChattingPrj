package com.gaon.prj.friend.svc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gaon.prj.member.vo.MemberVO;

public interface FriendSVC {
	public List<MemberVO> getFollowingList(String id);
	public List<MemberVO> getFollowerList(String id);
	public List<MemberVO> getMemberList();
	public MemberVO getOneMemberInfo(String id);
	public Map<String, Boolean> setFollowing(HashMap<String, String> IDInfo);
}