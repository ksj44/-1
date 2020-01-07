package com.test.persistence;

import java.util.List;

import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.test.domain.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO{
	
	//마이바티스
	@Inject
	private SqlSession sql;
	
	//매퍼
	private static String Namespace="com.test.mappers.replyMapper";

	//댓글 조회
	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		
		return sql.selectList(Namespace + ".readReply",bno);
	}

	//댓글 작성
	@Override
	public void writeReply(ReplyVO vo) throws Exception {
		sql.insert(Namespace +".writeReply", vo);
		
	}

	//특정 댓글 조회
	@Override
	public ReplyVO readReplySelect(int rno) throws Exception {
		return sql.selectOne(Namespace + ".readReplySelect", rno);
	}

	//댓글 수정
	@Override
	public void updateReply(ReplyVO vo) throws Exception {
		sql.update(Namespace +".updateReply", vo);
		
	}

	//댓글 삭제
	@Override
	public void deleteReply(ReplyVO vo) throws Exception {
		sql.delete(Namespace + ".deleteReply", vo);
	}

}
