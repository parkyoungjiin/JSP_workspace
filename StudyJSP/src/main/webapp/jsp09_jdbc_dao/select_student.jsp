<%@page import="jsp09_jdbc_dao.StudentDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jsp09_jdbc_dao.StudentDAO"%>
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
	<table border="1">
		<tr><th>번호</th><th>이름</th></tr>
	<%
	//학생 목록 조회를 위해 studentDAO 인스턴스 생성 후 select() 메서드 호출
	StudentDAO dao = new StudentDAO();
	// 호출 결과를 studentList에 저장
	ArrayList studentList = dao.select(); 
	
	//for문을 통해 각각 List에 접근 (ArrayList는 size로 배열크기를 구할 수 있다.)
	for(int i = 0 ; i < studentList.size(); i++){
		// ArrayList 객체의 get() 메서드를 호출하여 지정된 인덱스의 요소(객체) 꺼내기
		// => 이 때, get() 메서드 리턴타입은 Object 타입(업캐스팅 되어 있음)
		// => 인덱스는 배열과 동일하게 사용
// 		Object o = studentList.get(i); // 부모 = 자식 -> 업캐스팅이 되는데
		// 업캐스팅이 되면 DTO에 있는 get, set 메서드를 호출할 수 없다.
		// -> 그렇기에 다운캐스팅을 진행
	// 		StudentDTO2 student = (StudentDTO2) o; // 자식 자식인스 = (자식) 부모;
		
		StudentDTO student = (StudentDTO)studentList.get(i);
		int id = student.getIdx();
		String name = student.getName();
		%>
		
		<tr>
			<td><%=id %></td>
			<td><%=name %></td>
		</tr>
		<%
		}
		%>
	
	</table>
			
		
</body>
</html>