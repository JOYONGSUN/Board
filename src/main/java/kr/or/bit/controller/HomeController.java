package kr.or.bit.controller;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.bit.dto.user;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	//index
	@RequestMapping(value = "index.htm", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		return "user/login";
	}
	
	//로그인 성공 후 파이리스트 페이지로 이동 	
	@RequestMapping(value = "main.pie", method = RequestMethod.GET)
	public String projectList() {
		return "main/main";
	}
	
	//회원가입 페이지로 이동 
	@RequestMapping(value = "join.pie", method = RequestMethod.GET)
	public String join() {
		return "user/register";
	}
	
	//비밀번호 찾기 페이지로 이동
	@RequestMapping(value = "findPassword.pie", method = RequestMethod.GET)
	public String findPassword() {
		return "user/pwdForgot";
	}
	
	//이메일 인증 번호 보내고 인증 확인 페이지로 이동 
	@RequestMapping(value = "pwdForgot_emailRequest.pie", method = RequestMethod.GET)
	public String pwdForgot_emailRequest() {
		return "user/pwdForgot_emailRequest";
	}
	
	//비밀번호 인증 완료 후 비밀번호 변경 페이지로 이동 
	@RequestMapping(value = "changePwdAfterCertify.pie", method = RequestMethod.GET)
	public String changePwdAfterCertify(@RequestParam("email") String email, HttpSession session) {
		System.out.println("비밀번호 변경 이메일 : "+email);
		session.setAttribute("email", email);
		return "user/pwdForgot_reset";
	}
	
	
	
	
}
