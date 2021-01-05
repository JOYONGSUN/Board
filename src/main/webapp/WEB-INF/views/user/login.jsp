<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
<link rel="stylesheet" href="/resources/css/mainTopStyle.css">
<link rel="stylesheet" href="/resources/css/loginStyle.css">
<jsp:include page="/resources/static/static.jsp"></jsp:include>
<script src="<c:url value="/resources/js/googleLogin.js"/>"></script>
<body>
	<!-- Top -->
	<jsp:include page="/WEB-INF/views/common/main_top.jsp"></jsp:include>

	<!-- login left navbar -->
	<jsp:include page="/WEB-INF/views/common/loginRegisterLeftNavbar.jsp"></jsp:include>
	
	<!-- 이메일 인증 성공 or 실패 alert -->
	<c:if test="${sessionScope.trueOrFalse == true}">
		<script>
				alert("이메일 인증이 완료되었습니다.");
			</script>
			<%session.removeAttribute("trueOrFalse"); %>
	</c:if>
	<c:if test="${sessionScope.trueOrFalse == false}">
		<script>
				alert("이메일 인증이 실패하였습니다.");
			</script>
			<%session.removeAttribute("trueOrFalse"); %>

	</c:if>
	<c:if test="${sessionScope.check}">
		<script>
				alert("비밀번호가 변경되었습니다.");
				${sessionScope.check = false}
		</script>
	</c:if>

	<!-- Login Page -->
	<div class="login-wrapper">
		<div class="login-contents">
			<div class="login-title">
				또 다른 <span class="login-title-pie">파이</span>와<br> 협업하는 공간
			</div>

			<!-- Login Form -->
			<div class="login-form">
				<form action="${pageContext.request.contextPath}/login" method="post">
					<div class="login-email-wrapper">
						<div class="login-email-letter">이메일(아이디)</div>
						<input type="text" class="login-email" id="email" name="username"
							placeholder="pie@pie.com">
					</div>
					<div class="login-password-wrapper">
						<div class="login-password-letter">비밀번호</div>
						<input type="password" class="login-password" id="pwd" name="password"
							placeholder="">
					</div>

					<!-- Login button -->
					<div class="login-btn-wrapper">
					<input type="submit" value="로그인" class="login-btn"> 
						<div class="login-btn-check">
							<c:if test="${param.error != null }">
								<div>
									<c:if test="${SPRING_SECURITY_LAST_EXCEPTION != null}">
										<c:out value="이메일 또는 비밀번호가 일치하지 않습니다. 다시 확인해주세요." />
									</c:if>
								</div>
							</c:if>
						</div>
					</div>
				</form>
			</div>

			<div class="login-page-register-wrapper">
				<div class="login-page-register-letter-wrapper">
					<div class="login-page-register-letters">
							<a href="join.pie"><span>회원가입</span></a> | <a href="findPassword.pie"><span>비밀번호 찾기</span></a>
					</div>
					<div class="login-page-register-letter-social">소셜 로그인</div>
				</div>
				<div class="login-page-register-btn">
					<a href="naverlogin.pie"> <img
						src="/resources/img/naver_logo.png">
					</a>
					<div id="google" class="g-signin2" data-onsuccess="onSignIn"></div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>