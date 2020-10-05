package com.gaon.prj.board.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardVO {
	private int pnum;			//PNUM	NUMBER	YES	"1"	No 1	글번호
	private String writer;				//writer	VARCHAR2(40 BYTE)	No		2	글 작성자
	private String title;				//TITLE	VARCHAR2(100 BYTE)	No		3	글 제목
	private String content;		//CONTENT	VARCHAR2(1000 BYTE)	No		4	글 내용
	private int rcnt;			//RCNT	NUMBER	Yes	"0"	5	조회수
	private Date wdate;				//WDATE	TIMESTAMP	Yes	"systimestamp"	6	글 작성일
}
