<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>pageContextTest2.jsp</h1>
	<h3>include()메서드 호출 전</h3>
	<hr>
	<%
	pageContext.include("pageContextTest2_include1.jsp");
	%>
	<hr>
	<%
	pageContext.include("pageContextTest2_include2.jsp");
	%>
	<hr>
	<h3>include() 메서드 호출 후</h3>
</body>
</html>