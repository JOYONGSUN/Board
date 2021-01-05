package kr.or.bit.controller;
import java.io.IOException;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;

import kr.or.bit.dto.user;
import kr.or.bit.service.UserService;
import kr.or.bit.util.NaverLoginBO;

@Controller
public class NaverLoginController {
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private UserService userservice;
	
    /* NaverLoginBO */
    private NaverLoginBO naverLoginBO;
    private String apiResult = null;
    
    @Autowired
    private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
        this.naverLoginBO = naverLoginBO;
    }

    //로그인 첫 화면 요청 메소드
    @RequestMapping(value = "naverlogin.pie", method = { RequestMethod.GET, RequestMethod.POST })
    public String login(Model model, HttpSession session) {
        
        /* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
        
        //네이버 
        model.addAttribute("url", naverAuthUrl);

        /* 생성한 인증 URL을 View로 전달 */
        return "naver/naverlogin";
    }

    //네이버 로그인 성공시 callback호출 메소드
    @RequestMapping(value = "callback.pie", method = { RequestMethod.GET, RequestMethod.POST })
    public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
            throws IOException {
        OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBO.getAccessToken(session, code, state);
        
        //로그인 사용자 정보를 읽어온다.
        apiResult = naverLoginBO.getUserProfile(oauthToken);
        model.addAttribute("result", apiResult);
        System.out.println("result"+apiResult);
        
        //String형식인 apiResult를 json형태로 바꿈
        JSONParser parser = new JSONParser();
        
        Object obj = null;
		try {
			obj = parser.parse(apiResult);
		} catch (ParseException e) {
			e.printStackTrace();
		}
        JSONObject jsonObj = (JSONObject)obj;
        //데이터 파싱
        //Top레벨 단계 _response 파싱
        JSONObject response_obj = (JSONObject)jsonObj.get("response");
        //response의 nickname값 파싱
        String nickname = (String)response_obj.get("nickname");
        String email = (String)response_obj.get("email");
        

        //여기서 디비에 아이디가 있는지 조회 있으면 그냥 이동 
        user isExist = userservice.searchEmail(email);
        if(isExist != null) {
        	//아이디가 이미 존재하면 바로 메인 페이지로 이동
        	System.out.println("아이디 존재");
        	session.setAttribute("nick", isExist.getNickName());
        	session.setAttribute("loginuser", email);
        	return "main/main";
        }else {
        	//없으면 디비에 insert 후에 이동 
        	System.out.println("아이디 없음");
        	user u = new user();
        	u.setEmail(email);
        	u.setNickName(nickname);
        	
        	String pwd = "임시비밀번호";//임시 비밀번호 변경이 필요함..
        	u.setPwd(this.bCryptPasswordEncoder.encode(pwd));
        	session.setAttribute("nick", nickname);
        	session.setAttribute("loginuser", email);
        	
        	userservice.insertUser(u); // mysql에 user insert : 회원가입 성공
        	return "main/main";
        }
        
    }
}