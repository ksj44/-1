package com.test.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import com.test.domain.ReplyVO;
import com.test.persistence.ReplyDAO;

@Repository
public class ReplyServiceImpl implements ReplyService{
	
	@Inject
	private ReplyDAO dao;

	//댓글조회
	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		return dao.readReply(bno);
	}

	//댓글작성
	@Override
	public void writeReply(ReplyVO vo) throws Exception {
		dao.writeReply(vo);
		
	}
	
	//특정 댓글 조회
	@Override
	public ReplyVO readReplySelect(int rno) throws Exception {
		return dao.readReplySelect(rno);
	}
	
	//댓글 수정
	@Override
	public void updateReply(ReplyVO vo) throws Exception {
		dao.updateReply(vo);
		
	}

	//댓글 삭제
	@Override
	public void deleteReply(ReplyVO vo) throws Exception {
		dao.deleteReply(vo);
		
	}

	

}
