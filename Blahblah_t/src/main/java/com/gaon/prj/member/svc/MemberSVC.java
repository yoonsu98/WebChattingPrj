package com.gaon.prj.member.svc;

import java.util.HashMap;
import java.util.Map;

import com.gaon.prj.member.vo.MemberVO;

public interface MemberSVC {

	public int newMember(MemberVO memberVO);
	public MemberVO memberCheck(MemberVO memberVO);
	public String pwCheck(String id);
	public Map<String, Boolean> getIDInfo(String id);
	public Map<String, Boolean> sendEmailforPW(String email);
	public Map<String, Boolean> updatePw(HashMap<String,String> randPWInfo);
}