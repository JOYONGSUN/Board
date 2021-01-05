package kr.or.bit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import kr.or.bit.dto.user;
import kr.or.bit.service.UserService;

@Controller
public class UserController {

	@Autowired
	private View jsonview;

	@Autowired
	private UserService userservice;

	// 암호화 객체
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	// user 객체 담을 임시 map
	Map<String, Object> map = new HashMap<String, Object>();

	// 인증 메일 전송시 생성할 random 객체
	Random random = new Random();
	int ran;

	// 회원가입 버튼을 눌렀을 때 이메일 전송 method
	@RequestMapping(value = "joinOk.pie", method = RequestMethod.POST)
	public String joinOk(user u) {
		map.put("user", u);
		try {
			ran = random.nextInt(9999999);// 유저에게 이메일로 보낼 난수 생성
			userservice.emailCertify(u.getEmail(), ran);// 이메일 전송
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "user/register_emailRequest";
	}
	
	//로그아웃
	@RequestMapping(value = "logout.pie", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:index.htm";
	}

	// 유저들이 받은 이메일을 눌러서 서버에게 다시 request할 때 타는 method
	@RequestMapping(value = "checkEmail.pie", method = RequestMethod.GET)
	public String emailCheck(@RequestParam("check") int ranCheck, HttpSession session) {
		boolean trueOrFalse;
		user u = (user) map.get("user");
		if (ran == ranCheck) {// 서버에서 보낸 난수와 유저가 응답한 난수가 같으면 !!
			u.setPwd(this.bCryptPasswordEncoder.encode(u.getPwd())); // 사용자가 입력한 비밀번호 암호화
			String url = userservice.insertUser(u); // mysql에 user insert : 회원가입 성공
			trueOrFalse = true;
			session.setAttribute("trueOrFalse", trueOrFalse);
			return "redirect:index.htm";
		} else {
			trueOrFalse = false;
			session.setAttribute("trueOrFalse", trueOrFalse);
			return "redirect:index.htm";
		}
	}

	// 이메일 확인 비동기
	@RequestMapping(value = "searchEmail.pie", method = RequestMethod.POST)
	public View memberSearch(user u, Model model) {
		System.out.println(u.getEmail());
		user isExist = userservice.searchEmail(u.getEmail());
		model.addAttribute("user", isExist);
		return jsonview;
	}

	// 이메일로 인증번호 전송 컨트롤러
	@RequestMapping(value = "findPassword.pie", method = RequestMethod.POST)
	public View findPassword(user u, Model model) {

		// 이메일로 보낼 난수
		ran = random.nextInt(999999);

		try {
			// 이메일로 인증번호 전송 서비스
			userservice.passwordCertify(u.getEmail(), ran);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		model.addAttribute("user", u.getEmail());
		return jsonview;
	}

	// 비밀번호 찾기에서 입력한 인증번호 확인 컨트롤러
	@ResponseBody
	@RequestMapping(value = "certifyCheck.pie", method = RequestMethod.POST)
	public String certifyCheck(@RequestParam("certifyNum") int certifyNum) {
		System.out.println(certifyNum);
		if (certifyNum == ran) {
			// 인증번호 맞음
			System.out.println("인증번호확인완료");
			return "success";
		} else {
			// 인증번호 틀림
			System.out.println("인증번호확인실패");
			return "fail";
		}
	}

	// 비밀번호 변경
	@RequestMapping(value = "modifyPassword.pie", method = RequestMethod.POST)
	public String modifyPassword(@RequestParam("email") String email ,user u, HttpSession session) {
		System.out.println("모디 파이");
		System.out.println(email);
		
		u.setEmail(email);
		
		System.out.println("모디파이 " + u.getEmail());
		u.setPwd(this.bCryptPasswordEncoder.encode(u.getPwd()));//비밀번호 암호화 
		userservice.modifyPassword(u);
		boolean check = true;
		System.out.println("비밀번호 변경 완료");
		session.setAttribute("check", check);
		return "redirect:index.htm";
	}
}
