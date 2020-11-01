package com.gaon.prj.videochatting.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class VideoChatroomVO {
	private int vcno;//VCNO	NUMBER	Yes	"0"	1	
	private String vcid;//VCID	VARCHAR2(40 BYTE)	No		2	방생성자
	private String vctitle;//VCTITLE	VARCHAR2(100 BYTE)	No		3	방제목
	private Date vcdate;//VCDATE	TIMESTAMP(6)	No	systimestamp 	4	방생성일
	private int vcpeople;//VCPEOPLE	NUMBER	No	1 
}
