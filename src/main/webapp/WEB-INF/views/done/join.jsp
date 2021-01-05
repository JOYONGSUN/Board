<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/resources/static/static.jsp"></jsp:include>
<script src="<c:url value="/resources/js/joinCheck.js"/>"></script>
</head>
<body>
<h1>회원가입</h1>
<form onsubmit="return check()" action ="joinOk.do" method ="post">
	<input type ="text" placeholder ="이메일" name = "email" id = "email">
	<input type ="button" name ="emailCheck" value = "이메일 중복 검사" id ="emailCheck">
	<div id = "emailDiv"></div>
	<input type ="text" placeholder ="닉네임" name ="nickName" id = "nickName">(한글, 영문 3~20글자입니다.)
	<div id = "nickNameDiv"></div>
 	<input type ="password" placeholder ="비밀번호" name ="pwd" id = "pwd">(영문, 숫자, 특수문자 조합의 8~16글자입니다.)
 	<div id = "pwdDiv"></div>
	<input type ="password" placeholder ="비밀번호 확인" name ="pwdCheck" id = "pwdCheck">
	<div id = "pwdCheckDiv"></div>
	<input type ="submit" value ="회원가입">
</form>
</body>
</html>