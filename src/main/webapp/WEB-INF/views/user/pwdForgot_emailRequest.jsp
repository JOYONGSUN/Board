<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login</title>
	<jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/pwdForgotEmailRequestStyle.css">
	
</head>
<body>
	<!-- Top -->
	<jsp:include page="/WEB-INF/views/common/main_top.jsp"></jsp:include>
	
	<!-- login-register left navbar -->
	<jsp:include page="/WEB-INF/views/common/loginRegisterLeftNavbar.jsp"></jsp:include>
	
	<!-- pwdForgot emailRequest Page -->
	<div class="pwdForgot-emailRequest-wrapper">
		<div class="pwdForgot-emailRequest-contents">
			<!-- email icon -->
			<div class="pwdForgot-emailRequest-icon">
				<i class="fas fa-envelope"></i>
			</div>
			<!-- 이메일 인증 문장1 -->
			<div class="pwdForgot-emailRequest-letter1">
				비밀번호<br>
				<span>이메일 인증</span> 발송
			</div>
			<!-- 이메일 인증 문장2 -->
			<div class="pwdForgot-emailRequest-letter2">
				인증메일을 확인해주세요.<br>
				000@gmail.com으로 인증메일이 발송되었습니다.
			</div>
			
			<!-- pwdForgot button -->
			<div class="pwdForgot-emailRequest-btn-wrapper">
				<button class="pwdForgot-emailRequest-btn">메인 화면으로 가기</button>
			</div>
		</div>
	</div>
	
</body>
</html>