package kr.or.bit.controller;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import kr.or.bit.dto.project;
import kr.or.bit.dto.project_member;
import kr.or.bit.service.ProjectService;
import kr.or.bit.service.UserService;

/*
파일명: ProjectController.java
설명: 프로젝트 추가,수정,삭제 및 정렬 작업 후 db에 저장
작성일: 2020-12-31 ~ 
작성자: 문지연,변재홍
*/
@Controller
public class ProjectController {

		@Autowired
		private UserService userservice;

		@Autowired
		private View jsonview;
		
		@Autowired
		private ProjectService projectservice;

		//Edit project Title
		@ResponseBody
		@RequestMapping(value = "editProjectTitle.pie", method = RequestMethod.POST)
		public View editProjectTitle(@RequestBody project pro, Model model){
					projectservice.editProjectTitleService(pro);
					System.out.println("프로젝트 제목 수정 완료");
					model.addAttribute("data", "success");
					return jsonview;
			}
		
		@RequestMapping(value = "createPIE.pie", method = RequestMethod.POST)
		public String createPIE(project pro){
					projectservice.createPieService(pro);
					System.out.println(pro);
					return "main/main";
			}
		
		//파이 버튼을 눌러서 해당 프로젝트로 이동 (프로젝트 넘버 가지고)
		@RequestMapping(value = "goToMain.pie", method = RequestMethod.GET)
		public String goToMain(@RequestParam("projectNum") int projectNum, HttpSession session){
					System.out.println("입장한 프로젝트 넘버 : "+projectNum);
					session.setAttribute("projectNum", projectNum);
					return "project/project_main";
			}
		
		//파이 버튼을 눌러서 해당 프로젝트로 이동 (프로젝트 넘버 가지고)
		@RequestMapping(value = "reKanban.pie", method = RequestMethod.GET)
		public String reKanban(){
					return "project/project_main";
			}
		
		//프로젝트 번호 리턴하는 메소드
		@ResponseBody
		@RequestMapping(value = "getProjectNum.pie", method = RequestMethod.POST)
		public View getProjectNum(HttpSession session, Model model){
					int pjNum = (int)session.getAttribute("projectNum");
					model.addAttribute("projectNum",pjNum);
					return jsonview;
			}
		
		//로그인 후 해당 사용자에 파이 리스트 가져오기
		@ResponseBody
		@RequestMapping(value = "getPieList.pie", method = RequestMethod.POST)
		public View getPieList(@RequestParam("userEmail")String userEmail, Model model){
					System.out.println("컨트롤러에서 받은 이메일 : "+userEmail);
					ArrayList<project> pieList = projectservice.getPieListService(userEmail);
					
					System.out.println(pieList);
					
					model.addAttribute("pieList",pieList);
			return jsonview;
			}
		
		//프로젝트 타이틀 가져오기 
		@ResponseBody
		@RequestMapping(value = "getProjectTitle.pie", method = RequestMethod.POST)
		public View getProjectTitle(@RequestParam("projectNum")int projectNum, Model model){
					String title = projectservice.getProjectTitleService(projectNum);
					model.addAttribute("projectTitle",title);
			return jsonview;
			}
		
		//팀원 초대하기 
		@ResponseBody
		@RequestMapping(value = "invitePIE.pie", method = RequestMethod.POST)
		public View invitePIE(@RequestBody Map<String, Object> data,
							  Model model){
			System.out.println(data);
			int projectNum = (int)data.get("finalProjectNum");
			ArrayList<String> pies = (ArrayList<String>)data.get("finalPie");
			String fromWho = (String)data.get("finalFromWho");
			String fromProjectName = (String)data.get("finalFromProjectName");
			
			for(int i = 0; i < pies.size(); i++) {
				try {
					userservice.inviteEmail(pies.get(i), projectNum, fromWho, fromProjectName);
				} catch (Exception e) {
					System.out.println(e.getMessage());
					e.printStackTrace();
				}	
			}
			model.addAttribute("data","success");
			return jsonview;
			}
		
		//초대 받기 
		@RequestMapping(value = "joinToPie.pie", method = RequestMethod.GET)
		public String joinToPie(@RequestParam("projectNum")int projectNum, 
							  @RequestParam("email")String email){
			project_member pm = projectservice.isExistFromProjectService(projectNum, email);
			if(pm == null) {
				try {
					projectservice.joinToPieAsTeamService(projectNum, email);
				} catch (Exception e) {
					System.out.println("회원가입 필요");
					return "etc/pleaseJoinFirst";
				}
				
				System.out.println("파이 합류 성공");
				return "etc/successedToJoinPie";
				//여기서 인서트 
			}else {
				//중복 중복 
				System.out.println("중복된 데이터");
				return "etc/failedToJoinPie";
			}
		}
		
		
		//<a href ="http://localhost:8090/joinToPie.pie?projectNum=${projectNum}&email=${email}">파이에 합류하기!</a>
		
		
	}				
