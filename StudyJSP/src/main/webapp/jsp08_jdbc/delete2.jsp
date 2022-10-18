<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
// 	out.print(id);

	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/study_jsp";
	String user = "root";
	String password = "1234";
	
	Class.forName(driver);
	
	Connection con = DriverManager.getConnection(url, user, password);
	String sql = "DELETE FROM jsp8_2 where id =?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, id);
	int result = pstmt.executeUpdate();
	
%>
<% if(result > 0) {
	response.sendRedirect("select2.jsp");
%>
<%}else{%>
	alert("삭제 실패!");
	history.back();
<%}%>