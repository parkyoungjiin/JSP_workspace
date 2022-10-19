<%@page import="jsp09_jdbc_dao.StudentDAO"%>
<%@page import="jsp09_jdbc_dao.StudentDTO"%>
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
	// StudentDAO, StudentDTO 클래스를 활용하여
	// 회원 가입(INSERT) 작업 수행 후 결과 처리
	
	
	// POST 방식에 대한 한글 처리
	request.setCharacterEncoding("UTF-8");
	
	// insertForm.jsp 페이지로부터 전달받은 파라미터(idx, name) 가져와서 변수에 저장
	// => Integer.parseInt() 메서드를 활용하여 지정한 문자열 데이터를 정수로 변환하여 리턴
	//    (주의! 파라미터로 전달하는 문자열은 반드시 정수 형태의 문자열이어야한다!)
	int idx = Integer.parseInt(request.getParameter("idx"));
	String name = request.getParameter("name");
// 	out.println(idx + ", " + name);

	// ---------------------------------------------------------------
	// 데이터베이스에 사용될 데이터(파라미터)를 StudentDTO 객체에 저장
	// 1. StudentDTO 클래스 인스턴스 생성
	StudentDTO student = new StudentDTO();
	// 2. StudentDTO 인스턴스에 데이터 저장 => Setter 메서드 호출
	student.setIdx(idx);
	student.setName(name);
// 	System.out.println(student.getIdx() + ", " + student.getName());
	// ---------------------------------------------------------------
	// 데이터베이스 작업에 사용될 StudentDAO 인스턴스 생성
	StudentDAO dao = new StudentDAO();
	// StudentDAO 인스턴스의 insert() 메서드를 호출하여 회원 추가 작업 수행
	// => 파라미터 : StudentDTO 객체(student), 리턴타입 : int(insertCount)
	int insertCount = dao.insert(student);
	// =================================================================
	// 데이터 추가 작업 실패 시
	// => 자바스크립트를 사용하여 "학생 추가 실패!" 출력 후 이전페이지로 돌아가기
	// 아니면(= 추가 작업 성공 시)
	// => select.jsp 페이지로 이동(Redirect 방식)
	if(insertCount > 0) { // 작업 성공 시
		response.sendRedirect("select.jsp");
	} else { // 작업 실패 시
		%>
		<script type="text/javascript">
			alert("학생 추가 실패!");
			history.back();
		</script>
		<%
	}
	%>
</body>
</html>













