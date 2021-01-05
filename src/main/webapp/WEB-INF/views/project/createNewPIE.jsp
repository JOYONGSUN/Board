<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>

	<div id="create_new_pie_modal" class="userEdit-contents-wrapper">
		<!-- userEdit title -->
		<div class="userEdit-title">
			새 파이 만들기
		</div>
		<!-- userEdit profile -->
		<div class="userEdit-profile-wrapper">
		</div>
		<!-- userEdit password -->
		<div class="userEdit-pwd-outer-wrapper">
			<form action="createPIE.pie" method = "post">
				<!-- 비밀번호 입력 -->
				<div class="userEdit-pwd-inner-wrapper">
					<div class="userEdit-pwd-letter">
						파이명
					</div>
					<input type="text" class="userEdit-pwd" id="project_name" name="project_name">
					<input type="hidden" id="leader_email" name="leader_email" value = "${sessionScope.loginuser}">
				</div>
				<!-- create pie btn -->
				<div class="userEdit-btn-wrapper">
					<input type = "submit" class="userEdit-btn" value = "생성">
				</div>
			</form>
		</div>
	</div>
	
</body>
</html>