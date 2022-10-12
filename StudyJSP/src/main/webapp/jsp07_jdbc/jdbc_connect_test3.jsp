<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.mysql.cj.xdevapi.PreparableStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>jdbc_connect_test3.jsp</h1>
	<hr>
	
	<%
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/study_jsp";
	String user = "root";
	String password = "1234"; //패스워드까지 적어둔 코딩을 하드코딩이라 함. 
	
	Class.forName(driver);
	
	%>
	
	<h1> 드라이버연결 성공</h1>
	<hr>
	<%
	Connection con = DriverManager.getConnection(url, user, password);
	%>
	<h1> DB 연결 성공</h1>
	<h3>Connection 객체 정보 : <%=con %></h3>
	<hr>
	
	<%
	String sql = "CREATE TABLE student(idx INT, name VARCHAR(10))";
// 	String sql = "DELETE FROM student FROM idx = '1'";
	PreparedStatement pstmt= con.prepareStatement(sql);
	%>

	<h3>SQL 구문 전달 완료!</h3>
	<hr>

	<%
	int count = pstmt.executeUpdate();
	%>
	<h3>SQL 구문 실행 완료! - <%= count %>개</h3>
</body>
</html>