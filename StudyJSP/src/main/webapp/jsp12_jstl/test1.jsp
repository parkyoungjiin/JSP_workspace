<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
session.setAttribute("testValue", "Session Value");

// request.setAttribute("testValue2", "Request Value");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>test1.jsp</h1>
	<form action="test1_result.jsp">
	
		<table border ="1">
			<tr>
				<td>�̸�</td>
				<td><input type="text" name = "name"></td>
			</tr>
			<tr>
				<td>����</td>
				<td><input type="text" name = "age"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value = "Ȯ��"></td>
			</tr>
		
		
		</table>
	
	</form>
</body>
</html>