package com.test.persistence;

import com.test.domain.MemberVO;

public interface MemberDAO {
	
	//회원가입
	public void register(MemberVO vo) throws Exception;
	
	//로그인
	public MemberVO login(MemberVO vo) throws Exception;
	
	//회원정보 수정
	public void modify(MemberVO vo)throws Exception;
	
	//회원탈퇴
	public void withdrawal(MemberVO vo)throws Exception;
	
	//아이디확인
	public MemberVO idCheck(String userId)throws Exception;

}
