<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>findPassword</title>
	<jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/pwdForgotStyle.css">
	<jsp:include page="/resources/static/static.jsp"></jsp:include>
	<script src="<c:url value="/resources/js/findPassword.js"/>"></script>
</head>
<body>
	<!-- Top -->
	<jsp:include page="/WEB-INF/views/common/main_top.jsp"></jsp:include>
	
	<!-- login-register left navbar -->
	<jsp:include page="/WEB-INF/views/common/loginRegisterLeftNavbar.jsp"></jsp:include>
	
	<!-- Register emailRequest Page -->
	<div class="pwdForgot-wrapper">
		<div class="pwdForgot-contents">
			<!-- pwdForgot message1 -->
			<div class="pwdForgot-message1">
				비밀번호 찾기
			</div>
			
			<!-- pwdForgot message2 -->
			<div class="pwdForgot-message2">
				가입 시 등록한 이메일을 입력해주세요.
			</div>
			
			
			<!-- pwdForgot email -->
			<div class="pwdForgot-email-form">
					<!-- 아이디 입력 -->
					<div class="pwdForgot-email-wrapper">
						<div class="pwdForgot-email-letter">
							이메일(아이디)
						</div>
						<input type="text" class="pwdForgot-email" id="email" name="email" placeholder="pie@pie.com">
						<div class="pwdForgot-email-check">
						</div>
					</div>
					
					<!-- 인증번호 확인 폼 생성 구역  -->
					<div id ="certify">	
						
						
					</div>
			</div>
			
			<!-- pwdForgot button -->
			<div class="pwdForgot-btn-wrapper">
				<input type = "button" id ="emailCheck" class="pwdForgot-btn" value = "확인">
			</div>
		</div>
	</div>
	
</body>
</html>