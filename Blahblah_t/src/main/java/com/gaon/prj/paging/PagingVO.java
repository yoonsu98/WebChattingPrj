package com.gaon.prj.paging;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class PagingVO {
	/** 한 페이지당 게시글 수 **/
	private int pageSize = 10;

	/** 한 블럭(range)당 페이지 수 **/
	private int rangeSize = 5;

	/** 현재 페이지 **/
	private int curPage = 1;

	/** 현재 블럭(range) **/
	private int curRange = 1;

	/** 총 게시글 수 **/
	private int totalCnt;

	/** 총 페이지 수 **/
	private int pageCnt;

	/** 총 블럭(range) 수 **/
	private int rangeCnt;

	/** 시작 페이지 **/
	private int startPage = 1;

	/** 끝 페이지 **/
	private int endPage;

	/** 이전 페이지 **/
	private int prevPage;

	/** 다음 페이지 **/
	private int nextPage;

	/** sql용 **/
	private int start;
	private int end;

	/** 검색용 **/
	private String keyword;
	private String searchOption;

	public PagingVO() {
	}

	public PagingVO(int totalCnt, int curPage) {

		/**
		 * 페이징 처리 순서 1. 총 페이지수 2. 총 블럭(range)수 3. range setting
		 */

		/** 현재페이지 **/
		this.curPage = curPage;
		/** 총 게시물 수 **/
		this.totalCnt = totalCnt;
		

		/** 1. 총 페이지 수 **/
		setPageCnt(totalCnt);
		/** 2. 총 블럭(range)수 **/
		setRangeCnt(pageCnt);
		/** 3. 블럭(range) setting **/
		rangeSetting(curPage);

		calcStartEnd(curPage, pageSize);
	}

	public void calcStartEnd(int curPage, int pageSize) {
		setStart((curPage - 1) * pageSize + 1);
		setEnd(curPage * pageSize);
	}

	public void setPageCnt(int totalCnt) {
		this.pageCnt = (int) Math.ceil(totalCnt * 1.0 / pageSize);
	}

	public void setRangeCnt(int pageCnt) {
		this.rangeCnt = (int) Math.ceil(pageCnt * 1.0 / rangeSize);
	}

	public void rangeSetting(int curPage) {

		setCurRange(curPage);
		this.startPage = (curRange - 1) * rangeSize + 1;
		this.endPage = startPage + rangeSize - 1;

		if (endPage > pageCnt) {
			this.endPage = pageCnt;
		}

		this.prevPage = curPage - 1;
		this.nextPage = curPage + 1;
	}

	public void setCurRange(int curPage) {
		this.curRange = (int) ((curPage - 1) / rangeSize) + 1;
	}

	public String makeQuery(int curPage) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("curPage", curPage).build();
		return uriComponents.toUriString();
	}

	public String makeSearch(int curPage) {

		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("curPage", curPage)
				.queryParam("searchOption", getSearchOption())
				.queryParam("keyword", encoding(getKeyword())).build();
		return uriComponents.toUriString();
	}

	private String encoding(String keyword) {
		if (keyword == null || keyword.trim().length() == 0) {
			return "";
		}

		try {
			return URLEncoder.encode(keyword, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return "";
		}
	}

	@Override
	public String toString() {
		return "PagingVO [searchOption=" + searchOption + ", keyword=" + keyword + "]";
	}
}
