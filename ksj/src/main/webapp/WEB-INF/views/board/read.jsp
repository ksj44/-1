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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
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

			<form role="form" method="post" autocomplete="off">

				<input type="hidden" id="page" value="${scri.page}"
					readonly="readonly" /> <input type="hidden" id="perPageNum"
					value="${scri.perPageNum}" readonly="readonly" /> <input
					type="hidden" id="searchType" value="${scri.searchType}"
					readonly="readonly" /> <input type="hidden" id="keyword"
					value="${scri.keyword}" readonly="readonly" />


			
				<div class="form-group row">
					<label for="bno" class="col-sm-2 col-form-label">글 번호</label>
					<div class="col-sm-10">
					<input type="text" id="bno" name="bno"
						class="form-control" value="${read.bno}" readonly="readonly" />
				</div>
			</div>

			</form>

			<div class="form-group row">
				<label for="title" class="col-sm-2 col-form-label">글 제목</label>
				<div class="col-sm-10">
				<input type="text" id="title" class="form-control"
					name="title" value="${read.title}" readonly="readonly" />
			  </div>
			</div>
			
			
			<div class="form-group row">
				<label for="content" class="col-sm-2 col-form-label">글 내용</label>
				<div class="col-sm-10">
				<textarea id="content" class="form-control" name="content" rows="4" readonly="readonly">${read.content}</textarea>
			  </div>
			</div>
			
			
			<div class="form-group row">
				<label for="writer" class="col-sm-2 col-form-label">작성자</label>
				  <div class="col-sm-10">
				<input type="text" id="writer" class="form-control"
					name="writer" value="${read.writer}" readonly="readonly" /><br>		
			</div>
		      </div>
		      
		      
		    <div class="form-group row">
				<label class="col-sm-2 col-form-label">작성 날짜</label> 
				 <div class="col-sm-10">
				 <span><fmt:formatDate
						value="${read.regdate}" pattern="yyyy-MM-dd" /></span>
				</div>
			</div>
		
			<div class=text-center>
				<button type="button" id="list_btn" class="btn btn-outline-dark">목록</button>
				<button type="button" id="modify_btn" class="btn btn-outline-dark">수정</button>
				<button type="button" id="delete_btn" class="btn btn-outline-dark">삭제</button>

				<script>
					//폼을 변수에 저장
					var formObj = $("form[role='form']");

					//목록 버튼 클릭

					$("#list_btn").click(function() {
						formObj.attr("action", "/board/listSearch");
						formObj.attr("method", "get");
						formObj.submit();
					});

					//수정 버튼 클릭
					$("#modify_btn").click(function() {
						formObj.attr("action", "/board/modify");
						formObj.attr("method", "get");
						formObj.submit();
					});

					//삭제 버튼 클릭
					$("#delete_btn").click(function() {
						formObj.attr("action", "/board/delete");
						formObj.attr("method", "get");
						formObj.submit();
					});
				</script>

			</div>

		</section>

		<hr />



		<ol>
			<c:forEach items="${repList}" var="repList">
				<li>
					<p>
						${repList.writer}
						(<fmt:formatDate value="${repList.regDate}" pattern="yyyy-MM-dd" />)
					</p>

					<p>${repList.content}</p>

					
					<div class="form-group">
						<button type="button" class="updateReply btn btn-outline-dark btn-xs"
							data-rno="${repList.rno}">수정</button>
						<button type="button" class="deleteReply btn btn-outline-dark btn-xs"
							data-rno="${repList.rno}">삭제</button>
							</div>

						<script>
							$(".updateReply").click(function() {
								self.location = "/board/updateReply?bno=${read.bno}"
														+ "&page=${scri.page}"
														+ "&perPageNum=${scri.perPageNum}"
														+ "&searchType=${scri.searchType}"
														+ "&keyword=${scri.keyword}"
														+ "&rno="
														+ $(this).attr("data-rno");
											});

							$(".deleteReply").click(function() {
									self.location = "/board/deleteReply?bno=${read.bno}"
														+ "&page=${scri.page}"
														+ "&perPageNum=${scri.perPageNum}"
														+ "&searchType=${scri.searchType}"
														+ "&keyword=${scri.keyword}"
														+ "&rno="
														+ $(this).attr("data-rno");
											});
						</script>

				</li>
			</c:forEach>

		</ol>
		<section class="replyForm">
			<form role="form" method="post" autocomplete="off" class="form-horizontal">

				<input type="hidden" id="bno" name="bno" value="${read.bno}"
					readonly="readonly" /> <input type="hidden" id="page" name="page"
					value="${scri.page}" readonly="readonly" /> <input type="hidden"
					id="perPageNum" name="perPageNum" value="${scri.perPageNum}"
					readonly="readonly" /> <input type="hidden" id="searchType"
					name="searchType" value="${scri.searchType}" readonly="readonly" />
				<input type="hidden" id="keyword" name="keyword"
					value="${scri.keyword}" readonly="readonly" />

				<div class="form-group">
					<label for="writer" class="col-sm-2 control-label">작성자</label>
				  <div class="col-sm-10">
					<input type="text" id="writer" name="writer" class="form-control" />
				</div>
				</div>
				<div class="form-group">
				<label for="content" class="col-sm-2 control-label">내용</label>
				  <div class="col-sm-10">
					<textarea id="content" name="content" class="form-control" placeholder="댓글을 작성해 주세요 :)"></textarea>
				  </div>
				</div>
				<p>
					<button type="button" class="repSubmit">작성</button>
					<script>
						var formObj = $(".replyForm form[role='form']");

						$(".repSubmit").click(function() {
							formObj.attr("action", "replyWrite");
							formObj.submit();
						});
					</script>
				</p>
			</form>
		</section>
		
		<footer>
			<%@include file="include/footer.jsp"%>
		</footer>

	</div>

</body>
</html>

