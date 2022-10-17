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
	<h1>회원가입 결과</h1>
	<%
		request.setCharacterEncoding("UTF-8");
		
		String driver = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/study_jsp";
		String user = "root";
		String password = "1234";
		
		Class.forName(driver);
		
		Connection con = DriverManager.getConnection(url, user, password);
		
		String sql = "SELECT * FROM jsp8_2";
		
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		
		ResultSet rs = pstmt.executeQuery();// select 구문은 ResultSet이라는 객체 사용
		
		
	%>
		<table border ="1">
			<tr>
				<th>이름</th>
				<th>아이디</th>
				<th>비밀번호</th>
				<th>주민번호</th>
				<th>이메일</th>
				<th>직업</th>
				<th>성별</th>
				<th>직업</th>
				<th>동기내용</th>
				<th>현재날짜, 시각</th>
			</tr>
		
		<%
		while(rs.next()){
			String name = rs.getString(1);
			String idx = rs.getString(2);
			String passwd = rs.getString(3);
			String jumin = rs.getString(4);
			String email = rs.getString(5);
			String job = rs.getString(6);
			String gender = rs.getString(7);
			String hobby = rs.getString(8);
			String content = rs.getString(9);
			String date = rs.getString(10);
			
		%>
		<tr>
			<td><%=name %></td>
			<td><%=idx %></td>
			<td><%=passwd %></td>
			<td><%=jumin %></td>
			<td><%=email %></td>
			<td><%=job %></td>
			<td><%=gender %></td>
			<td><%=hobby %></td>
			<td><%=content %></td>
			<td><%=date%></td>
		</tr>
		<% 
		}
		%>
		</table>
		
</body>
</html>