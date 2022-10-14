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
	<h1>jdbc_connect_test3_update.jsp</h1>
	<%
	String driver ="com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/study_jsp";
	String user = "root";
	String password ="1234";
	// 드라이버 로드
	Class.forName(driver); 
	
	//DB연결
	Connection con = DriverManager.getConnection(url, user, password);
	
	int idx = 1;
	String name = "김길동";
	
	String sql = "UPDATE student SET idx = ?, name = ? WHERE idx = 1";
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	pstmt.setInt(1, idx);
	pstmt.setString(2, name);
	
	
	// 4단계, 실행 및 결과 처리
	int insertCount = pstmt.executeUpdate();
	
	%>
	<h3>완료 <%=insertCount %>개 </h3>
	
	
</body>
</html>