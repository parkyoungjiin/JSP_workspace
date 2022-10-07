<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>sessionTest2_remove2.jsp</h1>
	
	<h3><%session.removeAttribute("sessionValue2"); %></h3>
	
	<h1>세션값 삭제 완료!</h1>
	<input type="button" value = "돌아가기" onclick="location.href ='sessionTest2.jsp'">	
</body>
</html>