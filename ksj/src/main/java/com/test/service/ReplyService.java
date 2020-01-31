package com.test.service;

import java.util.List;

import com.test.domain.ReplyVO;

public interface ReplyService {
	
	//댓글조회
	public List<ReplyVO> replyList(int bno) throws Exception;
	
	//댓글작성
	public void registReply(ReplyVO vo) throws Exception;
	
	//특정 댓글 조회
	public ReplyVO readReplySelect(int rno) throws Exception;
	
	//댓글 수정
	public void updateReply(ReplyVO vo) throws Exception;
	
	//댓글 삭제
	public void deleteReply(ReplyVO vo) throws Exception;

	//아이디 체크
	public String idCheck(int rno) throws Exception;
	
}
