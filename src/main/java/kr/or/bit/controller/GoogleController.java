package kr.or.bit.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.bit.dto.user;
import kr.or.bit.service.UserService;

@Controller
public class GoogleController {

	@Autowired
	private UserService userservice;

	// 암호화 객체
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	// 구글로 로그인시 타는 컨트롤러
	@RequestMapping(value = "googleLogin.pie", method = RequestMethod.GET)
	public String googleLogin(@RequestParam("loginuser") String loginuser, @RequestParam("name") String name,
			HttpSession session) {

		System.out.println(loginuser);
		System.out.println(name);

		// 여기서 디비에 아이디가 있는지 조회 있으면 그냥 이동
		user isExist = userservice.searchEmail(loginuser);
		if (isExist != null) {
			// 아이디가 이미 존재하면 바로 메인 페이지로 이동
			System.out.println("아이디 존재");
			session.setAttribute("nick", isExist.getEmail());
			session.setAttribute("loginuser", loginuser);
			return "main/main";
		} else {
			// 없으면 디비에 insert 후에 이동
			System.out.println("아이디 없음");
			user u = new user();
			u.setEmail(loginuser);
			u.setNickName(name);

			String pwd = "임시비밀번호";// 임시 비밀번호 변경이 필요함..
			u.setPwd(this.bCryptPasswordEncoder.encode(pwd));
			session.setAttribute("nick", name);
			session.setAttribute("loginuser", loginuser);

			userservice.insertUser(u); // mysql에 user insert : 회원가입 성공
			return "main/main";
		}

	}

}
