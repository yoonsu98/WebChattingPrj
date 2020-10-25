package com.gaon.prj.friend.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gaon.prj.friend.vo.MessageVO;
import com.gaon.prj.member.vo.MemberVO;

@Repository
public class FriendDAOImpl implements FriendDAO {
	@Inject
	private SqlSession sqlSession;
	@Override
	public List<MemberVO> getFollowingList(String id){
		List<MemberVO>followingMemberInfo = sqlSession.selectList("mappers.FriendDAO-mapper.getFollowingMemberInfo",id);
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
		return memberInfo;
	}

	@Override
	public MemberVO getOneMemberInfo(String id){
		MemberVO oneMemberInfo = sqlSession.selectOne("mappers.FriendDAO-mapper.getOneMemberInfo",id);
		return oneMemberInfo;
	}

	@Override
	public Map<String, Boolean> setFollowing(HashMap<String,String> IDInfo){

		int a = sqlSession.insert("mappers.FriendDAO-mapper.setFollowing", IDInfo);
		Map<String, Boolean> chkResult = new HashMap<>();
		if (a == 1)
			chkResult.put("chkResult", true);
		else
			chkResult.put("chkResult", false);
		return chkResult;
	}
	@Override
	public Map<String, Boolean> setUnFollowing(HashMap<String,String> IDInfo){
		int a = sqlSession.insert("mappers.FriendDAO-mapper.setUnFollowing", IDInfo);
		Map<String, Boolean> chkResult = new HashMap<>();
		if (a == 1)
			chkResult.put("chkResult", true);
		else
			chkResult.put("chkResult", false);
		return chkResult;
	}
	@Override
	public Map<String, Boolean> getFollowState(HashMap<String,String> IDInfo){

		String a = sqlSession.selectOne("mappers.FriendDAO-mapper.getFollowState", IDInfo);
		Map<String, Boolean> chkResult = new HashMap<>();
		if (a ==null)
			chkResult.put("chkResult", true);
		else
			chkResult.put("chkResult", false);
		return chkResult;
	}
	@Override
	public Map<String, Boolean> sendDM(HashMap<String,String> messageInfo){

		
		 int a = sqlSession.insert("mappers.FriendDAO-mapper.sendDM",messageInfo);
		 
		Map<String, Boolean> chkResult = new HashMap<>();
		
		 if (a == 1) chkResult.put("chkResult", true);
		 else chkResult.put("chkResult", false);
		return chkResult;
	}
	@Override
	public List<MessageVO> getSendMessageList(String id){
		List<MessageVO>sendMessageList = sqlSession.selectList("mappers.FriendDAO-mapper.getSendMessageList",id);
		return sendMessageList;
	}
	@Override
	public List<MessageVO> getReceiveMessageList(String id){
		List<MessageVO>receiveMessageList = sqlSession.selectList("mappers.FriendDAO-mapper.getReceiveMessageList",id);
		return receiveMessageList;
	}
	@Override
	public MessageVO getDMDetail(String messageID) {
		MessageVO detailDM = sqlSession.selectOne("mappers.FriendDAO-mapper.getDMDetail",messageID);
		return detailDM;
	}
	
	@Override
	public Integer countFiidList() {
		return sqlSession.selectOne("mappers.FriendDAO-mapper.countFiidList");
	}
	
	@Override
	public Integer countFeidList() {
		return sqlSession.selectOne("mappers.FriendDAO-mapper.countFeidList");
	}
}
