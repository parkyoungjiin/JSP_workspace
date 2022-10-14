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
	<h1>jdbc_connect_test3_insert.jsp</h1>
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
// 	String sql = "INSERT INTO student VALUES(5, '배하영')"; 
	// 외부로부터 추가할 레코드 데이터를 입력받아 변수에 저장
	
	int idx = 1;
	String name = "박영진";
	
	// INSERT 구문 작성 시, 변수값을 SQL구문에 전달 (방법2가지)
	// 1. 문자열 결합을 통해 변수값 구문에 포함 ( 추천 X )
// 		String sql = "INSERT INTO student VALUES(" + idx + ", '" + name + "')"; // 작은 따옴표 안에 문자열이 들어가야 하기에, 


	// 2. 만능문자(Wilcard) 부분에 데이터를 교체하는 작업 수행
	String sql = "INSERT INTO student VALUES(?,?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	// 2-1 Prepared Statement 객체의 setXXX() 메서드를 호출하여 만능문자를 데이터로 교체 (setXXX는 교체할 데이터의 자바 데이터타입 이름 사용)
	// PreparedStatement 인터페이스
	
	pstmt.setInt(1, idx);// 1번 인덱스(첫번째값) 만능문자에 int 타입 변수 idx 값 전달
	pstmt.setString(2, name);
	
	
	// 4단계, 실행 및 결과 처리
	int insertCount = pstmt.executeUpdate();
	
	%>
	<h3>완료 <%=insertCount %>개 </h3>
	
	
</body>
</html>