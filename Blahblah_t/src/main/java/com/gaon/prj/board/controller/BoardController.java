package com.gaon.prj.board.controller;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaon.prj.board.svc.BoardSVC;
import com.gaon.prj.board.vo.BoardVO;
import com.gaon.prj.member.vo.MemberVO;
import com.gaon.prj.paging.PagingVO;
import com.gaon.prj.reply.ReplyVO;

@Controller
@RequestMapping(value = "/board/*")
public class BoardController {
	@Inject
	BoardSVC boardSVC;

	@RequestMapping("/boardList")
	public String boardList(Model model, PagingVO paging, @RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "title") String searchOption,
			@RequestParam(defaultValue = "") String keyword) {

		int totalCnt = boardSVC.countBoard(paging);
		paging = new PagingVO(totalCnt, curPage);
		paging.setSearchOption(searchOption);
		paging.setKeyword(keyword);
		List<BoardVO> list = boardSVC.boardList(paging);

		model.addAttribute("paging", paging);
		model.addAttribute("list", list);
		return "board/boardList";
	}

	@RequestMapping("/writeBoard")
	public String writingBoardForm() {
		return "board/writeBoard";
	}

	@GetMapping(value = "/viewBoard/{pnum}")
	public String viewBoard(@PathVariable("pnum") int pnum, BoardVO view, Model model, ReplyVO replyVO) {
		view = boardSVC.viewBoard(pnum);
		boardSVC.increaseRcnt(pnum);
		model.addAttribute("view", view);
		List<ReplyVO> replyList = boardSVC.replyList(pnum);
		model.addAttribute("replyList", replyList);
		return "board/viewBoard";
	}

	@ResponseBody
	@RequestMapping(value = "/writeTextBoard", method = RequestMethod.POST, produces = "application/json")
	public int writeTextBoard(@RequestBody HashMap<String, String> boardInfo, BoardVO boardVO) {
		boardVO.setWriter(boardInfo.get("writer"));
		boardVO.setTitle(boardInfo.get("title"));
		boardVO.setContent(boardInfo.get("content"));
		return boardSVC.writeBoard(boardVO);
	}

	@RequestMapping(value = "/loginWriteBoard", method = RequestMethod.POST)
	public String loginWriteBoard(HttpSession session) {
		if (session.getAttribute("member") != null) {
			return "board/writeBoard";
		} else {
			return "member/loginForm";
		}
	}

	@GetMapping(value = "/updateViewForm")
	public String updateViewForm(Model model, @RequestParam("pnum") int pnum) {
		model.addAttribute("upview", boardSVC.viewBoard(pnum));
		return "board/updateViewForm";
	}

	@ResponseBody
	@RequestMapping(value = "/updateView", method = RequestMethod.POST, produces = "application/json")
	public int updateView(@RequestBody HashMap<String, String> boardInfo, BoardVO boardVO) {
		boardVO.setPnum(Integer.parseInt(boardInfo.get("pnum")));
		boardVO.setWriter(boardInfo.get("writer"));
		boardVO.setTitle(boardInfo.get("title"));
		boardVO.setContent(boardInfo.get("content"));
		return boardSVC.updateView(boardVO);
	}

	@GetMapping(value = "/deleteView")
	public String deleteView(@RequestParam("pnum") int pnum) {
		boardSVC.deleteView(pnum);
		return "board/boardList";
	}

	@GetMapping("/praiseMem")
	public String praiseMem(@RequestParam(defaultValue = "") String nickname, MemberVO memberVO) {
		memberVO.setNickname(nickname);
		boardSVC.praiseMem(memberVO);
		return "board/boardList";
	}

	@GetMapping("/danMem")
	public String danMem(@RequestParam(defaultValue = "") String nickname, MemberVO memberVO) {
		memberVO.setNickname(nickname);
		memberVO.setDcnt(boardSVC.getDcnt(memberVO));
		System.out.println(boardSVC.getDcnt(memberVO));
		boardSVC.danMem(memberVO);
		boardSVC.blacklist(memberVO);
		return "board/boardList";
	}

	@ResponseBody
	@RequestMapping(value = "/insertComment", method = RequestMethod.POST, produces = "application/json")
	public int insertComment(@RequestBody HashMap<String, String> commentInfo, ReplyVO replyVO) {
		replyVO.setBnum(Integer.parseInt(commentInfo.get("bnum")));
		replyVO.setCid(commentInfo.get("cid"));
		int parent = boardSVC.countComment(replyVO);
		replyVO.setParent(parent+1);
		replyVO.setReply(commentInfo.get("reply"));
		return boardSVC.insertComment(replyVO);
	}

	@GetMapping(value = "/deleteComment")
	public int deleteComment(@RequestParam("cnum") int cnum,ReplyVO replyVO) {
		replyVO.setCnum(cnum);
		replyVO.setDeletenum(0);
		replyVO.setReply("삭제되었습니다.");
		return boardSVC.deleteComment(replyVO);
	}

	@ResponseBody
	@RequestMapping(value = "/modifyComment", method = RequestMethod.POST, produces = "application/json")
	public int modifyComment(@RequestBody HashMap<String, String> commentInfo, ReplyVO replyVO) {
		replyVO.setCnum(Integer.parseInt(commentInfo.get("cnum")));
		replyVO.setReply(commentInfo.get("comment"));
		return boardSVC.modifyComment(replyVO);
	}

	@ResponseBody
	@RequestMapping(value = "/replyComment", method = RequestMethod.POST, produces = "application/json")
	public int replyComment(@RequestBody HashMap<String, String> commentInfo, ReplyVO replyVO) {
		replyVO.setBnum(Integer.parseInt(commentInfo.get("bnum")));
		replyVO.setCid(commentInfo.get("cid"));
		replyVO.setParent(Integer.parseInt(commentInfo.get("parent")));
		int depth = boardSVC.countReply(replyVO);
		replyVO.setDepth(depth);
		replyVO.setReply(commentInfo.get("reply"));
		return boardSVC.replyComment(replyVO);
	}
}