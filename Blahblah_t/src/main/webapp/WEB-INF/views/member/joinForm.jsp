<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Home</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	
<script type="text/javascript">
	window.onload = function() {
		let fs = document.getElementById('id') // 포커스 변수
		fs.focus();
	};
</script>
<style type="text/css">
	p.wrongpw:before{
		content:"비밀번호가 일치하지 않습니다.";
		color:red;
		font-size:13px;
	}
</style>
</head>
<script type="text/javascript">
	function idchk() {
		var input_id = $('#id');
		var cid = /^[a-z0-9_\-]{5,20}$/; //5-20 영소문자,숫자,(_),(-)
		if (input_id.val() == "") {
			$("#id_check").text("아이디를 입력해주세요.");
			$("#id_check").css('color', 'red');
			return;
		} else if (cid.test(input_id.val()) != true) {
			$("#id_check").text("5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.");
			$("#id_check").css('color', 'red');
			return;
		} else {
			$("#id_check").text("");
		}
		return 1;
	}
	function pwchk() {
		var input_pw = $('#pw');
		var cpw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-]|.*[0-9]).{8,16}$/; //8-16 영문대소문자,숫자,특수문자혼합
		if (input_pw.val() == "") {
			$("#pw_check").text("비밀번호를 입력해주세요.");
			$("#pw_check").css('color', 'red');
			return;
		} else if (cpw.test(input_pw.val()) != true) {
			$("#pw_check").text("8~16자 영문 대 소문자, 숫자, 특수기호를 사용하세요.");
			$("#pw_check").css('color', 'red');
			return;
		} else {
			$("#pw_check").text("");
		}
		return 1;
	}
	function nicknamechk() {
		var input_nickname = $('#nickname');
		var cnickname = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{3,10}$/; //3-10 한글+영어+숫자
		if (input_nickname.val() == "") {
			$("#nickname_check").text("닉네임을 입력해주세요.");
			$("#nickname_check").css('color', 'red');
			return;
		} else if (cnickname.test(input_nickname.val()) != true) {
			$("#nickname_check").text(
					"3~10자의 한글,영문 대소문자, 숫자와 특수기호(_)만 사용 가능합니다.");
			$("#nickname_check").css('color', 'red');
			return;
		} else {
			$("#nickname_check").text("");
		}
		return 1;
	}
	function emailchk() {
		var input_email = $('#email');
		var cemail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+$/; //이메일형식
		if (input_email.val() == "") {
			$("#email_check").text("이메일을 입력해주세요.");
			$("#email_check").css('color', 'red');
			return;
		}
		else if (cemail.test(input_email.val()) != true) {
			$("#email_check").text("정확한 이메일 형식을 입력해주세요.");
			$("#email_check").css('color', 'red');
			return;
		} else {
			$("#email_check").text("");
		}
		return 1;
	}
	function phonechk() {
		var input_phone = $('#phone');
		var cphone = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/; //01로 시작
		if (input_phone.val() == "") {
			$("#phone_check").text("전화번호를 입력해주세요.");
			$("#phone_check").css('color', 'red');
			return;
		} else if (cphone.test(input_phone.val()) != true) {
			$("#phone_check").text("올바른 전화번호를 입력해주세요.");
			$("#phone_check").css('color', 'red');
			return;
		} else {
			$("#phone_check").text("");
		}
		return 1;
	}
