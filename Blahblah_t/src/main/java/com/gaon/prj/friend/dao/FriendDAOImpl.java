package com.gaon.prj.friend.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gaon.prj.member.vo.MemberVO;

@Repository
public class FriendDAOImpl implements FriendDAO {
	@Inject
	private SqlSession sqlSession;
	@Override
	public List<MemberVO> getFollowingList(String id){
		List<MemberVO>followingMemberInfo = sqlSession.selectList("mappers.FriendDAO-mapper.getFollowingMemberInfo",id);
		System.out.println(followingMemberInfo);
		return followingMemberInfo;
	}
	@Override
	public List<MemberVO> getFollowerList(String id){
		List<MemberVO>followerMemberInfo = sqlSession.selectList("mappers.FriendDAO-mapper.getFollowerMemberInfo",id);
		
		return followerMemberInfo;
	}
	@Override
	public List<MemberVO> getMemberList(){
		List<MemberVO>memberInfo = sqlSession.selectList("mappers.FriendDAO-mapper.getMemberInfo");
		System.out.println(memberInfo);
		return memberInfo;
	}
}
