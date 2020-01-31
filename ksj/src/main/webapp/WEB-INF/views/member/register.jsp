<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<!-- 제이쿼리 -->
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<head>
<title>sujin 게시판</title>


</head>
<body>
	<div class="container">
		<p class="well">Please enter the contents below</p>
		<h3>Registration</h3>
		<hr>
		<form class="form-horizontal" role="form" method="post"
			autocomplete="off">
			<div class="row">
				<div class="col-lg-6">

					<div class="form-group">
						<label>아이디</label>
						<div class="input-group">
							<span class="input-group-addon"><span
								class="glyphicon glyphicon-user"></span></span> <input type="text"
								class="form-control" name="userId" id="userId">
						</div>
						<button type="button" class="idCheck">아이디 확인</button>
						<p class="result">
							<span class="msg">아이디를 확인해주세요.</span>
						</p>
					</div>
					<div class="form-group">
						<label>비밀번호</label>
						<div class="input-group">
							<span class="input-group-addon"> <span
								class="glyphicon glyphicon-lock"></span></span> <input type="password"
								class="form-control" name="userPass" id="userPass">
						</div>
					</div>
					<div class="form-group">
						<label>닉네임</label>
						<div class="input-group">
							<span class="input-group-addon"><span
								class="glyphicon glyphicon-envelope"></span></span> <input type="text"
								class="form-control" name="userName" id="userName">
						</div>
					</div>

					<div class=text-center>
						<button type="submit" id="submit" disabled="disabled" class="btn btn-outline-dark">가입</button>
					</div>

					<p>
						<a href="/board/listSearch">처음으로</a>

					</p>
				</div>
			</div>
		</form>
	</div>







	<script>
		$(".idCheck").click(function() {

			var query = {
				userId : $("#userId").val()
			};

			$.ajax({
				url : "/member/idCheck",
				type : "post",
				data : query,
				success : function(data) {

					if (data == 1) {
						$(".result .msg").text("사용 불가");
						$(".result .msg").attr("style", "color:#f00");
						$("#submit").attr("disabled", "disabled");
					} else {
						$(".result .msg").text("사용 가능");
						$(".result .msg").attr("style", "color:#00f");
						$("#submit").removeAttr("disabled");
					}
				}
			}); // ajax 끝
		});

		$("#userId").keyup(function() {
			$(".result .msg").test("아이디를 확인해주세요.");
			$(".result .msg").attr("style", "color:#000");

			$("#submit").attr("disabled", "disabled");
		});
	</script>
</body>
</html>
