package org.zerock.security;

import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomNoOpPasswordEncoder implements PasswordEncoder {

	@Override
	public String encode(CharSequence rawPassword) {
        // 암호화 알고리즘 등을 사용해서 인코딩
		log.warn("before encode : " + rawPassword);
		return rawPassword.toString();
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
        // 사용자가 입력한 비밀번호를 인코딩해서 비교
		log.warn("matches : " + rawPassword + ":" + encodedPassword);
		return rawPassword.toString().equals(encodedPassword);
	}

}
