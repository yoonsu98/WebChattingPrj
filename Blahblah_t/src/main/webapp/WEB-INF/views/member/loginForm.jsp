<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/custom.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script type="text/javascript">
	window.onload = function() {
		let fs = document.getElementById('id') // 포커스 변수
		fs.focus();
	};
</script>

</head>
<script>

	$(document).ready(function(){
	    $("#pw").keypress(function (e){
	    	if (e.which == 13){
	    		fn_loginFn()
	        }
	    });
	});
	function fn_loginFn() {

		let id = document.getElementById('id').value;
		let pw = document.getElementById('pw').value;
		const memberInfo = JSON.stringify({
			id : id,
			pw : pw
		});
		$.ajax({
			data : memberInfo,
			url : "${contextPath}/prj/member/login",
			type : "post",
			dataType : "text",
			contentType : "application/json; charset=UTF-8",
			success : function(data) {
				console.log(data);
				if (data == 1) {
					alert("로그인 되었습니다.");
					location.href = "${contextPath}/prj";
				} else {
					alert("회원정보를 다시 확인해주세요.");
				}
			},
			error : function(data) {
				alert("실패");
			}
		})
	}
</script>
<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>

	<div class="container">
		<div class="jumbotron">
			<form action="#">
				<div class="form-group">
					<label for="id"></label> <input type="text" class="form-control"
						id="id" name="id" placeholder="아이디">
				</div>
				<div class="form-group">
					<label for="pw"></label> <input type="password"
						class="form-control" id="pw" name="pw" placeholder="비밀번호">
				</div>
				<div class="checkbox">
					<label><input type="checkbox"> 아이디 저장 </label>
				</div>
				<button type="button" onClick="fn_loginFn()" class="btn btn-default">로그인</button>
				<input type="button" class="btn btn-default"
					onClick="location.href='/prj/member/joinForm'" value="회원가입">
				<input type="button" class="btn btn-default" value="아이디 찾기">
				<button type="button" class="btn btn-default" id="findPWbtn">
					비밀번호 찾기</button>
			</form>
		</div>
	</div>
	<!-- The Modal -->
	<div id="FindPassWordPopup" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<div>
				<span class="close">&times;</span>
				<p>비밀번호찾기</p>
			</div>
			<div class="form-group">
				<label for="EntertheEmail"></label> <input type="text"
					class="form-control" id="EntertheEmail" name="EntertheEmail"
					placeholder="이메일 입력">
				<div>
					<span id="email_check"></span>
				</div>
			</div>
			<div>
				<button type="button" onClick="ajaxCallFindPassword();"
					class="btn btn-default">임시 비밀번호 전송</button>
			</div>
		</div>

	</div>

	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>
	<script>
		// Get the modal
		var modal = document.getElementById('FindPassWordPopup');
		// Get the button that opens the modal
		var btn = document.getElementById("findPWbtn");
		// Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];
		// When the user clicks on the button, open the modal 
		btn.onclick = function() {
			modal.style.display = "block";
		}
		// When the user clicks on <span> (x), close the modal
		span.onclick = function() {
			modal.style.display = "none";
		}
		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
			if (event.target == modal) {
				modal.style.display = "none";
			}
		}
		function emailchk() {
			var input_email = $('#EntertheEmail');
			var cemail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+$/; //이메일형식
			if (input_email.val() == "") {
				$("#email_check").text("이메일을 입력해주세요.");
				$("#email_check").css('color', 'red');
				return;
			} else if (cemail.test(input_email.val()) != true) {
				$("#email_check").text("정확한 이메일 형식을 입력해주세요.");
				$("#email_check").css('color', 'red');
				return;
			} else {
				$("#email_check").text("");
			}
			return 1;
		}
		function ajaxCallFindPassword() {
			var chkemailExist = 0;
			if (emailchk()) {
				let email = document.getElementById('EntertheEmail').value;
				const emailInfo = JSON.stringify({
					email : email
				});
				$.ajax({
					data : emailInfo,
					url : "${contextPath}/prj/member/sendEmailforPW",
					type : "post",
					dataType : "json",
					contentType : "application/json; charset=UTF-8",
					success : function(data) {
						if (data.chkResult) {
							chkemailExist = 1;
							ajaxCallUpdatePassword(email);
						} else {
							$("#email_check").text("존재하지 않는 정보입니다.");
							$("#email_check").css('color', 'red');
						}
					},
					error : function(e) {
						console.log("실패");
					}
				});
			}
		}
		function ajaxCallUpdatePassword(email) {

			const emailInfo = JSON.stringify({
				email : email
			});
			$.ajax({
				data : emailInfo,
				url : "${contextPath}/prj/member/updatePw",
				type : "post",
				dataType : "json",
				contentType : "application/json; charset=UTF-8",
				success : function(data) {
					if (data.chkResult) {
						alert("임시비밀번호가 전송되었습니다. 메일을 확인해주세요 ");
						modal.style.display = "none";
					} else {
						$("#email_check").text("메일전송에 실패하였습니다.");
						$("#email_check").css('color', 'red');
					}
				},
				error : function(e) {
					console.log("실패");
				}
			});
		}
	</script>
</body>
</html>