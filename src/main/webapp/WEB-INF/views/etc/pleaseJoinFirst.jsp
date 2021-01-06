<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login</title>
	<jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/registerCompletedStyle.css">
	
</head>
<body>
	<!-- Top -->
	<jsp:include page="/WEB-INF/views/common/main_top.jsp"></jsp:include>
	
	<!-- login-register left navbar -->
	<jsp:include page="/WEB-INF/views/common/loginRegisterLeftNavbar.jsp"></jsp:include>
	
	<!-- Register Completed Page -->
	<div class="register-completed-wrapper">
		<div class="register-completed-contents">
			
			<!-- completed message1 -->
			<div class="register-completed-message1">
				<span>파이</span>합류에 실패하였습니다.
			</div>

			<!-- completed message2 -->
			<div class="register-completed-message2">
				먼저 회원가입을 해주세요.<br>
			</div>
			
			<!-- Register button -->
			<div class="register-completed-btn-wrapper">
				<a href = "join.pie"><button class="register-completed-btn">회원가입</button></a>
			</div>
		</div>
	</div>
	
</body>
</html>