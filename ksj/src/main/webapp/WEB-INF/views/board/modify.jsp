<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>게시판</title>

<!-- 제이쿼리 -->
<script src='http://code.jquery.com/jquery-3.3.1.min.js'></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

</head>
<body>

		<header>
			<%@include file="include/header.jsp"%>
		</header>
		<nav>
			<%@include file="include/nav.jsp"%>
		</nav>

		<section id="container">

			<form role="form" method="post" autocomplete="off">

				<div class="form-group row">
					<label for="bno" class="col-sm-2 col-form-label">글 번호</label>
					<div class="col-sm-10">
						<input type="text" id="bno" name="bno" class="form-control"
							value="${modify.bno}" readonly="readonly" />
					</div>
				</div>

			

			<div class="form-group row">
				<label for="title" class="col-sm-2 col-form-label">글 제목</label>
				<div class="col-sm-10">
					<input type="text" id="title" class="form-control" name="title"
						value="${modify.title}"  />
				</div>
			</div>


			<div class="form-group row">
				<label for="content" class="col-sm-2 col-form-label">글 내용</label>
				<div class="col-sm-10">
					<textarea id="content" class="form-control" name="content" rows="4"
						>${modify.content}</textarea>
				</div>
			</div>


			<div class="form-group row">
				<label for="writer" class="col-sm-2 col-form-label">작성자</label>
				<div class="col-sm-10">
					<input type="text" id="writer" class="form-control" name="writer"
						value="${modify.writer}" readonly="readonly" /><br>
				</div>
			</div>


			<div class="form-group row">
				<label class="col-sm-2 col-form-label">작성 날짜</label>
				<div class="col-sm-10">
					<span><fmt:formatDate value="${modify.regdate}"
							pattern="yyyy-MM-dd" /></span>
				</div>
			</div>
				<div class=text-center>
				<button type="submit" class="btn btn-outline-dark">수정</button>
				<button id="cancel_btn" class="btn btn-outline-dark">취소</button>
				</div>
				
				<script>
				
				//폼을 변수에 저장
				var formObj = $("form[role='form']");
				
				//취소 버튼 클릭
				$("#cancel_btn").click(function() {
					self.location="/board/read?bno=${modify.bno}"
							+"&page=${scri.page}"
							+"&perPageNum=${scri.perPageNum}"
							+"&searchType=${scri.searchType}"
							+"&keyword=${scri.keyword}";
				});
				
				</script>
				
				</p>
			</form>

		</section>

		<footer>
			<%@include file="include/footer.jsp"%>
		</footer>


</body>
</html>
