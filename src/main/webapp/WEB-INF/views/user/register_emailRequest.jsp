<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login</title>
	<jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/registerEmailRequestStyle.css">
	
</head>
<body>
	<!-- Top -->
	<jsp:include page="/WEB-INF/views/common/main_top.jsp"></jsp:include>
	
	<!-- login-register left navbar -->
	<jsp:include page="/WEB-INF/views/common/loginRegisterLeftNavbar.jsp"></jsp:include>
	
	<!-- Register emailRequest Page -->
	<div class="register-emailRequest-wrapper">
		<div class="register-emailRequest-contents">
			<!-- email icon -->
			<div class="register-emailRequest-icon">
				<i class="fas fa-envelope"></i>
			</div>
			<!-- 이메일 인증 문장1 -->
			<div class="register-emailRequest-letter1">
				회원가입 완료를 위해<br>
				<span>이메일 인증</span>을 해주세요
			</div>
			<!-- 이메일 인증 문장2 -->
			<div class="register-emailRequest-letter2">
				회원가입을 축하합니다.<br>
				메일 인증완료 후 로그인 해주시기 바랍니다.
			</div>
			
			<!-- Register button -->
			<div class="register-emailRequest-btn-wrapper">
				<button class="register-emailRequest-btn">메인 화면으로 가기</button>
			</div>
		</div>
	</div>
	
</body>
</html>