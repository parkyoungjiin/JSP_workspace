<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
session.setAttribute("testValue", "Session Value");
// request.setAttribute("testValue2", "Request Value");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>test3</title>
</head>
<body>
	<h1>test3.jsp</h1>
	<form action="test3_result.jsp">
	
		<table border ="1">
			<tr>
				<td>이름</td>
				<td><input type="text" name = "name"></td>
			</tr>
			<tr>
				<td>나이</td>
				<td><input type="text" name = "age"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value = "확인"></td>
			</tr>
		
		
		</table>
	
	</form>
</body>
</html>