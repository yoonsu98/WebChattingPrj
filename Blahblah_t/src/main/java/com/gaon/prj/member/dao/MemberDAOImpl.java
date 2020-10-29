package com.gaon.prj.member.dao;

import org.slf4j.LoggerFactory;
import javax.mail.internet.MimeMessage;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import javax.inject.Inject;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Repository;
import org.apache.ibatis.session.SqlSession;

import com.gaon.prj.member.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	@Inject
	private SqlSession sqlSession;
	@Autowired
	private JavaMailSender mailSender;

	@Override
	public int newMember(MemberVO memberVO) {
		return sqlSession.insert("mappers.MemberDAO-mapper.newMember", memberVO);
	}

	@Override
	public MemberVO memberCheck(MemberVO memberVO) {
		return sqlSession.selectOne("mappers.MemberDAO-mapper.memberCheck", memberVO);
	}

	@Override
	public String pwCheck(String id) {
		return sqlSession.selectOne("mappers.MemberDAO-mapper.idCheck", id);
	}

	@Override
	public Map<String, Boolean> getIDInfo(String id) {
		String a = sqlSession.selectOne("mappers.MemberDAO-mapper.getIDInfo", id);
		Map<String, Boolean> chkResult = new HashMap<>();
		System.out.println(a);
		if (a == null)
			chkResult.put("chkResult", true);
		else
			chkResult.put("chkResult", false);

		System.out.println(chkResult);
		return chkResult;
	}

	@Override
	public Map<String, Boolean> sendEmailforPW(String email) {
		String a = sqlSession.selectOne("mappers.MemberDAO-mapper.sendEmailforPW", email);
		Map<String, Boolean> chkResult = new HashMap<>();
		if (a == null)
			chkResult.put("chkResult", false);
		else {
			/*
			 * MemberVO tempMember = new MemberVO(); String setfrom = "224wltn@gmail.com";
			 * String tomail = email; // 받는 사람 이메일 // String title =
			 * request.getParameter("title"); // 제목 // String content =
			 * request.getParameter("content"); // 내용
			 * 
			 * try { String newPass = makeRandomPassword(); MimeMessage message =
			 * mailSender.createMimeMessage(); MimeMessageHelper messageHelper = new
			 * MimeMessageHelper(message, true, "UTF-8");
			 * 
			 * messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			 * messageHelper.setTo(tomail); // 받는사람 이메일
			 * messageHelper.setSubject("BlahBlah 새로운 비밀번호 입니다."); // 메일제목은 생략이 가능하다
			 * messageHelper.setText("새로운 비밀번호는 [  " + newPass + "  ]입니다."); // 메일 내용
			 * 
			 * mailSender.send(message);
			 * 
			 * 
			 * tempMember.setEmail(email); tempMember.setPw(pwEncoder.encode(newPass));
			 * sqlSession.update("mapper.MemberDAO-mapper.updatePW", tempMember);
			 * 
			 * // pwEncoder.encode(newPass);
			 * 
			 * chkResult.put("chkResult", true);
			 * 
			 * } catch (Exception e) { System.out.println(e); chkResult.put("chkResult",
			 * false); }
			 */
			chkResult.put("chkResult", true);
		}
		return chkResult;
	}

	@Override
	public Map<String, Boolean> updatePw(HashMap<String, String> randPWInfo) {
		Map<String, Boolean> chkResult = new HashMap<>();
		MemberVO tempMember = new MemberVO();
		String setfrom = "224wltn@gmail.com";
		String tomail = randPWInfo.get("email"); // 받는 사람 이메일
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(tomail); // 받는사람 이메일
			messageHelper.setSubject("BlahBlah 새로운 비밀번호 입니다."); // 메일제목은 생략이 가능하다
			messageHelper.setText("새로운 비밀번호는 [  " + randPWInfo.get("originPW") + "  ]입니다."); // 메일 내용
			mailSender.send(message);

			
			 tempMember.setEmail(randPWInfo.get("email"));
			 tempMember.setPw(randPWInfo.get("encodePW"));
			 try{
				 sqlSession.update("mappers.MemberDAO-mapper.updatePw", tempMember);

					chkResult.put("chkResult", true);
			 }catch(Exception e2) {
					chkResult.put("chkResult", false);
			 }

		} catch (Exception e) {
			chkResult.put("chkResult", false);
		}

		return chkResult;
	}
	
	@Override
	public String findID(String email) {
		return sqlSession.selectOne("mappers.MemberDAO-mapper.findID",email);
	}

}