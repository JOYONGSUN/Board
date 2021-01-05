<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/resources/static/static.jsp"></jsp:include>
<title>Insert title here</title>
<script>
	//google 로그아웃 함수
	function onLoad() {
		gapi.load('auth2', function() {
			gapi.auth2.init();
		});
	}

	//auth2 초기화 
	onLoad();

	//로그아웃 실행 
	function signOut() {
		let auth2 = gapi.auth2.getAuthInstance();
		auth2.signOut().then(function() {
			location.href = "logout.pie";
		});
	}
</script>
</head>
<body>
	<h1>칸반보드 들어올곳</h1>
	${sessionScope.loginuser}
	<a href="#" onclick="signOut();">로그아웃</a>
</body>
</html>