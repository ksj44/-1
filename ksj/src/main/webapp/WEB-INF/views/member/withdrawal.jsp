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
		<div class="form-group">
						<label for="userId">아이디</label>
						<div class="input-group">
							<span class="input-group-addon"> <span
								class="glyphicon glyphicon-lock"></span></span> <input type="text"
								class="form-control" name="userId" id="userId" value="${member.userId}">
						</div>
					</div>
		<div class="form-group">
						<label for="userPass">비밀번호</label>
						<div class="input-group">
							<span class="input-group-addon"> <span
								class="glyphicon glyphicon-lock"></span></span> <input type="password"
								class="form-control" name="userPass" id="userPass">
						</div>
					</div>
		<div class=text-center>
			<button type="submit"  class="btn btn-outline-dark">회원 탈퇴</button>
		</div>
		
</div>
</div>
</div>
	</form>
	</div>
	<c:if test="${msg == false}">
	<p>입력하신 비밀번호가 잘 못 되었습니다.</p>
	</c:if>
</body>
</html>