<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
  <!-- 합쳐지고 최소화된 최신 CSS -->


<!DOCTYPE html>
<html>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<c:if test="${member == null}">
		<div class="container">
	<div class="row text-center mb-4">
		<div class="col-md-12">
		    <h4>Prestashop</h4>
		    <small>1.6.1.19</small>
		</div>
	</div>
	<div class="row text-center">
	    <div class="col-md-6 offset-md-3">
	        <div class="card">
	            <div class="card-body">
	                <div class="login-title">
	                    <h4>LogIn</h4>
	                </div>
	                <div class="login-form mt-4">
	                    <form  role="form" method="post" autocomplete="off"
			action="/member/login">
                        <div class="form-row">
                            <div class="form-group col-md-12">
                              <input id="userId" name="userId" placeholder="Id" class="form-control" type="text">
                            </div>
                            <div class="form-group col-md-12">
                              <input type="password" class="form-control" id="userPass" name="userPass" placeholder="Password">
                            </div>
                          </div>
                         
                        
                        <div class="form-row">
                            <button type="submit" class="btn btn-danger btn-block">로그인</button>
                        </div>
                    </form>
	                </div>
	                
	            </div>
	        </div>
	    </div>
	</div>
</div>
	</c:if>
 
 <c:if test="${msg == false}">
  <p style="color:#f00;">아이디 또는 비밀번호를 다시 입력해주세요.</p>
  </c:if>

	<c:if test="${member != null}">
		  <script>alert("${member.userName}님 환영합니다.");
          location.href='listSearch';
          </script>
	</c:if>

</body>
</html>