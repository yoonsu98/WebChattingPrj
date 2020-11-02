package com.gaon.prj.board.svc;

import java.util.List;

import com.gaon.prj.board.vo.BoardVO;
import com.gaon.prj.member.vo.MemberVO;
import com.gaon.prj.paging.PagingVO;
import com.gaon.prj.reply.ReplyVO;

public interface BoardSVC {
	public int writeBoard(BoardVO boardVO);
	public List<BoardVO> boardList(PagingVO paging);
	public BoardVO viewBoard(int pnum);
	public int countBoard(PagingVO paging);
	public void increaseRcnt(int pnum);
	public void deleteView(int pnum);
	public int updateView(BoardVO boardVO);
	public int praiseMem(MemberVO memberVO);
	public int danMem(MemberVO memberVO);
	public int blacklist(MemberVO memberVO);
	public int getDcnt(MemberVO memberVO);
	public List<ReplyVO> replyList(int pnum);
	public int insertComment(ReplyVO replyVO);
	public void deleteComment(int cnum);
	public int modifyComment(ReplyVO replyVO);
}
