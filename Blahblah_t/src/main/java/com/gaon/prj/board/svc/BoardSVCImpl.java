package com.gaon.prj.board.svc;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.gaon.prj.board.dao.BoardDAO;
import com.gaon.prj.board.vo.BoardVO;
import com.gaon.prj.member.vo.MemberVO;
import com.gaon.prj.paging.PagingVO;
import com.gaon.prj.reply.ReplyVO;

@Service
public class BoardSVCImpl implements BoardSVC {

	@Inject
	@Qualifier("boardDAOImpl")
	BoardDAO boardDAO;

	@Override
	public int writeBoard(BoardVO boardVO) {
		return boardDAO.writeBoard(boardVO);
	}

	@Override
	public int countBoard(PagingVO paging) {
		return boardDAO.countBoard(paging);
	}

	@Override
	public List<BoardVO> boardList(PagingVO paging) {
		List<BoardVO> list = null;
		list = boardDAO.boardList(paging);
		return list;
	}

	@Override
	public BoardVO viewBoard(int pnum) {
		boardDAO.increaseRcnt(pnum);
		return boardDAO.viewBoard(pnum);
	}

	public void increaseRcnt(int pnum) {
		return;
	}
	
	@Override
	public void deleteView(int pnum) {
		boardDAO.deleteView(pnum);
	}
	
	public int updateView(BoardVO boardVO) {
		return boardDAO.updateView(boardVO);
	}
	
	public int praiseMem(MemberVO memberVO)
	{
		return boardDAO.praiseMem(memberVO);
	}
	
	public int danMem(MemberVO memberVO)
	{
		return boardDAO.danMem(memberVO);
	}
	
	public int blacklist(MemberVO memberVO)
	{
		return boardDAO.blacklist(memberVO);
	}
	
	public int getDcnt(MemberVO memberVO)
	{
		return boardDAO.getDcnt(memberVO);
	}
	
	public List<ReplyVO> replyList(int pnum)
	{
		return boardDAO.replyList(pnum);
	}
	public int insertComment(ReplyVO replyVO)
	{
		return boardDAO.insertComment(replyVO);
	}
	
	public int deleteComment(ReplyVO replyVO)
	{
		return boardDAO.deleteComment(replyVO);
	}
	
	public int modifyComment(ReplyVO replyVO)
	{
		return boardDAO.modifyComment(replyVO);
	}
	
	public int replyComment(ReplyVO replyVO)
	{
		return boardDAO.replyComment(replyVO);
	}
	
	public int countComment(ReplyVO replyVO)
	{
		return boardDAO.countComment(replyVO);
	}
	
	public int countReply(ReplyVO replyVO)
	{
		return boardDAO.countReply(replyVO);
	}
}

