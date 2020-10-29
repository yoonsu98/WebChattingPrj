<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Home</title>
<style>
.panel-title {
	text-align: center;
}
</style>
</head>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function pagingMove(curPage){
    	location.href = "chatList.do?curPage="+curPage;
  }
</script>
<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<%@ include file="/resources/include/main/nav.jsp"%>

	<main>
		<div class="container">
			<ul class="list-group">
				<li class="list-group-item">방제목<span class="badge">아이디</span></li>
				<c:forEach var="row" items="${list }">
					<li class="list-group-item"><a
						href="${pageContext.request.contextPath }/chatroom/chat.do/${row.cno }?bang_id=${row.title}">${row.title }</a><span
						class="badge">${row.id }</span></li>
				</c:forEach>
			</ul>
			<button type="button" class="btn btn-primary"
				onClick="location.href='${pageContext.request.contextPath}/chatroom/add.do'">방생성</button>
		</div>
	</main>
	<div class="container-fluid text-center bg-grey">
		<div class="row">
			<div class="col">
				<ul class="btn-group pagination">
					<c:if test="${paging.curPage ne 1}">
						<li class="page-item"><a class="page-link" a href="#"
							onClick="pagingMove(1)"><<</a></li>
					</c:if>
					<c:if test="${paging.curPage ne 1}">
						<li class="page-item"><a class="page-link" a href="#"
							onClick="pagingMove(${paging.prevPage })"><</a></li>
					</c:if>
					<c:forEach var="pageNum" begin="${paging.startPage }"
						end="${paging.endPage }">
						<c:choose>
							<c:when test="${pageNum eq  paging.curPage}">
								<li class="page-item"><span style="font-weight: bold;">
										<a class="page-link" a href="#"
										onClick="pagingMove(${pageNum })"
										style="font-weight: bold; color: red;"> ${pageNum } </a>
								</span></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link" a href="#"
									onClick="pagingMove(${pageNum })">${pageNum }</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if
						test="${paging.curPage ne paging.pageCnt && paging.pageCnt > 0}">
						<li class="page-item"><a class="page-link" a href="#"
							onClick="pagingMove(${paging.nextPage })">></a></li>
					</c:if>
					<c:if
						test="${paging.curRange ne paging.rangeCnt && paging.rangeCnt > 0}">
						<li class="page-item"><a class="page-link" a href="#"
							onClick="pagingMove(${paging.pageCnt })">>></a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>

</body>
</html>