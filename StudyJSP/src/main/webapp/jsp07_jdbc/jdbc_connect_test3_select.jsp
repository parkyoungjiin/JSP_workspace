<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Driver"%>
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
	<h1>jdbc_connect_test3_select.jsp</h1>
	<%
	String driver ="com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/study_jsp";
	String user = "root";
	String password ="1234";
	// 드라이버 로드
	Class.forName(driver); 
	
	//DB연결
	Connection con = DriverManager.getConnection(url, user, password);
	
	// 3단계, SQL 구문 작성, 전달
	String sql = "SELECT * FROM student";
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	ResultSet rs = pstmt.executeQuery();// select 구문은 ResultSet이라는 객체 사용
	
	out.print(rs.next() + "<br>");
// 	out.print(rs.next() + "<br>");
// 	out.print(rs.next() + "<br>");
// 	out.print(rs.getInt("idx") + "<br>"); 

// 	if(rs.next()){
// 		out.println("다음 레코드 존재함!");
// 	}else {
// 		out.println("다음 레코드 존재하지 않음!");
// 	}
	// 조회할 레코드가 복수개 일 경우 if문 대신 while문을 사용하여 "다음 레코드가 존재할 동안 " 반복
	while(rs.next()){
		out.println("다음 레코드 존재함!" + "<br>");
		int idx = rs.getInt("idx");
		String name = rs.getString("name");
		
		out.println("순번 : " + idx + "<br>" + "이름 : " + name + "<br>");
		
	}
	%>
		
	
	
</body>
</html>