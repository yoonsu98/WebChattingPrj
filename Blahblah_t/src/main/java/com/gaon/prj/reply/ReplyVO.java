package com.gaon.prj.reply;

import java.sql.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private int cnum;//CNUM	NUMBER	No	1 	1	댓글번호
	private int bnum;//BNUM	NUMBER	No	1 	2	게시글번호
	private String cid;//CID	VARCHAR2(40 BYTE)	No		3	댓쓴이
	private String reply;//REPLY	VARCHAR2(1000 BYTE)	No		4	댓글내용
	private int parent;//PARENT	NUMBER	Yes	"1 "	5	원댓글
	private int depth;//DEPTH	NUMBER	Yes	"0 "	6	대댓글
	private Date cdate;//CDATE	TIMESTAMP(6)	Yes	"systimestamp "	7	댓글작성시간
	private int deletenum;//DELETENUM	NUMBER	Yes	1 	8	삭제확인
}
