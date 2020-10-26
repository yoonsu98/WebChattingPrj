<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Board</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

</head>

<script>
	function pagingMove(curPage) {
		location.href = "boardList" + '${paging.makeSearch(curPage)}';
	}

	function searchView() {
		var inputSearchOption = $('#searchOptionSel');
		var inputKeyword = $('#keyword');

		if (inputKeyword.val() == "") {
			alert("검색어를 입력하세요.");
			return;
		} else {

			var url = "boardList" + '${paging.makeQuery(1)}' + "&searchOption="
					+ inputSearchOption.val() + "&keyword="
					+ encodeURIComponent(inputKeyword.val());
		}
		window.location.href = url;
	}
</script>
<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>

	<div class="container">
		<div class="text-center">
			<select id="searchOptionSel" name="">
				<option value="title"<c:out value="${paging.searchOption=='title'?'selected':'' }"/>>제목</option>
				<option value="content"<c:out value="${paging.searchOption=='content'?'selected':'' }"/>>내용</option>
				<option value="writer"<c:out value="${paging.searchOption=='writer'?'selected':'' }"/>>작성자</option>
			</select> <input name="keyword" id="keyword" type="text"
				value="${paging.keyword }">
			<button id="searrchBtn" class="btn btn-primary"
				onClick="searchView()">검색</button>

			<table class="table" style="text-align: center;">
				<thead>
					<tr>
						<th class="text-center">번호</th>
						<th class="text-center">제목</th>
						<th class="text-center">작성자</th>
						<th class="text-center">조회수</th>
						<th class="text-center">작성일</th>
					</tr>
					<c:forEach var="board" items="${list}">
						<tr>
							<th class="text-center">${board.pnum }</th>
							<th class="text-center"><a href="viewBoard/${board.pnum}">${board.title }</a></th>
							<th class="text-center">${board.writer }</th>
							<th class="text-center">${board.rcnt }</th>
							<th class="text-center">${board.wdate }</th>
						</tr>
					</c:forEach>
				</thead>
			</table>
			<form method="post" action="loginWriteBoard" encType="UTF-8">
				<input type="submit" class="btn btn-default pull-right" value="글쓰기" />
			</form>

			<div class="row">
				<div class="col">
					<ul class="btn-group pagination">
						<c:if test="${paging.curPage ne 1}">
							<li class="page-item"><a class="page-link" a
								href="boardList${paging.makeSearch(1) }"><<</a></li>
						</c:if>
						<c:if test="${paging.curPage ne 1}">
							<li class="page-item"><a class="page-link" a
								href="boardList${paging.makeSearch(paging.prevPage) }"><</a></li>
						</c:if>
						<c:forEach var="pageNum" begin="${paging.startPage }"
							end="${paging.endPage }">
							<c:choose>
								<c:when test="${pageNum eq  paging.curPage}">
									<li class="page-item"><span style="font-weight: bold;">
											<a class="page-link" a
											href="boardList${paging.makeSearch(pageNum) }"
											style="font-weight: bold; color: red;"> ${pageNum } </a>
									</span></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link" a
										href="boardList${paging.makeSearch(pageNum)}">${pageNum }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if
							test="${paging.curPage ne paging.pageCnt && paging.pageCnt > 0}">
							<li class="page-item"><a class="page-link" a
								href="boardList${paging.makeSearch(paging.nextPage)}">></a></li>
						</c:if>
						<c:if
							test="${paging.curRange ne paging.rangeCnt && paging.rangeCnt > 0}">
							<li class="page-item"><a class="page-link" a
								href="boardList${paging.makeSearch(paging.pageCnt)}">>></a></li>
						</c:if>

					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>
</html>
