<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>영역 객체의 속성 및 범위</h1>
	<%
	// 각 영역 객체에 속성값 저장 => setAttribute("String ")
	pageContext.setAttribute("pageValue", "pageContext value");
	request.setAttribute("requestValue", "request value");
	session.setAttribute("sessionValue", "session value");
	application.setAttribute("applicationValue", "application value");
	%>
	
	<h3>pageContext 객체 값 : <%=pageContext.getAttribute("pageValue")%></h3>
	<h3>request 객체 값 : <%=request.getAttribute("requestValue")%></h3>
	<h3>session 객체 값 : <%=session.getAttribute("sessionValue")%></h3>
	<h3>Application  객체 값 : <%=application.getAttribute("applicationValue") %></h3>
	
	<%
	//포워딩 방법 (applicationScopeTest2.jsp 파일로 이동)
// 	1. response.sendRedirect()
// 	response.sendRedirect("attributeScopeTest2.jsp");
	
// 	2. pageContext객체의 forward() 메서드를 호출 
	pageContext.forward("attributeScopeTest2.jsp");
	// pageContext 영역은 null값이 나오는데, page는 페이지 이동 시 객체가 제거되기 때문이다.
	// request는 요청에 따른 응답까지 객체가 유효하지만, 새로운 요청 발생 시 객체가 제거된다.
	// session 객체 : 세션 유지 조건까지 유효
	// application 객체 : 서버 유지 시까지 유효(서버 중지 시 객체 제거)
	
	%>
</body>
</html>