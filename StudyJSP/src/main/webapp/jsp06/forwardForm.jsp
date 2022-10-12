<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>forwardForm.jsp = 포워딩 연습</h1>
	<form action="forwardPro.jsp" method="get">
		<input type="hidden" name = "jumin" value = "970928-1111111"> <!--  hidden 타입은 입력하지 않아도 같이 넘어감. -->
		
		<h3>아이디 : <input type="text" name = "id"></h3>
		<h3>패스워드 : <input type="password" name = "passwd"></h3>
		<input type = "submit" value ="전송">
	</form>
</body>
</html>