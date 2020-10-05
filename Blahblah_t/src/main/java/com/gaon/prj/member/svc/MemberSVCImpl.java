package com.gaon.prj.member.svc;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.gaon.prj.member.dao.MemberDAO;
import com.gaon.prj.member.vo.MemberVO;

@Service
public class MemberSVCImpl implements MemberSVC {
	@Inject
	@Qualifier("memberDAOImpl")
	MemberDAO memberDAO;
	
	@Override
	public int newMember(MemberVO memberVO) {
		return memberDAO.newMember(memberVO);
	}
	
	@Override
	public MemberVO memberCheck(MemberVO memberVO) {
		return memberDAO.memberCheck(memberVO);
	}
	
	@Override
	public String pwCheck(String id) {
		return memberDAO.pwCheck(id);
	}
	@Override
	public Map<String, Boolean> getIDInfo(String id){
		return memberDAO.getIDInfo(id);
	}
	@Override
	public Map<String,Boolean> sendEmailforPW(String email){
		return memberDAO.sendEmailforPW(email);
	}

	@Override
	public Map<String, Boolean> updatePw(HashMap<String,String> randPWInfo){
		return memberDAO.updatePw(randPWInfo);
	}
}