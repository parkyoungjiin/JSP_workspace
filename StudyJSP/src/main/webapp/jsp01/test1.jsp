<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	Calendar c = Calendar.getInstance();
	int hour = c.get(Calendar.HOUR);
	int min = c.get(Calendar.MINUTE);
	int sec = c.get(Calendar.SECOND); // 이 부분을 WAS가 처리하고 "현재시각~" 이 부분은 웹서버가 처리
	%>
	
	<h1>test1.jsp</h1>
	<h3>현재 시각은 <%=hour %>시 <%=min %>분 <%=sec %>초 입니다.</h3>
	
	<!--  JSP 페이지 동작 순서
	1. 클라이언트가 웹브라우저에서 주소 요청
	2. 웹서버가 WAS로 처리된 JSP에 부분 처리를 요청
	3. WAS에서 처리된 JSP에 대한 응답을 웹서버에 전송
	3. 웹서버가 응답을 받아 사용자에게 응답할 데이터 생성, 전송(HTML 부분)
	4. 
	
	
	 -->
</body>
</html>