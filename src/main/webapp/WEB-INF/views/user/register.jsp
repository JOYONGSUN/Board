<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
<jsp:include page="/resources/static/static.jsp"></jsp:include>
<link rel="stylesheet" href="/resources/css/registerStyle.css">
<script src="<c:url value="/resources/js/joinCheck.js"/>"></script>
</head>
<body>
	<!-- Top -->
	<jsp:include page="/WEB-INF/views/common/main_top.jsp"></jsp:include>

	<!-- login-register left navbar -->
	<jsp:include page="/WEB-INF/views/common/loginRegisterLeftNavbar.jsp"></jsp:include>

	<!-- Register Page -->
	<div class="register-wrapper">
		<div class="register-contents">
			<div class="register-user-pic-wrapper">
				<div class="register-user-pic">
					<i class="fas fa-user"></i>
				</div>
				<div class="register-user-pic-select-wrapper">
					<i class="fas fa-camera"></i>
				</div>
			</div>

			<!-- Register Form -->
			<div class="register-form">
				<form onsubmit="return check()" action="joinOk.pie" method="post">
					<!-- 아이디 입력 -->
					<div class="register-email-wrapper">
						<div class="register-email-letter">이메일(아이디)</div>
						<input type="text" class="register-email" id="email" name="email"
							placeholder="pie@pie.com">
					</div>

					<!-- email duplicated check button -->
						<input type="button" name="emailCheck" value="이메일 중복 검사"
							class="register-btn" id="emailCheck">
							<div class="register-email-check" id="emailDiv"></div>

					<!-- 이름 입력 -->
					<div class="register-name-wrapper">
						<div class="register-name-letter">이름</div>
						<input type="text" class="register-name" name="nickName"
							id="nickName">
						<div class="register-email-check" id="nickNameDiv"></div>
					</div>

					<!-- 비밀번호 입력 -->
					<div class="register-password-wrapper">
						<div class="register-password-letter">비밀번호</div>
						<input type="password" class="register-password" id="pwd"
							name="pwd" placeholder="">
						<div class="register-password-check" id="pwdDiv"></div>
					</div>

					<!-- 비밀번호 재입력 -->
					<div class="register-password-wrapper">
						<div class="register-password-letter">비밀번호 재입력</div>
						<input type="password" class="register-password" id="pwdCheck"
							name="pwdCheck" placeholder="">
						<div class="register-password-check" id="pwdCheckDiv"></div>
					</div>

					<!-- Register button -->
					<div class="register-btn-wrapper">
						<input type="submit" value="완료" class="register-btn">
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>