package com.test.ksj;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.test.domain.BoardVO;
import com.test.domain.Criteria;
import com.test.domain.MemberVO;
import com.test.domain.PageMaker;
import com.test.domain.ReplyVO;
import com.test.domain.SearchCriteria;
import com.test.service.BoardService;
import com.test.service.ReplyService;


@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Inject
	BoardService service;
	@Inject
	ReplyService RepService;

	

	
	//글작성 get
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public void getWrite(HttpSession session, Model model) throws Exception{
		logger.info("get write");
		
		Object loginInfo =session.getAttribute("member");
		
		if(loginInfo == null) {
			model.addAttribute("msg",false);
		}
	}
	
	//글작성 post
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String postWrite(BoardVO vo) throws Exception{
		logger.info("post write");
		
		service.write(vo);
		
		return "redirect:/board/listSearch";
	}
	
	//글 목록
	@RequestMapping(value="/list", method=RequestMethod.GET)
		public void list(Model model) throws Exception{
			logger.info("get list");
			
			List<BoardVO> list=service.list();
			
			model.addAttribute("list",list);
		}
	
	//글 조회
	@RequestMapping(value="/read", method=RequestMethod.GET)
	public void getRead(@RequestParam("bno") int bno,
			@ModelAttribute("scri") SearchCriteria scri,Model model) throws Exception{
		logger.info("get read");
		
		BoardVO vo=service.read(bno);
		
		model.addAttribute("read", vo);	
		
	/*	
	 List<ReplyVO> repList = RepService.readReply(bno);
		model.addAttribute("repList", repList); */

	}
	
	//글 수정
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public void getModify(@RequestParam("bno") int bno,
			@ModelAttribute("scri") SearchCriteria scri,Model model)throws Exception{
		logger.info("get modify");
		
		BoardVO vo =service.read(bno);
		
		model.addAttribute("modify", vo);
		model.addAttribute("scri",scri);
	}

	//글 수정 post
	@RequestMapping(value="/modify",method=RequestMethod.POST)
	public String postModify(BoardVO vo,@ModelAttribute("scri") SearchCriteria scri,
			RedirectAttributes rttr) throws Exception{
		logger.info("post modify");
		
		service.update(vo);
		
		rttr.addAttribute("page" ,scri.getPage());
		rttr.addAttribute("perPageNum",scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/board/listSearch";
	}
	
	
	//글 삭제 post
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public String postDelete(@RequestParam("bno") int bno,
			@ModelAttribute("scri") SearchCriteria scri,
			RedirectAttributes rttr) throws Exception{
		logger.info("post delete");
		
		service.delete(bno);
		
		rttr.addAttribute("page" ,scri.getPage());
		rttr.addAttribute("perPageNum",scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/board/listSearch";
	}
	
	//글 목록 + 페이징
	@RequestMapping(value="/listPage", method=RequestMethod.GET)
	public void listPage(@ModelAttribute("cri") Criteria cri, Model model)throws Exception{
		logger.info("get list page");
		
		List<BoardVO> list = service.listPage(cri);
		model.addAttribute("list", list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCount());
		model.addAttribute("pageMaker",pageMaker);
		
		
	}
	
	//글 목록 +페이징 +검색
	@RequestMapping(value="/listSearch", method=RequestMethod.GET)
	public void listSearch(@ModelAttribute("scri") SearchCriteria scri, Model model)throws Exception{
		logger.info("get list search");

		List<BoardVO> list = service.listSearch(scri);
		model.addAttribute("list", list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.countSearch(scri));
		model.addAttribute("pageMaker",pageMaker);
		
		
	
	}	
	
	
	// 댓글 목록
	@ResponseBody
	@RequestMapping(value = "/read/replyList", method = RequestMethod.GET)
	public List<ReplyVO> replyList(@RequestParam("bno") int bno) throws Exception {
	 logger.info("get readReply");
	   
	 List<ReplyVO> replyList = RepService.replyList(bno);
	 
	 
	 return replyList ;
	} 


	
	//댓글작성
	@ResponseBody
	@RequestMapping(value="/read/registReply", method=RequestMethod.POST)
	public void registReply(ReplyVO reply, HttpSession session)throws Exception{
		logger.info("reply registReply");
		
		
		MemberVO member = (MemberVO)session.getAttribute("member");
	
		reply.setUserId(member.getUserId());
		reply.setWriter(member.getUserName());
 
		
	
		RepService.registReply(reply);
	}
	
	//댓글 수정
	@ResponseBody
	@RequestMapping(value="/read/updateReply", method=RequestMethod.POST)
	public int updateReply(ReplyVO reply, HttpSession session)throws Exception{
		logger.info("update reply");
		
		int result = 0;
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = RepService.idCheck(reply.getRno());
		
		if(member.getUserId().equals(userId)) {
			
			reply.setUserId(member.getUserId());
			RepService.updateReply(reply);
			result = 1;
		}

		return result;
	}
	
	//댓글 삭제
	@ResponseBody
	@RequestMapping(value="/read/deleteReply", method=RequestMethod.POST)
	public int deleteReply(ReplyVO reply, HttpSession session)throws Exception{
		logger.info("delete reply");
		
		int result = 0;
		
		MemberVO member = (MemberVO)session.getAttribute("member");
		String userId = RepService.idCheck(reply.getRno());
		
		if(member.getUserId().equals(userId)) {
			reply.setUserId(member.getUserId());
			RepService.deleteReply(reply);
			
			result = 1;
		}
		
				
		return result;
	}
	
	
	//댓글 삭제 GET
		@RequestMapping(value="/deleteReply", method=RequestMethod.GET)
		public void getdeleteReply(@RequestParam("rno") int rno, @ModelAttribute("scri") SearchCriteria scri, Model model)throws Exception{
			logger.info("delete Reply");
			
			ReplyVO vo = null;
			
			vo =RepService.readReplySelect(rno);
			
			model.addAttribute("readReply", vo);
			model.addAttribute("scri", scri);
		}
	
	
	
	
	
	
	
}
