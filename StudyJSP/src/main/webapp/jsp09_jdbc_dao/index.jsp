<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	header{
		width: 800px;
		height: 80px;
		text-align: right;
	}
	article{
		width: 1024px;
		height: 600px;
		text-align: center;
		border: 1px solid blue;
	}
	footer{
		text-align: center;
	}
</style>
</head>
<body>


	<%
	String id = (String)session.getAttribute("sId");
	%>
	<header>
		<%if(id == null || id.equals("")){%>
		<	h4><a href="loginForm2.jsp">로그인 | <a href="InsertForm_jsp8_2.jsp">회원가입</h4>	
		<%}else{ %>
		<h4>
			<a href="select_jsp8_2_detail.jsp?id=<%=id%>"><%=id %>님</a>| 
			<a href="logout.jsp">로그아웃</a> 
			<%if(id.equals("admin")){ %>
		 <%} %>
	 	</h4>	
		
		<%} %>
	
	
	</header>
	
	<article>
	<h1>index.jsp</h1>
	</article>
	
	<footer>
		<h5>아이티윌 부산교육센터 오시는 길</h5>
	</footer>
</body>
</html>