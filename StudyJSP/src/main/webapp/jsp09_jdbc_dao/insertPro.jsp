<%@page import="jsp09_jdbc_dao.StudentDAO"%>
<%@page import="jsp09_jdbc_dao.StudentDTO"%>
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
	
		int idx = Integer.parseInt(request.getParameter("idx"));
		String name = request.getParameter("name");
		
		//--------------------------------------------
		//데이터베이스에 사용될 데이터(파라미터)를 StudentDTO 객체에 저장
		// 1. StudentDto 클래스 인스턴스 생성
		StudentDTO student = new StudentDTO(); // idx, name을 DTO에 넣었음
		//2. StudentDTO 인스턴스에 데이터 저장 -> 
		student.setIdx(idx);
		student.setName(name);
		//3. StudentDAO 인스턴스 생성
		StudentDAO dao = new StudentDAO();
		//4. DAO 인스턴스의 insert() 메서드를 호출하여 회원 추가 작업 수행
		int insertCount = dao.insert(student);
		//--------------------------------------------
		
	%>
	
	<%
	if(insertCount > 0){
		response.sendRedirect("select.jsp");
	}else{
	%>
		<script type="text/javascript">
		alert("학생 추가 실패");
		history.back();
		</script>
	<%
	}
	%>
</body>
</html>