<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
	<h1>학생 목록</h1>
	<%
		request.setCharacterEncoding("UTF-8");
		
		String driver = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/study_jsp";
		String user = "root";
		String password = "1234";
		
		Class.forName(driver);
		
		Connection con = DriverManager.getConnection(url, user, password);
		
		String sql = "SELECT * FROM student";
		
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		
		ResultSet rs = pstmt.executeQuery();// select 구문은 ResultSet이라는 객체 사용
		
		
	%>
		<table border ="1">
			<tr>
				<th>번호</th>
				<th>이름</th>
			</tr>
		
		<%
		while(rs.next()){
			int idx = rs.getInt(1);
			String name = rs.getString(2);
		
		%>
		<tr>
			<td><%=idx %></td><td><%=name %></td>
		</tr>
		<% 
		}
		%>
		</table>
		
</body>
</html>