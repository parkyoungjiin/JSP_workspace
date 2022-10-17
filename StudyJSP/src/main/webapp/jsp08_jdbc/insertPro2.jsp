<%@page import="java.sql.Date"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String jumin = request.getParameter("jumin1") + request.getParameter("jumin2"); 
	String email = request.getParameter("email1") + "@" + request.getParameter("email2");
	String job = request.getParameter("job");
	String gender = request.getParameter("gender");
	String hobby = "";
	String[] arrHobbies = request.getParameterValues("hobby");
	
// 	for (int i = 0 ; i<arrHobbies.length; i++){
// 		hobby += arrHobbies[i] + "/";
// 	}
	
	for(String strHobby : arrHobbies){
		hobby += strHobby + "/";
	}
	String content = request.getParameter("content");
	
	out.println(name + "<br>" + id + "<br>" + jumin + "<br>" + email + "<br>" + job + "<br>" + gender + "<br>" + hobby + "<br>"+ content + "<br>");

String driver = "com.mysql.cj.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/study_jsp";
String user = "root";
String password = "1234";

	Class.forName(driver);
	
	Connection con = DriverManager.getConnection(url, user, password);
	
	String sql = "INSERT INTO jsp8_2 VALUES(?,?,?,?,?,?,?,?,?,now())";
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1,name);
	pstmt.setString(2,id);
	pstmt.setString(3,passwd);
	pstmt.setString(4,jumin);
	pstmt.setString(5,email);
	pstmt.setString(6,job);
	pstmt.setString(7,gender);
	pstmt.setString(8,hobby);
	pstmt.setString(9,content);
	

	int count = pstmt.executeUpdate();
%>
	<%
	if(count > 0) {
		response.sendRedirect("select2.jsp");
	}else{
	%>
	<script type="text/javascript">
		alert("회원 가입 실패!");
		history.back();
		</script>
	<%} 
	%>
	