</script>
<script>
	function fn_joinFn(){
		let id = document.getElementById('id').value;
		let pw = document.getElementById('pw').value;
		let nickname = document.getElementById('nickname').value;
		let email = document.getElementById('email').value;
		let phone = document.getElementById('phone').value;
		idchk();
		pwchk();
		nicknamechk();
		emailchk();
		phonechk();
		if (idchk() == 1 && pwchk() == 1 && nicknamechk() == 1 && emailchk() == 1&& phonechk() == 1) {
			const memberInfo = JSON.stringify({
				id : id,
				pw : pw,
				nickname : nickname,
				email : email,
				phone : phone
			});
		/* const memberInfo = JSON.stringify({id:id,pw:pw,nickname:nickname,email:email,phone:phone}); */
		$.ajax({
			data : memberInfo,
			url : "${contextPath}/prj/member/newMember",
			type : "post",
			dataType : "text",
			contentType : "application/json; charset=UTF-8",
			success : function(data){
				console.log(data);
				if(data == 1){
					alert("회원가입을 축하드립니다");
					location.href="${contextPath}/prj/member/loginForm"
				}else{
					alert("에러");
				}
			},
			error : function(data){
				alert("실패");
			}
		})
	}
	}
</script>
<script>
function idCheck(){
	console.log("chk");
	let id = document.getElementById('id').value;
	idchk();
	
	if(idchk()==1) {
		const IDInfo = JSON.stringify({id:id}); 
   	$.ajax({
		url:"${contextPath}/prj/member/getIDInfo" ,
		type: "post",
		data:IDInfo,
		dataType: "json",
		contentType:"application/json",
		success: function(data){
			if (data.chkResult){
				$("#id_check").text("사용 가능한 아이디입니다.");
				$("#id_check").css('color', 'blue');;
			}
			else{
				{
					$("#id_check").text("이미 존재하는 아이디입니다.");
					$("#id_check").css('color', 'red');;
				}}
		},
		error: function(errorThrown){
			alert(errorThrown.statusText);
		}
	})
	}
}
function repwCheck(){
	let pw = document.getElementById('pw').value;
	let repw = document.getElementById('repw').value;
/* 	alert(pw+repw); */
	if(pw!=repw){
/* 		 $('#noticepw').addClass('wrongpw');
		 $('#noticepw').addClass('form-control'); */
		 $('#pw_check').text("비밀번호가 일치하지 않습니다.");
		 $("#pw_check").css('color', 'red');
	}
	else{ 
/* 		$('#noticepw').removeClass('form-control');
		$('#noticepw').removeClass('wrongpw'); */
		$('#pw_check').empty();
	}
}
</script>
<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>
	<div class="container">
		<div class="jumbotron">
			<span style="text-align: center;"><h3>회원가입</h3></span>
			<form action="${contextPath}/prj/member/newMember" method="post" >
				<p>
					<div class="input-group">
					<span class="input-group-addon" ></span> 
					<input id="id" name="id" type="text"  class="form-control"  placeholder="아이디">
					<input id="idbtn" name="idbtn" type="button" style="text-align:left"  class="form-control" value="아이디확인" onClick="idCheck()">
					<div class="check_font" id="id_check"></div>
					</div>
				</p>
				<p>
					<div class="input-group">
					<span class="input-group-addon"></span> 
					<input id="pw" name="pw" type="password" class="form-control" placeholder="패스워드">
					<input id="repw" name="repw" type="password" class="form-control" placeholder="패스워드 재확인" onblur="repwCheck();">
					<!-- <p id = "noticepw" ></p> -->
					<div class="check_font" id="pw_check"></div>
					</div>
				</p>
				<p>
					<div class="input-group">
					<span class="input-group-addon"></span> 
					<input id="nickname" name="nickname" type="text" class="form-control" placeholder="닉네임">
					<div class="check_font" id="nickname_check"></div>
					</div>
				</p>
				<p>
					<div class="input-group">
					<span class="input-group-addon"></span> 
					<input id="email" name="email" type="email" class="form-control" placeholder="이메일">
					<div class="check_font" id="email_check"></div>
					</div>
				</p>
				<p>
					<div class="input-group">
					<span class="input-group-addon"></span> 
					<input id="phone" name="phone" type="text" class="form-control" placeholder="전화번호">
					<div class="check_font" id="phone_check"></div>
					</div>
				</p>
				<input type="button" class="btn btn-default" onClick="fn_joinFn()" value="가입하기" />
			</form>
		</div>
	</div>
	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>

</body>
</html>