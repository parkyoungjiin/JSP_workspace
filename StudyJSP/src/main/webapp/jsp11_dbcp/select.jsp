<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jsp11_dbcp.StudentDAO"%>
<%@page import="jsp11_dbcp.StudentDTO"%>
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
		<table border ="1">
			<tr>
				<th>번호</th>
				<th>이름</th>
			</tr>
	<%
	// 학생 목록 조회를 위해 StudentDAO 인스턴스 생성 후 select 메서드 호출
	// select는 파라미터가 없고, ***리턴타입*** : 
		StudentDAO dao = new StudentDAO();
		List<StudentDTO> studentList = dao.select();
		for(int i = 0 ; i< studentList.size(); i++){
// 			Object o = studentList.get(i);
			
			// 다운 캐스팅
			
// 			StudentDTO student = (StudentDTO)o;
			
			StudentDTO student = (StudentDTO)studentList.get(i);
			%>
			<tr>
			<!-- studentDTO 객체의 getXX를 호출하여 메서드 호출 -->
				
				<td><%=student.getIdx() %></td><td><%=student.getName() %></td>
			</tr>
			
		<% 
		}
		%>
			</table>
			
		
</body>
</html>