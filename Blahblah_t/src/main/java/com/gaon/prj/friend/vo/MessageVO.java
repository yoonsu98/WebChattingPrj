package com.gaon.prj.friend.vo;
import java.sql.Date;

import lombok.Data;
@Data
public class MessageVO {
	private String mtitle; //MTITLE	VARCHAR2(100 BYTE)	Yes	"'notitle' "	1	메세지제목
	private String mcontent;//MCONTENT	VARCHAR2(1000 BYTE)	Yes	"'nocontent' "	2	메세지내용
	private String mtoid;//MTOID	VARCHAR2(40 BYTE)	No		3	받는사람
	private String mfromid;//MFROMID	VARCHAR2(40 BYTE)	No		4	보낸사람
	private Date mdate;//MDATE	TIMESTAMP(6)	Yes	"SYSTIMESTAMP "	5	보낸시간
}
