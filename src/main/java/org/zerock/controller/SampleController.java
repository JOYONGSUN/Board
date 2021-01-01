package org.zerock.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.domain.SampleVO;

import lombok.extern.log4j.Log4j;

@Controller 
@RequestMapping("/sample")
@Log4j
public class SampleController {
	
	@GetMapping(value = "/getText", produces = "text/plain; charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE: " + MediaType.TEXT_PLAIN_VALUE);
		return "안녕하세요";
	}

	@GetMapping(value = "/getSample", 
			produces = { MediaType.APPLICATION_JSON_UTF8_VALUE,
						 MediaType.APPLICATION_XML_VALUE })
	public SampleVO getSample() {
		return new SampleVO(112, "스타", "로드");
	}

	@GetMapping(value = "/getList")
	public List<SampleVO> getList() {
		return IntStream.range(1,10)  //1부터 10미만 까지의 루프를 처리
				.mapToObj(i -> new SampleVO(i, i+" First", i+" Last"))  //SampleVO 객체생성
				.collect(Collectors.toList());
	}

	@GetMapping(value = "/getMap")
	public Map<String, SampleVO> getMap() {

		Map<String, SampleVO> map = new HashMap<>();
		map.put("First", new SampleVO(111, "그루트", "주니어"));

		return map;
	}
	
	@GetMapping(value = "/getList2")
	public Map<String, List<SampleVO>> getList2() {

		Map<String, List<SampleVO>> map = new HashMap<>();
		List<SampleVO> list = new ArrayList<>();
		list.add(new SampleVO(1,"홍길동","주니어1"));
		list.add(new SampleVO(2,"이순신","주니어2"));
		
		map.put("list", list);

		return map;
	}

	
	@GetMapping(value = "/check", params = {"height", "weight"})
	public ResponseEntity<SampleVO> check(Double height, Double weight) {
		SampleVO vo = new SampleVO(0, "" + height, "" + weight);
		
		ResponseEntity<SampleVO> result = null;
		
		if (height < 150) {
          //result = ResponseEntity.status(상태코드).body(값(데이터));
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
			
		} else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		
		return result;
		
	}
	
	
	@GetMapping("/product/{cat}/{pid}")
	public String[] getPath(
			@PathVariable("cat") String cat,
			@PathVariable("pid") Integer pid) {
		return new String[] {"category: " + cat, "productid: " + pid};
	}
	
	
	@GetMapping("/all")
	public void doAll() {
		log.info("do all can access everybody");
	}
	
	@GetMapping("/member")
	public void doMember() {
		log.info("logined member");
	}
	
	@GetMapping("/admin")
	public void doAdmin() {
		log.info("admin only");
	}
	
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@GetMapping("/annoMember")
	public void doMember2() {
		log.info("logined annotation member");
	}
	
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/annoAdmin")
	public void doAdmin2() {
		log.info("admin annotation only");
	}
	
	
	
	
	
	
	
	




}
