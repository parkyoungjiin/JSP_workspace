<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// response.sendRedirect("pageContextTest2.jsp");
// response.sendRedirect는 웹브라우저 주소가 test2로 변경
pageContext.forward("pageContextTest2.jsp");
// pageContext.forward는 웹 브라우저 주소가 변경되는 것이 아니라 이동만함. 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>pageContextTest1.jsp</h1>
	<script type="text/javascript">
	
	alert("확인!")
	</script>
</body>
</html>