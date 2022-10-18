<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   
<%	
	String id = request.getParameter("idx");
   String driver="com.mysql.cj.jdbc.Driver";
   String url = "jdbc:mysql://localhost:3306/study_jsp";
   String user ="root";
   String password= "1234";
   
   Class.forName(driver);
   
   Connection con = DriverManager.getConnection(url, user, password);
   
   String sql = "select * from jsp8_2 where id=?";
   
   PreparedStatement pstmt = con.prepareStatement(sql);
   
   ResultSet rs = pstmt.executeQuery();
   
   
   %>
   
   <h1><%=id %>님의 회원 정보</h1>
   
   <%
   
	   %>
   
   


   
</body>
</html>