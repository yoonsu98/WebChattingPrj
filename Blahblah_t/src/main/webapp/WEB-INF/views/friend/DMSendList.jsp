<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>친구정보</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/custom.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>

</head>
<body>
	<!-- uppermost -->
	<%@ include file="/resources/include/main/uppermost.jsp"%>
	<!-- nav -->
	<%@ include file="/resources/include/main/nav.jsp"%>
	<!-- main -->
	<div class="container text-center">
	<table class="table" style="text-align: center;">
		 <caption>send DM list</caption>
			<thead>
				<tr>
					<th class="text-center">no</th>
					<th class="text-center">title</th>
					<th class="text-center">date</th>
				</tr>
 				<c:forEach var="ml" items="${sendMessageList}">
					<tr>
						<th class="text-center">${ml.mid }</th>
						<th class="text-center"><a id="DMdetailBtn" onClick="showDMDetail(${ml.mid})">${ml.mtitle }</a></th>
						<th class="text-center">${ml.mdate }</th>  
					</tr>
				</c:forEach>
			</thead>
		</table>
	</div>
	<!-- The Modal -->
	<div id="DMPopup" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<div>
				<span class="close">&times;</span>
				<p>Direct Message</p>
				<br/>
				
			</div>
			<div class="card">
				<label for="Title">Title.</label> <p class=" card-text" id="Title" ></p>
				<br/>
				<label for="to">To.</label> <p class="card-text" id="To"></p>
				<br/>
				<label for="from">Content.</label>
				<p class="card-text" id="Content" ></p>
				
				<br/>
				<label for="from">Date.</label> <p class="card-text" id="Date"></p>
			</div>
		</div>

	</div>

	<!-- footer -->
	<%@ include file="/resources/include/main/footer.jsp"%>


</body>
<script>
	// Get the modal
	var modal = document.getElementById('DMPopup');
	// Get the button that opens the modal
	var btn = document.getElementById("DMdetailBtn");
	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];
	// When the user clicks on the button, open the modal 
/* 	btn.onclick = function() {
		modal.style.display = "block";
	} */
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
	function showDMDetail(mid){
		modal.style.display = "block";
		console.log(mid);
		
		const mIDInfo = JSON.stringify({mid:mid}); 
		console.log(mIDInfo);
	   	$.ajax({
			url:"${contextPath}/prj/friend/getDMDetail" ,
			type: "post",
			data:mIDInfo,
			async:false,
			dataType: "json",
			contentType:"application/json",
			success: function(data){
				$('#Title').text(data.mtitle);
				$('#To').text(data.mtoid);
				$('#From').text(data.mfromid);
				$('#Content').text(data.mcontent);
				var date = new Date(data.mdate);
				$('#Date').text(date);
			},
			error: function(errorThrown){
				alert(errorThrown.statusText);
			}
		});
		}
</script>
</html>