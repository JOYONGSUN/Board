<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>

	<div id="invite_new_pie_modal" class="userEdit-contents-wrapper">
		<!-- userEdit title -->
		<div class="userEdit-title">
			초대하기
		</div>
		<!-- userEdit profile -->
		<div class="userEdit-profile-wrapper">
		</div>
		<!-- userEdit password -->
		<div class="userEdit-pwd-outer-wrapper">
			<form action="createPIE.pie" method = "post">
				<!-- 비밀번호 입력 -->
				<div class="userEdit-pwd-inner-wrapper">
					<div class="userInvite-input-letter">
						사용자 이메일 
					</div>
					<div class="userInvite-input-wrapper">
						<input type="text" class="userInvite" id="userName" name="project_name"><input type ="button" class="userInviteBtn" value = "확인">
						<input type="hidden" id="leader_email" name="leader_email" value = "${sessionScope.loginuser}">
					</div>
				</div>
				
				<div>
					<ul id = "userList">
					
					</ul>
				</div>
				
				<!-- create pie btn -->
				<div class="userEdit-btn-wrapper">
					<input type = "submit" class="userInvite-btn" value = "초대 메일 보내기">
				</div>
			</form>
		</div>
</div>
	
</body>
</html>