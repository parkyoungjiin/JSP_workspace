<%@page import="java.sql.ResultSet"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
MemberDTO dto = new MemberDTO();
MemberDAO dao = new MemberDAO();
String id = request.getParameter("id");
String pass = request.getParameter("pass");

boolean isLoginSuccess = dao.login(id, pass);

if(isLoginSuccess ==true) {
	session.setAttribute("sId", id);
	response.sendRedirect("../main/main.jsp");	
%>
	
	
<% }else{%>
<script>
	alert("로그인 실패");
	location.href = "login.jsp";
</script>
	
<%} %>

