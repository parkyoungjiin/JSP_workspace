<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Inser
t title here</title>
</head>
<body>
	<h1>jdbc_connect_test1.jsp</h1>
	<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	%>
	<h1>드라이버 로드 성공</h1>
</body>
</html>