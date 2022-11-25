<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>test6.jsp</h1>
	<form action="redirectServlet" method="get"> <!-- method 생략하면 GET 방식, POST는 적어야 함. -->
		이름 : <input type="text" name="name"> <br>
		나이 : <input type="text" name="age"> <br>
		<input type="submit" value="myServlet4 서블릿 주소 요청(redirect)">
	</form>
	<hr>
	<form action="dispatchServlet" method="GET"> <!-- method 생략하면 GET 방식, POST는 적어야 함. -->
		이름 : <input type="text" name="name"> <br>
		나이 : <input type="text" name="age"> <br>
		<input type="submit" value="myServlet4 서블릿 주소 요청(dispatch)" >
	</form>
	
</body>
</html>