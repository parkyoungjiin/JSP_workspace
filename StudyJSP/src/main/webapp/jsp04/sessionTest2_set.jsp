<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>sessionTest2_set.jsp</h1>

	<%
	//session 객체에 속성값(데이터)을 저장하는 방법 - session.setAttribute() /
	session.setAttribute("sessionValue1", "첫 번째 세션 값");
	session.setAttribute("sessionValue2", "두 번째 세션 값");
	%>
	
	<h1>세션값 생성 완료!</h1>
	<h3><a href = "sessionTest2_get.jsp">세션값 확인</a></h3>
	<hr>
	
	<h3>세션값 1 : <%=session.getAttribute("sessionValue1") %></h3>
	<h3>세션값 2 : <%=session.getAttribute("sessionValue2") %></h3>
</body>
</html>