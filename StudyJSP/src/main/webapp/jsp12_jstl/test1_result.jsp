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
	�̸� : <%=request.getParameter("name") %> <br>
	���� : <%=request.getParameter("age") %><br>
	testValue1 : <%=session.getAttribute("testValue") %><br>
	<hr>
	<%-- EL(Expression Language) ����Ͽ� �Ķ���� ó��(���尴ü : param, ) --%>
	
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