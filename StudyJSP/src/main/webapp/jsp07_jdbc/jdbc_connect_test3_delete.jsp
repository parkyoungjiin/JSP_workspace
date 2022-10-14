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
	<h1>jdbc_connect_test3_delete.jsp</h1>
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
	int idx = 1;
	String name = "김태희";
	
	String sql = "DELETE FROM student WHERE idx = ?, name = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	pstmt.setInt(1, idx);
	pstmt.setString(2, name);
	
	

	// 4단계, 실행 및 결과 처리
	int insertCount = pstmt.executeUpdate();
	
	%>
	<h3><%=insertCount %>개 레코드 작업 완료</h3>
	
	
</body>
</html>