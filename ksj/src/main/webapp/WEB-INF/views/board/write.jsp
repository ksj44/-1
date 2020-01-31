<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<!-- 제이쿼리 -->
<script src='http://code.jquery.com/jquery-3.3.1.min.js'></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>sujin 게시판</title>
</head>
<body>
 <div class="container">

		<header>
			<%@include file="include/header.jsp"%>
		</header>
		<nav>
			<%@include file="include/nav.jsp"%>
		</nav>
	
	
		<section>
		<c:if test="${msg == null}">

			<form role="form" method="post" autocomplete="off">
				
				<div class="form-group row">
					<label for="title" class="col-sm-2 col-form-label">글 제목</label>
					<div class="col-sm-10">
					<input type="text" id="title" name="title"  class="form-control"/>
				</div>
				</div>
				
				
				<div class="form-group row">
					<label for="content" class="col-sm-2 col-form-label">글 내용</label>
					<div class="col-sm-10">
					<textarea id="content" name="content" rows="4" class="form-control"></textarea>
				</div>
				</div>
				
				
				<div class="form-group row">
					<label for="writer" class="col-sm-2 col-form-label">작성자</label>
					<div class="col-sm-10">
					<input type="text" id="writer" name="writer" value="${member.userName}" readonly="readonly"  class="form-control"/>
				</div>
				</div>
	
				
				<div class=text-center>
					<button type="submit" class="btn btn-outline-dark">완료</button>
				</div>
			</form>
			</c:if>
			<c:if test="${msg == false}">
          <script>
          alert("로그인을 해야 글을 작성할 수 있습니다.");
          location.href='/member/login';</script>
			</c:if>

		</section>

		<hr />

		<footer>
			<p>만든이 : ksj</p>
		</footer>

</div>
</body>
</html>

