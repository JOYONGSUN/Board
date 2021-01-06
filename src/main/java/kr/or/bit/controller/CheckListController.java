package kr.or.bit.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import kr.or.bit.dto.checkList;
import kr.or.bit.service.CheckListService;

/*
파일명: CheckListController.java
설명: 칸반 보드 모달에서 체크리스트 추가,수정,삭제 작업 후 db에 저장
작성일: 2021-01-05 ~ 
작성자: 문지연
*/

@Controller
public class CheckListController {

	@Autowired
	private View jsonview;

	@Autowired
	private CheckListService checklistservice;

	// Get Last CheckList Num
	@ResponseBody
	@RequestMapping(value = "getLastCheckSeqNum.pie", method = RequestMethod.POST)
	public View getLastListNum(Model model) {
		System.out.println("checkSeq Controller");
		int lastCheckSeq = checklistservice.getLastCheckSeqService();
		model.addAttribute("data", lastCheckSeq);
		return jsonview;
	}

	// Insert Check List 
	@ResponseBody
	@RequestMapping(value = "insertCheckList.pie", method = RequestMethod.POST)
	public View insertCheckList(@RequestBody checkList chk, Model model) {
		System.out.println("get in insert chk controller");
		HashMap<String, Object> checkListInfo = new HashMap<String, Object>();// db update시 파라미터 담을 해쉬맵
		checkListInfo.put("checkList", chk);
		boolean check = checklistservice.insertCheckListService(checkListInfo);
		if(check) {
			System.out.println("insertCheckList");
			return jsonview;
		}
		model.addAttribute("data", false);
		return jsonview;
	}
	
	// Load CheckList
	//해당 프로젝트의 해당되는 칸반 객체를 뷰에게 전달  
			@RequestMapping(value = "loadCheckList.pie", method = RequestMethod.POST)
			public View loadKanban(@RequestParam("cardSeq") int cardSeq, Model model) {
				System.out.println("cardSeq : "+cardSeq);
				
				ArrayList<checkList> chkList = checklistservice.loadWholeChkListService(cardSeq);
				for (int i = 0; i < chkList.size(); i++) {
					chkList.get(i).setCard_seq(cardSeq);
				}

				model.addAttribute("chkList", chkList);
				System.out.println("chkListController:"+chkList);
				return jsonview;
			}
}
