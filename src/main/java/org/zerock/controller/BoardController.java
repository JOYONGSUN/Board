package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller  //스프링의 빈으로 인식
@Log4j 
@RequestMapping("/board/*")  //접두어: '/board'로 시작하는 모든 처리를 하게 함
@AllArgsConstructor  /* 의존성에 대한 처리(생성자를 만들고 자동 주입) */
public class BoardController {
	private BoardService service;
	

	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		log.info("delete attach files........");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("c:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("c:\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
					Files.delete(thumbNail);
				}
			} catch(Exception e) {
				log.error("delete file error" + e.getMessage());
			}
		});
	}
	
	
	//글 목록 가져오기
//	@GetMapping("/list")
//	public void list(Model model) {
//		log.info("list");
//		model.addAttribute("list", service.getList());
//	}

	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
		// model.addAttribute("pageMaker", new PageDTO(cri, 123));
		int total = service.getTotal(cri);
		log.info("total: " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	
	// 등록화면
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")  //추가
	public void register() {}
	
	// 등록처리
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")

	public String register(BoardVO board, RedirectAttributes rttr) {
	    
	    log.info("==========================");
	    log.info("register: " + board);

	    if (board.getAttachList() != null) {
	        board.getAttachList().forEach(attach -> log.info(attach));
	    }
	    
	    log.info("==========================");
	    
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
	    
	    return "redirect:/board/list";
	}

	
	
	
	// 상세보기
	@GetMapping({"/get"})
	public void get(
			@RequestParam("bno") Long bno, 
			@ModelAttribute("cri") Criteria cri, 
			Model model) 
	{
		log.info("/get");
		model.addAttribute("board", service.get(bno));
	}

	//수정화면
	@PreAuthorize("principal.username == #writer")  //추가
	@GetMapping({"/modify"})
	public void modify(
			@RequestParam("bno") Long bno, 
			@ModelAttribute("cri") Criteria cri, 
			Model model,
			String writer)  //추가 
	{
		log.info("/modify");
		model.addAttribute("board", service.get(bno));
	}
	
	
	// 수정처리
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(
			BoardVO board, 
			@ModelAttribute("cri") Criteria cri, 
			RedirectAttributes rttr) 
	{
		log.info("modify:" + board);

		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/board/list" + cri.getListLink();
	}
	
	// 삭제 처리
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(
			@RequestParam("bno") Long bno, 
			Criteria cri, 
			RedirectAttributes rttr,
			String writer)
	{
		log.info("remove..." + bno);

		List<BoardAttachVO> attachList = service.getAttachList(bno);

		if (service.remove(bno)) {
			deleteFiles(attachList);  // 첨부파일 삭제
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/board/list";  // 목록으로 이동
	}

	
	

	// 첨부파일 목록
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody	
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		log.info("getAttachList " + bno);
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
	
	
	
	
	
	
	
	
	
}
