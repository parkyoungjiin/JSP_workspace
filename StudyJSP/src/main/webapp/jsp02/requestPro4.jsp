<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>requestPro4.jsp - 로그인 처리</h1>
	<%
		String strId = request.getParameter("id");
		String strPwd = request.getParameter("password");
	%>
	
	<h3>아이디 : <%= strId%></h3>
	<h3>패스워드 : <%= strPwd%></h3>
	
	<%if (strId.equals("admin") && strPwd.equals("1234")){%>
		<script>
			alert("로그인 성공");
			location.href ="requestPro4_responseResult1.jsp"
		</script>
 	<% }else { %>
		<script>
			alert("로그인 실패");
			location.href ="requestPro4_responseResult2.jsp"
		</script>
 	<% }%>
	
	
	<%-- 내장객체 response를 사용하여 자바코드 동일한 작업 수행  --%>
	<%if (strId.equals("admin") && strPwd.equals("1234")){
		response.sendRedirect("requestPro4_responseResult1.jsp");
	}else{
		response.sendRedirect("requestPro4_responseResult2.jsp");
	}
	%>
	
		
</body>
</html>