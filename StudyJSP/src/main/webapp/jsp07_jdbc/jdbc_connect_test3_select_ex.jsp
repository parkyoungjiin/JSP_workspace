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
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/study_jsp";
	String user = "root";
	String password = "1234";
	
	Class.forName(driver);
	
	//2단계 : Connection으로 연결
	Connection con = DriverManager.getConnection(url, user, password);
	//3단계 : 구문 작성
	String sql = "SELECT * FROM student";
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	//4단계 : 구문 실행
	ResultSet rs = pstmt.executeQuery();
	
// 	SELECT 구문 실행 성공 시 다음 형태의 테이블 구조가 ResultSet 타입 객체로 관리됨
// 	- 커서(Cursor) 라는 개념의 포인터가 항상 테이블의 첫번째 레코드 위에 위치
// 	- 커서를 위 아래로 이동시키면서 커서가 위치한 곳의 레코드에 접근 가능
// 	  => ResultSet 객체의 next() 메서드를 호출하여 커서를 다음 레코드로 이동
// 	     이 때, 다음 레코드가 존재하면 true 리턴하고, 존재하지 않으면 false 리턴

	out.print(rs.next() + "<br>");
		

// 조회할 레코드가 복수개(2개 이상)일 경우
	// if 문 대신 while 문을 사용하여 "다음 레코드가 존재할 동안" 반복
	%>
	<table border ="1">
		<tr>
			<th>번호</th><th>이름</th>
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