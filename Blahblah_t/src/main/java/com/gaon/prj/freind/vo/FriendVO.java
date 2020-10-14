package com.gaon.prj.freind.vo;
import java.sql.Date;
import lombok.Data;
@Data
public class FriendVO {
	private String fiid;//FIID	VARCHAR2(40 BYTE)	No		1	팔로잉아이디
	private String feid;//FEID	VARCHAR2(40 BYTE)	No		2	팔로워아이디
}
