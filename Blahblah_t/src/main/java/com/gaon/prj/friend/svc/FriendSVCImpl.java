package com.gaon.prj.friend.svc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import com.gaon.prj.friend.dao.FriendDAO;
import com.gaon.prj.friend.vo.MessageVO;
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
	@Override
	public MemberVO getOneMemberInfo(String id){
		return friendDAO.getOneMemberInfo(id);
	}

	@Override
	public Map<String, Boolean> setFollowing(HashMap<String,String> IDInfo){
		return friendDAO.setFollowing(IDInfo);
	}
	@Override
	public Map<String, Boolean> setUnFollowing(HashMap<String,String> IDInfo){
		return friendDAO.setUnFollowing(IDInfo);
	}
	@Override
	public Map<String, Boolean> getFollowState(HashMap<String,String> IDInfo){
		return friendDAO.getFollowState(IDInfo);
	}
	@Override
	public Map<String, Boolean> sendDM(HashMap<String,String> messageInfo){
		return friendDAO.sendDM(messageInfo);
	}
	@Override
	public List<MessageVO> getSendMessageList(String id){
		return friendDAO.getSendMessageList(id);
	}
	@Override
	public List<MessageVO> getReceiveMessageList(String id){
		return friendDAO.getReceiveMessageList(id);
	}
	public MessageVO getDMDetail(String messageID) {
		return friendDAO.getDMDetail(messageID);
	}
	
	public Integer countFiidList() {
		return friendDAO.countFiidList();
	}
	public Integer countFeidList() {
		return friendDAO.countFeidList();
	}
}