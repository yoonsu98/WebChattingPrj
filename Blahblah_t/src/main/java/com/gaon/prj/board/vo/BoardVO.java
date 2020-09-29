package com.gaon.prj.board.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardVO {
	private String writer;				//writer	VARCHAR2(40 BYTE)	No		1	글 작성자
	private String title;				//TITLE	VARCHAR2(100 BYTE)	No		2	글 제목
	private String content;		//CONTENT	VARCHAR2(1000 BYTE)	No		3	글 내용
	private int rcnt;			//RCNT	NUMBER	Yes	"0"	4	조회수
	private int pnum;			//PNUM	NUMBER	YES	"0"	5	글번호
	private Date wdate;				//WDATE	TIMESTAMP	Yes	"systimestamp"	6	글 작성일
}
