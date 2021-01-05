<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pwdForgot reset</title>
<jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
<link rel="stylesheet" href="/resources/css/pwdForgotResetStyle.css">
<jsp:include page="/resources/static/static.jsp"></jsp:include>
<script src="<c:url value="/resources/js/changePwd.js"/>"></script>
</head>
<body>
	<!-- Top -->
	<jsp:include page="/WEB-INF/views/common/main_top.jsp"></jsp:include>

	<!-- login-register left navbar -->
	<jsp:include page="/WEB-INF/views/common/loginRegisterLeftNavbar.jsp"></jsp:include>

	<!-- Register emailRequest Page -->
	<div class="pwdForgot-reset-wrapper">
		<div class="pwdForgot-reset-contents">
			<!-- pwdForgot reset message1 -->
			<div class="pwdForgot-reset-message1">비밀번호 재설정</div>

			<!-- pwdForgot reset message2 -->
			<div class="pwdForgot-reset-message2">새로 등록할 비밀번호를 입력해주세요.</div>
			<!-- pwdForgot reset pwd -->
			<div class="pwdForgot-reset-pwd-form">
				<form onsubmit='return check()' action='modifyPassword.pie?email=${sessionScope.email}'
					method='post'>
					<!-- 비밀번호 입력 -->
					<div class="pwdForgot-reset-pwd-wrapper">
						<div class="pwdForgot-reset-pwd-letter">비밀번호</div>
						<input type="password" class="pwdForgot-reset-pwd" id="pwd"
							name="pwd">
						<div id='pwdDiv' class="pwdForgot-reset-pwd-check"></div>
					</div>

					<!-- 비밀번호 재입력 -->
					<div class="pwdForgot-reset-pwd-wrapper">
						<div class="pwdForgot-reset-pwd-letter">비밀번호 재입력</div>
						<input type="password" class="pwdForgot-reset-pwd" id="pwdCheck"
							name="pwdCheck">
						<div id="pwdCheckDiv" class="pwdForgot-reset-pwd-check"></div>
					</div>

					<!-- pwdForgot reset button -->
					<div class="pwdForgot-reset-btn-wrapper">
						<input type="submit" id='modifyPwd' value="비밀번호 변경"
							class="pwdForgot-reset-btn">
					</div>

				</form>
			</div>



		</div>
	</div>

</body>
</html>