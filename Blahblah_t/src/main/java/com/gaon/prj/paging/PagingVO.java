package com.gaon.prj.paging;

@lombok.Data
public class PagingVO {
	private int pageSize = 10; //페이지당 게시물 수
	private int rangeSize = 5; //화면당 페이지 크기
	private int curPage; //현재 페이지
	private int totalList; //전체 게시글 수
	private int totalPage; //페이지 수
	private int startPage; //시작페이지
	private int lastPage; //마지막페이지
	private boolean prePage; //이전 페이지
	private boolean nextPage; //다음 페이지
	
	public void calcLastPage(int totalList, int rangeSize) {
		setLastPage((int)Math.ceil((double)totalList/ (double)rangeSize));
	}
	
}