<%@page import="jsp09_jdbc_dao.Jsp8_2DAO"%>
<%@page import="jsp09_jdbc_dao.Jsp8_2DTO"%>
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
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String passwd = request.getParameter("password");
	Jsp8_2DAO dao = new Jsp8_2DAO(); 
	
	boolean isLoginSuccess = dao.login(id, passwd);
	if(isLoginSuccess == true){
		response.sendRedirect("index.jsp");
	}else{
	%>
	<script type="text/javascript">
	alert("로그인 실패")	
	history.back();	
	</script>
<% }%>	

</body>
</html>