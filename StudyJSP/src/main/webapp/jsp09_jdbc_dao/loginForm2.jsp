<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>로그인</h1>
	<form action="loginPro2.jsp" method ="post" >
		<table border ="1">
			<tr>
				<th>이름</th>
				<td>
				<input type ="text" name ="id" required="required">
				</td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td>
				<input type ="password" name ="password" required="required">
				</td>
			</tr>
			<tr>
				<td colspan ="2" align ="center"><input type = "submit" value ="로그인"></td>
				
			</tr>
		
		
		</table>
	
	
	</form>
</body>
</html>