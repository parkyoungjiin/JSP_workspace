<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>requestPro2.jsp - 로그인 처리</h1>
	<%
		String strId = request.getParameter("id");
		String strPwd = request.getParameter("password");
	%>
	
	<h3>아이디 : <%= strId%></h3>
	<h3>패스워드 : <%= strPwd%></h3>
	
	
<%-- 	<%if(strId == "admin" && strPwd == "1234"){%> --%>
		<%if(strId.equals("admin") && strPwd.equals("1234")){ %>
		<%
			//세션 객체 로그인 성공한 아이디를 "sId"라는 속성명으로 저장하기
			session.setAttribute("sId", strId);
			response.sendRedirect("sessionTest3_main.jsp");		
		} else {
			%>
			<script type="text/javascript">
			alert("로그인 실패")
			history.back();
			</script>
		<%
			} 
		%>
	
</body>
</html>