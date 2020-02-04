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
	
<!-- 주소  -->	
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
						<input type="text" class="form-control" name="userId" id="userId">
						</div>
						<button type="button" class="idCheck">아이디 확인</button>
						<p class="result">
							<span class="msg">아이디를 확인해주세요.</span>
						</p>
					</div>
					<div class="form-group">
						<label>비밀번호</label>
						<div class="input-group">
						<input type="password" class="form-control" name="userPass" id="userPass">
						</div>
					</div>
					<div class="form-group">
						<label>닉네임</label>
						<div class="input-group">
						<input type="text" class="form-control" name="userName" id="userName">
						</div>
					</div>
					
					<div class="form-group">
						<label>주소</label>
						<div class="form-group">
								<input type="text" class="form-control" name="userAddr1" id="userAddr1" placeholder="우편번호">
								<input type="button" class="form-control" onclick="execPostCode()" value="우편번호 찾기">
								</div>
						<div class="form-group">
								<input type="text" class="form-control"  name="userAddr2"id="userAddr2" placeholder="주소">
								</div>
						<div class="form-group">
								<input type="text" class="form-control"  name="userAddr3"id="userAddr3" placeholder="상세주소">
									
					    </div>
					    
					</div>
					<script>
					function execPostCode() {
				         new daum.Postcode({
				             oncomplete: function(data) {
				                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				 
				                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
				                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
				                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
				 
				                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
				                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
				                    extraRoadAddr += data.bname;
				                }
				                // 건물명이 있고, 공동주택일 경우 추가한다.
				                if(data.buildingName !== '' && data.apartment === 'Y'){
				                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				                }
				                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				                if(extraRoadAddr !== ''){
				                    extraRoadAddr = ' (' + extraRoadAddr + ')';
				                }
				                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
				                if(fullRoadAddr !== ''){
				                    fullRoadAddr += extraRoadAddr;
				                }
				 
				                // 우편번호와 주소 정보를 해당 필드에 넣는다.
				                console.log(data.zonecode);
				                console.log(fullRoadAddr);
				                
				                
				                $("[name=userAddr1]").val(data.zonecode);
				                $("[name=userAddr2]").val(fullRoadAddr);
				                $("[name=userAddr3]").focus();
				                
				                /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
				                document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
				                document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
				            }
				         }).open();
				     }

					</script>
					
					
				

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
