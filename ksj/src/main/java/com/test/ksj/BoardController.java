package com.test.ksj;

import java.util.List;

import javax.inject.Inject;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.test.domain.BoardVO;
import com.test.domain.Criteria;
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
	public void getWrite() throws Exception{
		logger.info("get write");
	}
	
	//글작성 post
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String postWrite(BoardVO vo) throws Exception{
		logger.info("post write");
		
		service.write(vo);
		
		return "redirect:/";
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
		model.addAttribute("scri", scri);
		
		List<ReplyVO> repList = RepService.readReply(bno);
		model.addAttribute("repList", repList);

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
	
	//글 삭제
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public void getDelete(@RequestParam("bno") int bno, 
			@ModelAttribute("scri") SearchCriteria scri,Model model)throws Exception{
		logger.info("get delete");
		
		model.addAttribute("delete", bno);
		model.addAttribute("scri",scri);
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
	
	//댓글작성
	@RequestMapping(value="/replyWrite", method=RequestMethod.POST)
	public String replyWrite(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr)throws Exception{
		logger.info("reply write");
		
		RepService.writeReply(vo);
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
	    rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		
		return "redirect:/board/read";
		
	}
	
	//댓글 수정
	@RequestMapping(value="/updateReply", method=RequestMethod.POST)
	public String updateReply(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr)throws Exception{
		logger.info("update reply");
		
		RepService.updateReply(vo);
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
	    rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
				
		return "redirect:/board/read";
	}
	
	//댓글 삭제
	@RequestMapping(value="/deleteReply", method=RequestMethod.POST)
	public String deleteReply(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr)throws Exception{
		logger.info("delete reply");
		
		RepService.deleteReply(vo);
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
	    rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
				
		return "redirect:/board/read";
	}
	
	//댓글 수정 GET
	@RequestMapping(value="/updateReply", method=RequestMethod.GET)
	public void getupdateReply(@RequestParam("rno") int rno, @ModelAttribute("scri") SearchCriteria scri, Model model)throws Exception{
		logger.info("update Reply");
		
		ReplyVO vo = null;
		
		vo =RepService.readReplySelect(rno);
		
		model.addAttribute("readReply", vo);
		model.addAttribute("scri", scri);
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
