package com.gaon.prj.member.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberVO {
	private String id;				//ID	VARCHAR2(40 BYTE)	No		1	아이디
	private String pw;				//PW	VARCHAR2(40 BYTE)	No		2	비밀번호
	private String nickname;		//NICKNAME	VARCHAR2(40 BYTE)	No		3	
	private String email;			//EMAIL	VARCHAR2(100 BYTE)	No		4	
	private String phone;			//PHONE	VARCHAR2(15 BYTE)	No		5	전화번호
	private int dcnt;				//DCNT	NUMBER	Yes	"0 "	6	신고횟수
	private int gcnt;				//GCNT	NUMBER	Yes	"0 "	7	칭찬횟수
	private Date cdate;				//CDATE	TIMESTAMP(6)	Yes	"systimestamp "	8	가입날짜
}