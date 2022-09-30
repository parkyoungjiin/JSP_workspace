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
	<h1>test4.jsp - 스크립틀릿과 표현식 연습</h1>
	
	<%
	Calendar c = Calendar.getInstance();
	int hour = c.get(Calendar.HOUR_OF_DAY);
	int min = c.get(Calendar.MINUTE);
	int sec = c.get(Calendar.SECOND); // 이 부분을 WAS가 처리하고 "현재시각~" 이 부분은 웹서버가 처리
	%>
	
	<h1>test1.jsp</h1>
	<h3>현재 시각은 <%=hour %>시 <%=min %>분 <%=sec %>초 입니다.</h3> 
	
	<%
	//스크립틀릿 내에서 표현식과 동일한 방식으로 데이터를 출력하기 위해서는
	//JSP 내장 객체인 out객체의 print(), println() 메서드로 출력해야 한다.
	out.print("<h3>현재 시각은 " + hour + "시" + min + "분" + sec + "초</h3>"); // system 이붙으면 콘솔에 출력, out만 사용하면 웹페이지에 출력
	
	%>
	
	<%--
	스크립틀릿 내에서는 자바문법사용이 가능하므로, if문 등도 사용 가능함
	=> 따라서 , HTML 태그를 특정 조건에서만 실행되도록 하기 위해서
	if문 블록, html태그를 조합하여 사용이 가능하다.
	
	= > 또한, 특정 태그를 반복실행하기 위하여 for문, while문 등과 결합도 가능하다.
	=> 단 ,if문등의 문장과 조합하여 html 태그를 사용하여 두 가지 방법 중 하나를 사용
		1. 스크립틀릿 내부에 out.print()
		=> HTML태그보다 자바코드가 더 많을 경우에 사용 !
		
		2. 스크립틀릿 외부에 html 태그 작성
		=> 자바코드보다 HTML태그가 더 많을 경우 사용 !
	 --%>
	 <%
	 //1번 방법
	 if(hour < 12) {
		 out.print("<h3>오전입니다.</h3>");
	 }else{
		 out.print("<h3>오후입니다.</h3>");
	 }
	 
	 
	 %>
	 
	 <%--2번방법 스크립틀릿으로만 if문을 표현하고, html은 외부에 선언 --%>
	 <%if(hour < 12) { %>
	 	<h3>오전입니다.</h3>
	 <%} else {%>
	 	<h3>오전입니다.</h3>
	 <%} %>
	 
</body>
</html>