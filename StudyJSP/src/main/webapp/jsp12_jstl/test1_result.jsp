<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
request.setCharacterEncoding("UTF-8");

%>
   

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>test1_result.jsp</title>
</head>
<body>
	<h1>test1_result.jsp</h1>
	이름 : <%=request.getParameter("name") %> <br>
	나이 : <%=request.getParameter("age") %><br>
	testValue1 : <%=session.getAttribute("testValue") %><br>
	<hr>
	<%-- EL(Expression Language) 사용하여 파라미터 처리(내장객체 : param, ) --%>
	
	\${param.name } : ${param.name }<br>
	\${param.age } : ${param.age }<br>
	\${param.testValue } :${sessionScope.testValue }
	
	<h3>
	\${10 + 20 } = ${10 + 20 }<br>
	\${param.age + 20 } = ${param.age + 20 }<br>
	\${10 ge 20 } = ${10 ge 20 }<br>
	\${empty param.name } = ${empty param.name }<br>
	\${not empty param.name } = ${not empty param.name }<br>
	\${param.name eq null } = ${param.name eq null }<br>
	\${param.name ne null } = ${param.name ne null }<br>
	</h3>
	
</body>
</html>