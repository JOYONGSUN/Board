<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<div id="crtChat-modal" class="crtChat-modal">
		<div class="crtChat-wrapper">
			<!-- top -->
			<div class="crtChat-top-wrapper">
				<div class="crtChat-logo">
					<img src="/resources/img/pie_logo.png">
				</div>
				<div class="crtChat-letter-wrapper">
					<div class="crtChat-letter1">
						채팅 시작하기
					</div>
					<div class="crtChat-letter2">
						채팅할 <span class="crtChat-letter2-yellow">파이원</span>을 선택해주세요
					</div>
				</div>
				<div class="crtChat-search">
					<input type="text" maxlength='10' id="crtChat-search-box" class="crtChat-search-box" name="">
					<i class="fas fa-search"></i>
				</div>
			</div>
			
			<!-- middle -->
			<div id="Chatting-UserList" class="crtChat-middle-wrapper">
				<!-- 
				<div class="crtChat-select-letter">
					파이원 선택
				</div>
				 -->
				 
				<!-- user sample1 -->
				<!-- 
				<div class="crtChat-select-users-wrapper">
					<div class="crtChat-select-user-wrapper">
						<div class="crtChat-select-user-subWrapper">
							<div class="crtChat-select-user-pic">
								<i class="fas fa-user"></i>					
							</div>
							<div class="crtChat-select-user-letters-wrapper">
								<div class="crtChat-select-user-name">
									도재구
								</div>
								<div class="crtChat-select-user-email">
									ehworn@gmail.com
								</div>
							</div>
						</div>
						<div class="crtChat-select-user-btn">
							<i class="fas fa-plus"></i>
						</div>
					</div>
				</div>
				 -->
				
			</div>
			
			<!-- bottom -->
			<div class="crtChat-bottom-wrapper">
				<div id="Selectedlist-Subject" class="crtChat-bottom-letter">
					선택된 파이원
				</div>
				<div id="Selected-List" class="crtChat-selected-users-wrapper">
					<!-- sample selected user1 -->
					<!-- 
					<div class="crtChat-selected-user-wrapper">
						<div class="crtChat-selected-user-pic">
							<i class="fas fa-user"></i>	
						</div>
						<div class="crtChat-selected-user-letter-wrapper">
							<div class="crtChat-selected-user-letter-name">
								도재구
							</div>
							<div class="crtChat-selected-user-letter-x">
								<i class="fas fa-times"></i>
							</div>
						</div>
					</div>
					 -->
					 
				</div>
				
				<div class="crtChat-bottom-btns-wrapper">
					<div id="crtChat-btn-cancel" class="crtChat-btn-cancel">
						취소
					</div>
					<div id="crtChat-btn-created" class="crtChat-btn-created">
						채팅방 생성하기
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>