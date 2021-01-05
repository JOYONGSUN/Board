<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<!-- userEdit_pwdCheck modal background -->
	<div id="userEdit_pwdCheck_modal_contents" class="userEdit-pwdCheck-contents-wrapper">
		<!-- top -->
		<div class="userEdit-pwdCheck-top-wrapper">
			<div class="top-wrapper1">
				<div class="top-number1">
					01
				</div>
				<div class="top-letter">
					비밀번호 확인
				</div>
			</div>
			<div class="top-wrapper2">
				<div class="top-number2">
					02
				</div>
				<div class="top-letter">
					회원 탈퇴완료
				</div>
			</div>
		</div>
	
		<!-- title -->
		<div class="userEdit-pwdCheck-title">
			비밀번호 확인
		</div>
		<div class="userEdit-pwdCheck-subTitle">
			탈퇴를 위한 본인확인을 위해 비밀번호를 입력해주세요.
		</div>
		
		<!-- password -->
		<div class="userEdit-pwdCheck-pwd-outer-wrapper">
			<form action="">
				<!-- 비밀번호 입력 -->
				<div class="userEdit-pwdCheck-pwd-inner-wrapper">
					<div class="userEdit-pwdCheck-pwd-letter">
						비밀번호
					</div>
					<input type="text" class="userEdit-pwdCheck-pwd" id="pwd" name="pwd">
					<div class="userEdit-pwdCheck-pwd-check">
						비밀번호가 일치하지 않습니다.
					</div>
				</div>
			</form>
		</div>
		
		<!-- btn -->
		<div id="userEdit_withdrawal_complete_btn" class="userEdit-pwdCheck-btn-wrapper">
			<button class="userEdit-pwdCheck-btn">확인</button>
		</div>
	</div>
</body>
</html>