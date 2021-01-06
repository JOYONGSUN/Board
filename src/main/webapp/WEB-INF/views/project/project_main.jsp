<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>project main</title>
	<jsp:include page="/WEB-INF/views/common/head.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/projectMainStyle.css">
	<link rel="stylesheet" href="/resources/css/projectChatCreateStyle.css">
	<script src="/resources/js/projectMainTop.js"></script>
	<script src="/resources/js/projectSidebar.js"></script>
	<script src="/resources/js/projectMainChat.js"></script>
</head>
<body>
	<div></div>
	<!-- Top -->
	<jsp:include page="/WEB-INF/views/common/project_main_top.jsp"></jsp:include>
	
	<div class="project-main-wrapper">
		<!-- right sidebar -->
		<jsp:include page="/WEB-INF/views/common/project_main_sidebar.jsp"></jsp:include>
		
		<!-- right sidebar contents -->
		<div id="right-sidebar-contents-wrapper" class="right-sidebar-contents-wrapper-hidden">
			<!-- bookmark -->
			<jsp:include page="/WEB-INF/views/project_main_bookmark.jsp"></jsp:include>
			
			<!-- alarm -->
			<jsp:include page="/WEB-INF/views/project_main_alarm.jsp"></jsp:include>
			
			<!-- file -->
			<jsp:include page="/WEB-INF/views/project_main_file.jsp"></jsp:include>
			
			<!-- chat -->
			<jsp:include page="/WEB-INF/views/project_main_chat.jsp"></jsp:include>
			
			<!-- users -->
			<div id="fas fa-users" class="right-sidebar-users">
				사용자창
			</div>
		</div>
		<!-- main body -->
		<div class="project-main-body-wrapper" id="calendarMain" style="display: none">
			<jsp:include page="/WEB-INF/views/fullcalendar.jsp"></jsp:include>		
		</div>
		<div class="project-main-body-wrapper" id="kanban" style="display: block">
			<jsp:include page="/WEB-INF/views/kanban/kanban-board.jsp"></jsp:include>		
		</div>
		
	</div>
		
</body>
</html>