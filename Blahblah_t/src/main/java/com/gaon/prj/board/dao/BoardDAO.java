package com.gaon.prj.board.dao;

import java.util.List;

import com.gaon.prj.board.vo.BoardVO;
import com.gaon.prj.member.vo.MemberVO;
import com.gaon.prj.paging.PagingVO;
import com.gaon.prj.reply.ReplyVO;

public interface BoardDAO {
	public int writeBoard(BoardVO boardVO);
	public List<BoardVO> boardList(PagingVO paging);
	public BoardVO viewBoard(int pnum);
	public void increaseRcnt(int pnum);
	public int countBoard(PagingVO paging);
	public void deleteView(int pnum);
	public int updateView(BoardVO boardVO);
	public int praiseMem(MemberVO memberVO);
	public int danMem(MemberVO memberVO);
	public int blacklist(MemberVO memberVO);
	public int getDcnt(MemberVO memberVO);
	public List<ReplyVO> replyList(int pnum);
	public int insertComment(ReplyVO replyVO);
	public int deleteComment(ReplyVO replyVO);
	public int modifyComment(ReplyVO replyVO);
	public int replyComment(ReplyVO replyVO);
	public int countComment(ReplyVO replyVO);
	public int countReply(ReplyVO replyVO);
}