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
	function submitAddForm(){
		if($("#title").val() == ""){
			alert("제목을 입력하세요.");
			$("#title").focus();
			return false;
		}
	}
</script>
<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	
	<main>
		<div class="container">
			<h3>채팅방 생성</h3>
			<div class="con">
				<form name="addForm" onsubmit="return submitAddForm();" action="${pageContext.request.contextPath}/videochatting/doAdd" method="POST">
					<span>채팅방 이름</span>
					<div>
						<input type="text" id="title" name="title"  maxlength="30" placeholder="제목"/>
						<input type="hidden" id="id" name="id" value="${sessionScope.member.id }"/>
					</div>
					<div>
						<input type="submit" value="생성" />
					</div>
				</form>
			</div>
		</div>
	</main>

	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>

</body>
</html>