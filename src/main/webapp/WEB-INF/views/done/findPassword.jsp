<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/resources/static/static.jsp"></jsp:include>
<script src="<c:url value="/resources/js/findPassword.js"/>"></script>
</head>
<body>
<h1 class = "p">비밀번호 찾기</h1>
<p class = "p">회원가입하신 이메일을 입력해주세요.</p>
<input type ="text" placeholder ="이메일" id ="email"><input type ="button" value ="입력" id ="emailCheck">
<div id ="certify">
<!-- 인증번호 텍스트 박스 동적 생성 장소 -->
</div>
</body>
</html>