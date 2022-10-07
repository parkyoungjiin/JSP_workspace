<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// sid라는 속성값을 가져와서 String 타입 변수 id에 저장 (이 때 session은 오브젝트로 부모 타입이기에 다운캐스팅 오류)
	String id = (String)session.getAttribute("sId"); 
// 	String id = session.getAttribute("sId").toString(); //Object의 메서드인 toString을 사용한 예시
	out.println(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align="right">
		<h5>
		<%if(id == null){ %>
			<a href = "sessionTest3_loginForm.jsp">로그인</a>
			<a href = "sessionTest3_joinForm.jsp">회원가입</a>
		<%}else{ %>
			<%=id %> 님 | <a href = "sessionTest3_logout.jsp">로그아웃</a>
		<%} %>
		</h5>
	
	</div>
	<h1>메인화면</h1>
	
</body>
</html>