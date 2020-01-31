<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="collapse navbar-collapse">
	<ul class="nav navbar-nav">

		<li><a href="/board/listSearch">목록</a></li>
		<li><a href="/board/write">글 작성</a></li>	
		<c:if test="${member == null}">
		   <li><a href="/member/register">회원가입</a></li>
			<li><a href="/member/login">로그인</a></li>
		</c:if>
		<c:if test="${member != null}">
			<li><a href="/member/modify">회원정보 수정</a></li>
			<li><a href="/member/withdrawal">회원 탈퇴</a></li>
			<li><a href="/member/logout">로그아웃</a><li>
		</c:if>

	</ul>
</div>

