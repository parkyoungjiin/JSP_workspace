<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>jdbc_connect_test2.jsp</h1>
	<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	%>
	<h1>드라이버 로드 성공</h1>
	
	<hr>
	
	<%
	DriverManager.getConnection("jdbc:mysql://localhost:3306/study_jsp", "root", "1234");
	%>
	<h1>DB 연결 성공!</h1>
</body>
</html>