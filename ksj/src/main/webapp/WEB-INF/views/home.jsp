<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
</head>
<body>


	<a href="/board/write">글 작성</a>
	<a href="/board/list">글 목록</a>
	<a href="/board/listPage">글 목록+페이지</a>
	<a href="/board/listSearch">글 목록+페이지+검색</a>
	<h1>Hello world!</h1>

	<P>The time on the server is ${serverTime}.</P>

	<form role="form" method="post" autocomplete="off">
		<p>
			<label for="userId">아이디</label> <input type="text" id="userId"
				name="userId" />
		</p>
		<p>
			<label for="userPass">아이디</label> <input type="password"
				id="userPass" name="userPass" />
		</p>
		<p>
			<button type="submit">로그인</button>
		</p>
		<p>
			<a href="/member/register">회원가입</a>
		</p>
	</form>

</body>
</html>
