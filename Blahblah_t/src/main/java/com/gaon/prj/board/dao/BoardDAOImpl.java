package com.gaon.prj.board.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gaon.prj.board.vo.BoardVO;
import com.gaon.prj.member.vo.MemberVO;
import com.gaon.prj.paging.PagingVO;
import com.gaon.prj.reply.ReplyVO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sqlSession;

	@Override
	public int writeBoard(BoardVO boardVO) {
		return sqlSession.insert("mappers.BoardDAO-mapper.writeBoard", boardVO);
	}

	@Override
	public int countBoard(PagingVO paging) {
		return sqlSession.selectOne("mappers.BoardDAO-mapper.countBoard",paging);
	}

	@Override
	public List<BoardVO> boardList(PagingVO paging) {
		return sqlSession.selectList("mappers.BoardDAO-mapper.boardList", paging);
	}

	@Override
	public BoardVO viewBoard(int pnum) {
		return sqlSession.selectOne("mappers.BoardDAO-mapper.viewBoard", pnum);
	}

	@Override
	public void increaseRcnt(int pnum) {
		sqlSession.update("mappers.BoardDAO-mapper.increaseRcnt", pnum);
	}

	@Override
	public int updateView(BoardVO boardVO) {
		return sqlSession.update("mappers.BoardDAO-mapper.updateView", boardVO);
	}

	@Override
	public void deleteView(int pnum) {
		sqlSession.delete("mappers.BoardDAO-mapper.deleteView", pnum);
	}
	@Override
	public int praiseMem(MemberVO memberVO)
	{
		return sqlSession.update("mappers.BoardDAO-mapper.praiseMem",memberVO);
	}
	
	@Override
	public int danMem(MemberVO memberVO)
	{
		return sqlSession.update("mappers.BoardDAO-mapper.danMem",memberVO);
	}
	
	@Override
	public int blacklist(MemberVO memberVO)
	{
		return sqlSession.insert("mappers.BoardDAO-mapper.blacklist",memberVO);
	}
	
	@Override
	public int getDcnt(MemberVO memberVO)
	{
		return sqlSession.selectOne("mappers.BoardDAO-mapper.getDcnt",memberVO);
	}
	
	@Override
	public List<ReplyVO> replyList(int pnum)
	{
		return sqlSession.selectList("mappers.BoardDAO-mapper.replyList",pnum);
	}
	
	@Override
	public int insertComment(ReplyVO replyVO)
	{
		return sqlSession.insert("mappers.BoardDAO-mapper.comment",replyVO);
	}
	
	@Override
	public int deleteComment(ReplyVO replyVO)
	{
		return sqlSession.update("mappers.BoardDAO-mapper.deleteComment",replyVO);
	}
	
	public int modifyComment(ReplyVO replyVO)
	{
		return sqlSession.update("mappers.BoardDAO-mapper.modifyComment",replyVO);
	}
	
	public int replyComment(ReplyVO replyVO)
	{
		return sqlSession.update("mappers.BoardDAO-mapper.replyComment",replyVO);
	}
	
	public int countComment(ReplyVO replyVO)
	{
		return sqlSession.selectOne("mappers.BoardDAO-mapper.countComment",replyVO);
	}
	
	public int countReply(ReplyVO replyVO)
	{
		return sqlSession.selectOne("mappers.BoardDAO-mapper.countReply",replyVO);
	}
}


