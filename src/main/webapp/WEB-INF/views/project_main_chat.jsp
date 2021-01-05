<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<div id="far fa-comment-dots" class="right-sidebar-chat">
		<div id="crtChat-modal-background"></div>
		<!-- chat create button -->
		<div class="chat-createBtn-wrapper">
			<button id="crtChatBtn" class="chat-createBtn">+ 채팅방 생성하기</button>
			
			<!-- chatting page to create -->
			<jsp:include page="project_main_chat_create.jsp"></jsp:include>
		</div>
		
		<!-- chat search -->
		<div class="chat-search-wrapper">
			<div class="chat-search-letter">채팅방 검색</div>
			<div>
				<input class="chat-search-box" type="search">
			</div>
		</div>
		
		<!-- chat-list -->
		<div id="chat-list" class="chat-lists-wrapper">
			<!-- 
			sample data
			<div id="complete_Chatting_Room" class="chat-list-wrapper">
				<div class="chat-list-img">
					<i class="fas fa-th-large"></i>
				</div>
				<div class="chat-list-letter-wrapper">
					<div class="chat-list-letter-title">프로젝트방</div>
					<div class="chat-list-letter-members">#신동연#도재구#문지연</div>
				</div>
				<div class="chat-list-cancel">
					<i class="fas fa-times"></i>
				</div>
			</div>
			 -->
		</div>

		
		
	</div>
</body>
</html>