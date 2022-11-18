<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>test2.jsp -JSTL</h1>
	<c:set var="str"  value="Hello, World!"/>
	<h3>\${str } = ${str }</h3>
	
	<%--자바코드로 생성한 현재 페이지의 변수 사용하기 위해서는 --%>
	<%String str2 = "Hello, World!"; %>
	<%-- 방법 1. page 영역 객체의 속성값으로 값 전달 --%>
	<%pageContext.setAttribute("str2", "str2"); %>
	
	<%-- 방법 2. c:set 태그로 JSTL에서의 변수로 변환 후 접근이 가능하다 (value에 표현식으로 값 전달) --%>
<%-- 	<c:set var="str2"  value="<%=str2 %>"/> --%>
	
	
	<%--출력 방법 1 --%>
	<h3>\${str2 } = ${str2 }</h3>
	<%--출력 방법 2 <c:out>  --%>

	<c:set var = "targetTag" value = "&lt;c:out&gt;"/>
	<h3>
		<c:out value="${targetTag }"/><br>
		<c:out value="${targetTag }" escapeXml="false"/><br>
	</h3>
	
	<hr>
	<%-- 값 삭제 --%>
	<c:remove var="str"/>
	<h3>\${str }값 삭제 후 = ${str }</h3>
	<h3>\${empty str } empty 여부 = ${empty str }</h3>
</body>
</html>