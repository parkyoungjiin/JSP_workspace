<%@page import="java.util.ArrayList"%>
<%@page import="jsp11_dbcp.StudentDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>test4_result.jsp -JSTL</h1>
	
	<h3>
		번호 : ${idx } <br>
		아이디 : ${name } <br>
	</h3>
	
	<hr>
	
	<%for(int i =1; i<=10; i++){%>
		<%=i %> &nbsp;
	<% }%>
	
	<hr>
	<%--names 배열에 접근 --%>
	<c:forEach var="item" items = "${names }" varStatus="status">
		${status.index } 번 배열 데이터 : ${item } <br>
	</c:forEach>
	
	<hr>
	
	<%
	List<StudentDTO> studentList = (List<StudentDTO>)request.getAttribute("studentList");
	
	for(StudentDTO dto : studentList){%>
		<%=dto.getIdx() %> : <%=dto.getName() %><br>
	<%}%>
	
	<%--위 코드를 EL을 사용하여 표시 --%>
	
	<c:forEach var="student" items="${studentList }" varStatus="status" >
		${student.idx }<br>
		
	</c:forEach>
	

</body>
</html>