package com.gaon.prj.chatroom.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class ChatroomVO {
	private int cno;			//CNO	NUMBER	No		1	
	private String id;			//ID	VARCHAR2(40 BYTE)	Yes		2	방주인
	private String title;		//TITLE	VARCHAR2(100 BYTE)	Yes		3	방제목
	private Date cdate;			//CDATE	TIMESTAMP(6)	Yes	"systimestamp "	4	방생성일
}
