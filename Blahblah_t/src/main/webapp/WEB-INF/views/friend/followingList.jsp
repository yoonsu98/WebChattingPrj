<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Home</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

<script>
console.log("dd");
console.log(${followingList});

function pagingMove(curPage){
	location.href = "followingList?curPage="+curPage;
}
</script>
</head>
<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>
	<!-- main -->
	<div class="container text-center">
		<table class="table" style="text-align: center;">
			<caption>following list</caption>
			<thead>
				<tr>
					<th class="text-center">id</th>
					<th class="text-center">nickname</th>
					<th class="text-center">country</th>
				</tr>
				<c:forEach var="member" items="${followingList}">
					<tr>
						<th class="text-center">${member.id }</th>
						<th class="text-center">${member.nickname }</th>
					</tr>
				</c:forEach>
			</thead>
		</table>
	</div>
	<div class="container">
		<div class="text-center">
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
	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>

</body>
</html>