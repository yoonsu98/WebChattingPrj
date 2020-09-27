        <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Post</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

</head>

<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>
	<div class="container">
		<form>
			<input type="text" name="Title" class="form-control mt-4 mb-2"
				placeholder="제목을 입력해주세요.">
			<div class="form-group">
				<textarea class="form-control" rows="25" name="Content"
					placeholder="여기를 눌러서 글을 작성할 수 있습니다." style="resize:none;"></textarea>
			</div>
			<button type="submit" class="btn btn-default pull-right">등록</button>
		</form>
	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
</body>
</html>
