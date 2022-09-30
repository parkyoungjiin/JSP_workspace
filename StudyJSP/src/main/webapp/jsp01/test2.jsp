<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- HTML주석입니다 주석은 소스보기를 통해 확인이 가능합니다. -->
	<h1> test2.jsp</h1>
	<%--
	JSP 주석입니다. 이 주석은 웹브라우저 소스보기를 통해 확인이 불가능합니다.
	=> JSP 코드가 포함될 경우 HTML 주석으로는 처리가 불가능하므로 반드시 JSP 주석을 사용해야 한다.
	 --%>
	 <%
	 //이 부분은 JSP 문서 내에서 자바코드가 기술되는 부분으로
	 //웹 브라우저에서 코드가 표시되지 않으며
	 // 서버측에서 실행된 결과값만 전달되는 부분입니다.
	 // 따라서, 자바에서 사용하는 주석도 사용 가능합니다.
	 Date now = new Date();
	 %>
	 <h3>현재시각 :<%=now %></h3>
	 
	 <hr>
	 
<!-- 	 <h1>test2.jsp</h1> -->
	 <!--  <h3>현재시각 :<%=now %></h3> -->
	 <%-- <h3>현재시각 :<%=now %></h3> --%>
</body>
</html>