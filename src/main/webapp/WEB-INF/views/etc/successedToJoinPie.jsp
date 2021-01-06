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
			<!-- logo image -->
			<div class="register-completed-image">
				<img src="/resources/img/registerCompleted.png">			
			</div>
			
			<!-- completed message1 -->
			<div class="register-completed-message1">
				WELCOME<br>
				<span>파이</span>의 원이 되신걸 환영합니다.
			</div>

			<!-- completed message2 -->
			<div class="register-completed-message2">
				새로운 파이에 합류하였습니다!<br>
			</div>
			
			<!-- Register button -->
			<div class="register-completed-btn-wrapper">
				<a href = "index.htm"><button class="register-completed-btn">시작하기</button></a>
			</div>
		</div>
	</div>
	
</body>
</html>