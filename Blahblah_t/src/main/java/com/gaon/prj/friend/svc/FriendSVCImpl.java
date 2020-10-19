package com.gaon.prj.friend.svc;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.gaon.prj.friend.dao.FriendDAO;
import com.gaon.prj.member.vo.MemberVO;

@Service
public class FriendSVCImpl implements FriendSVC{
	@Inject
	@Qualifier("friendDAOImpl")
	FriendDAO friendDAO;
	@Override
	public List<MemberVO> getFollowingList(String id){
		return friendDAO.getFollowingList(id);
	}
	@Override
	public List<MemberVO> getFollowerList(String id){
		return friendDAO.getFollowerList(id);
	}
	@Override
	public List<MemberVO> getMemberList(){
		return friendDAO.getMemberList();
	}
}