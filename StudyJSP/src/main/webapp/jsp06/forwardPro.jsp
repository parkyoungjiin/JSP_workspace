<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>forwardPro.jsp </h1>
	<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String jumin = request.getParameter("jumin");
	
	//forward 액션 태그에 포함시켜 전달할 데이터를 변수에 저장
	int age = 25;
	%>
	<h3>아이디 : <%=id %></h3>
	<h3>패스워드 : <%=passwd %></h3>
	<h3>주민번호 : <%=jumin %></h3>
	<!-- forward 액션태그 사용 -->
<%-- 	<jsp:forward page="forwardPro2.jsp"/> --%>
	<!-- forward 액션태그로 포워딩 시 데이터를 추가해서 포워딩 작업 가능 -->
	
	<jsp:forward page="forwardPro2.jsp">
		<jsp:param name="paramValue1" value="forward 액션태그의 param 태그 데이터"/>
		<jsp:param name="paramValue2" value="<%=age %>"/>
	</jsp:forward>
</body>
</html>