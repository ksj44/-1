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

<style>
section.repList {padding: 30px 0;}
section.repList ol {padding: 0; margin: 0;}
section.repList ol li {padding: 10px 0; border-bottom: 2px solid #eee;}
section.repList div.userInfo {}
section.repList div.userInfo .Writer {font-size: 24px;font-weight: bold;}
section.repList div.userInfo .date {color: #999; display: inline-block; margin-left: 10px;}
section.repList div.Content { padding: 10px; margin: 20px 0;}
section.repList div.replyFooter button { font-size:14px; border: 1px solid #999; background:none; margin-right:10px; }
</style> 

<style>
 div.replyModal { position:relative; z-index:1; display:none; }
 div.modalBackground { position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0, 0, 0, 0.8); z-index:-1; }
 div.modalContent { position:fixed; top:20%; left:calc(50% - 250px); width:500px; height:250px; padding:20px 10px; background:#fff; border:2px solid #666; }
 div.modalContent textarea { font-size:16px; font-family:'맑은 고딕', verdana; padding:10px; width:450px; height:150px; }
 div.modalContent button { font-size:20px; padding:5px 8px; margin:10px 0; background:#fff; border:1px solid #ccc; }
 div.modalContent button.modal_cancel { margin-left:10px; }
</style>
<script> 
			function replyList(){
				
				var bno = ${read.bno};
				
				//비동기식 데이터 요청
				$.getJSON("/board/read/replyList" + "?bno=" + bno, function(data){
					var str = "";
					
					$(data).each(function(){
						console.log(data);
						
						//날짜 데이터를 보기 쉽게 변환
						var regDate = new Date(this.regDate);
						regDate = regDate.toLocaleDateString("ko-US")
						
						//Html코드 조립
						str += "<li data-bno='" + this.bno + "'>"
						+ "<div class='userInfo'>"
                        + "<span class='Writer'>" + this.writer + "</span>"
                        + "<span class='date'>" + regDate + "</span>"
                        + "</div>"
                        + "<div class='Content'>" + this.content + "</div>"
                        + "<div class='replyFooter'>"
                        + "<button type='button' class='modify' data-rno='" + this.rno + "'>M</button>"
                        + "<button type='button' class='delete' data-rno='" + this.rno + "'>D</button>"
                        + "</div>"
                        + "</li>";           
                        });
					
					//조립한  html코드를 추가 
					$("section.repList ol").html(str);
					});
				}
</script>
	

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
						<input type="text" id="bno" name="bno" class="form-control"
							value="${read.bno}" readonly="readonly" />
					</div>
				</div>

			</form>

			<div class="form-group row">
				<label for="title" class="col-sm-2 col-form-label">글 제목</label>
				<div class="col-sm-10">
					<input type="text" id="title" class="form-control" name="title"
						value="${read.title}" readonly="readonly" />
				</div>
			</div>


			<div class="form-group row">
				<label for="content" class="col-sm-2 col-form-label">글 내용</label>
				<div class="col-sm-10">
					<textarea id="content2" class="form-control" name="content2" rows="4"
						readonly="readonly">${read.content}</textarea>
				</div>
			</div>


			<div class="form-group row">
				<label for="writer" class="col-sm-2 col-form-label">작성자</label>
				<div class="col-sm-10">
					<input type="text" id="writer" class="form-control" name="writer"
						value="${read.writer}" readonly="readonly" /><br>
				</div>
			</div>


			<div class="form-group row">
				<label class="col-sm-2 col-form-label">작성 날짜</label>
				<div class="col-sm-10">
					<span><fmt:formatDate value="${read.regdate}"
							pattern="yyyy-MM-dd" /></span>
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
						if(${member.userName == read.writer}){				
						formObj.attr("action", "/board/modify");
						formObj.attr("method", "get");
						formObj.submit();
						}else {
						alert("작성자가 아닙니다.");
						}
					});

					//삭제 버튼 클릭
					$("#delete_btn").click(function() {
						alert ("삭제 하시겠습니까?");
						if(${member.userName == read.writer}){	
						formObj.attr("action", "/board/delete");
						formObj.submit();
						}else {
							alert("작성자가 아닙니다.");
							}
					});
				</script>

			</div>

		</section>

		<hr />






		<section class="repList">
			<ol>
				<!--  
			<c:forEach items="${repList}" var="repList">
				<li>
					<div class="userInfo">
						<span class="Writer">${repList.writer}</span> 
						<span class="date"><fmt:formatDate value="${repList.regDate}" pattern="yyyy-MM-dd" /></span>
					</div>

					<span class="Content">${repList.content}</span>
                  		</li>
			</c:forEach>
	 -->




			</ol>
			
			<script>
			replyList();
			</script>
			
			
			<script>
			$(document).on("click", ".modify", function(){
				$(".replyModal").fadeIn(200);
				
				var rno = $(this).attr("data-rno");
				var content = $(this).parent().parent().children(".Content").text();
				
				$(".modal_repCon").val(content);
				$(".modal_modify_btn").attr("data-rno", rno);
				});
			</script>	
			</section>


		
		<c:if test="${member == null }">
		 <p>소감을 남기시려면 <a href="/member/login">로그인</a>해주세요</p>
		 </c:if>
		 
		 <c:if test="${member != null }">
		 <section class="repForm">
		 
		 <form role="form" method="post" autocomplete="off">
		  <div class="form-group">
		  <label for="writer" class="col-sm-2 control-label">작성자</label>
		  <div class="col-sm-10">
		  <input type="text" id="writer" name="writer" value="${member.userName}" class="form-control" readonly="readonly"  />
		   </div>
		  </div>
				<div class="input_area">
				<label for="writer" class="col-sm-2 control-label">댓글</label>
				<div class="col-sm-10">
					<textarea  name="content" id="content" class="form-control" rows="4" placeholder="댓글을 작성해 주세요 :)"></textarea>
				</div>
				</div>
				<div class=text-center>
					<button type="button" id="reply_btn" class="btn btn-outline-dark">작성</button>
					
					
					<script>
					
					$("#reply_btn").click(function(){
						
						var formObj = $(".repForm form[role='form']");
						var bno = "${read.bno}";
						var writer =  $("#writer").val();
                        var content = $("textarea#content").val();
  
                        var data = {bno : bno, content : content, writer : writer};
                        
                        $.ajax({
                        	url : "/board/read/registReply",
                        	type : "post",
                        	data :data,
                        	success : function(){
                        		alert("댓글이 등록되었습니다.");
                        		replyList();
                        		$("#content").val(""); //textarea 초기화
                        		}
                        });
                        });
					</script>
					</div>
					</form>
					</section>
					</c:if>
					
					
					<footer>
					<%@include file="include/footer.jsp"%>
					</footer>
					
					
					</div>
					<div class="replyModal">
					<div class="modalContent">
  
                   <div>
                   <textarea class="modal_repCon" name="modal_repCon"></textarea>
                   </div>
  
                   <div>
                   <button type="button" class="modal_modify_btn">수정</button>
                   <button type="button" class="modal_cancel">취소</button>
                   </div>
  
                   </div>

                  <div class="modalBackground"></div>
 
                  </div>
                  
                  <script>
                  
                  $(".modal_modify_btn").click(function(){
                	  var modifyConfirm = confirm("정말로 수정하시겠습니까?");
                	  
                	  if(modifyConfirm) {
                		  var data = {
                				  rno : $(this).attr("data-rno"),
                				  content : $(".modal_repCon").val()
                				  };  // ReplyVO 형태로 데이터 생성
                				  
                				  $.ajax({
                					  url : "/board/read/updateReply",
                					  type : "post",
                					  data : data,
                					  success : function(result){
                						  if(result == 1) {
                							  replyList();
                							  $(".replyModal").fadeOut(200);
                							  } else {
                								  alert("작성자 본인만 할 수 있습니다.");							
                								  }
                						  },
                						  error : function(){
                							  alert("로그인하셔야합니다.")
                							  }
                						  });
                				  }
                	  });
                  $(".modal_cancel").click(function(){
                	  
                	  //$(".replyModal").attr("style", "display:none;");
                	  $(".replyModal").fadeOut(200);
                	  });
                  </script>
                  
                  <script>
                  
                  //스크립트로 인해 생성된 HTML의 이벤트는 .click()메서드를 사용 할 수 없음
                  $(document).on("click", ".delete", function(){
                	  
                	  var deleteConfirm = confirm("정말로 삭제하시겠습니까?");
                	  
                	  if(deleteConFirm) {
                		  var data = {rno : $(this).attr("data-rno")};
                		  
                		  $.ajax({
                			  url : "/board/read/deleteReply",
                			  type : "post",
                			  data : data,
                			  success : function(result){
                				  
                				  if(result == 1){
                					  alert("댓글 삭제 완료");
                					  replyList();
                					  }else {
                						  alert("작성자 본인만 할 수 있습니다.");
                						  }
                				  }
                		  });
                		  }
                	  });
                  </script>

</body>
</html>

