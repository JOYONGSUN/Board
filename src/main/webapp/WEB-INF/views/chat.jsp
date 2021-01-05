<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Chat</title>
	<jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/chatStyle.css">
</head>
<body>
	<div class="chat-wrapper">	
		<!-- chat top -->
		<div class="chat-top-wrapper">
			<div class="chat-top-pic">
				<i class="fas fa-th-large"></i>			
			</div>
			<div class="chat-top-letters-wrapper">
				<div class="chat-top-title">
					프로젝트방
				</div>
				<div class="chat-top-users">
					#신동연#도재구#문지연#변재홍#조용선#전선규
				</div>
			</div>
		</div>
		
		<!-- chat body -->
		<div class="chat-body-wrapper">
			<!-- date -->
			<div class="chat-body-date">
				<div class="chat-body-date-line">
					――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
				</div>
				<div class="chat-body-date-letter">
					2020년 12월 12일
				</div>
				<div class="chat-body-date-line">
					――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
				</div>
			</div>
			
			<!-- chat contents -->
			<!-- sender -->
			<div class="chat-sender-wrapper">
				<!-- sender profile picture -->
				<div class="chat-sender-pic">
					<i class="fas fa-user"></i>
				</div>
				
				<!-- chat sender message -->
				<div>
					<div class="chat-sender-name">
						문지연
					</div>
					<div class="chat-sender-message-wrapper">
						<div class="chat-sender-message">
							Lorem ipsum dolor sit amet, consectetur adipiscing elit,
							sed do eiusmod tempor incididunt ut labore et dolore magna 
							aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
							ullamco laboris nisi ut aliquip ex ea commodo consequat. 
							Duis aute irure dolor in reprehenderit in voluptate velit 
							esse cillum dolore eu fugiat nulla pariatur. 
							Excepteur sint occaecat cupidatat non proident, 
							sunt in culpa qui officia deserunt mollit anim id est laborum.
						</div>
						<div class="chat-sender-time">
							오후 1:34
						</div>
					</div>
				</div>
			</div>
			
			<!-- receiver -->
			<div class="chat-receiver-wrapper">
				<!-- sender profile picture -->
				<div class="chat-receiver-pic">
					<i class="fas fa-user"></i>
				</div>
				
				<!-- chat receiver message -->
				<div>
					<div class="chat-receiver-name">
						문지연
					</div>
					<div class="chat-receiver-message-wrapper">
						<div class="chat-receiver-message">
							Lorem ipsum dolor sit amet, consectetur adipiscing elit,
							sed do eiusmod tempor incididunt ut labore et dolore magna 
							aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
							ullamco laboris nisi ut aliquip ex ea commodo consequat. 
							Duis aute irure dolor in reprehenderit in voluptate velit 
							esse cillum dolore eu fugiat nulla pariatur. 
							Excepteur sint occaecat cupidatat non proident, 
							sunt in culpa qui officia deserunt mollit anim id est laborum.
						</div>
						<div class="chat-receiver-time">
							오후 1:35
						</div>
					</div>
				</div>
			</div>
			
			<!-- '여기까지 읽었습니다' unread -->
			<div class="chat-body-unread">
				<div class="chat-body-unread-line">
					――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
				</div>
				<div class="chat-body-unread-letter">
					여기까지 읽었습니다.
				</div>
				<div class="chat-body-unread-line">
					――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
				</div>
			</div>
		</div>
		
		<!-- chat bottom -->
		<div class="chat-bottom-wrapper">
			<!-- chat message writing -->
			<div class="chat-msgWrite-wrapper">
				<!-- message area -->
				<textarea class="chat-msgWrite" placeholder="메시지를 입력하세요" onmouseup="this.style.borderColor='red'"></textarea>

				<!-- icons & button -->
				<div class="chat-msgWrite-bottom-wrapper">
					<!-- icons -->
					<div class="chat-msgWrite-icons-wrapper">
						<i class="fas fa-at"></i>
						<i class="fas fa-font"></i>
						<i class="fas fa-download"></i>
					</div>
					
					<!-- chat send button -->
					<div class="chat-msgWrite-btn">
						<button>전송</button>
					</div>
				</div>
			</div>
			
		</div>
	</div>
	
</body>
</html>