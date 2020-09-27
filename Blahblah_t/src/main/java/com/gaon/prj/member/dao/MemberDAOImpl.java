package com.gaon.prj.member.dao;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Repository;
import org.apache.ibatis.session.SqlSession;

import com.gaon.prj.member.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int newMember(MemberVO memberVO) {
		return sqlSession.insert("mappers.MemberDAO-mapper.newMember",memberVO);
	}
	@Override
	public MemberVO memberCheck(MemberVO memberVO) {
		return sqlSession.selectOne("mappers.MemberDAO-mapper.memberCheck",memberVO);
	}
	@Override
	public String pwCheck(String id) {
		return sqlSession.selectOne("mappers.MemberDAO-mapper.idCheck",id);
	}
	@Override
	public Map<String, Boolean> getIDInfo(String id){
		String a = sqlSession.selectOne("mappers.MemberDAO-mapper.getIDInfo",id);
		Map<String, Boolean> chkResult = new HashMap<>();
		if( a== null) chkResult.put("chkResult", true);
		else chkResult.put("chkResult", false);
		return chkResult;
	}
	@Override
	public Map<String,Boolean> sendEmailforPW(String email){
		String a = sqlSession.selectOne("mappers.MemberDAO-mapper.sendEmailforPW",email);
		Map<String, Boolean> chkResult = new HashMap<>();
		if( a== null) chkResult.put("chkResult", false);
		else chkResult.put("chkResult", true);
		return chkResult;
	}
}                