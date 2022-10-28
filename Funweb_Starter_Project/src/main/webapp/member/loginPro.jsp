<%@page import="java.sql.ResultSet"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
MemberDAO dao = new MemberDAO();
String id = request.getParameter("id");
String pass = request.getParameter("pass");

//MemberDTO객체에 아이디, 패스워드 저장 가능 !
MemberDTO member = new MemberDTO();
member.setId(id);
member.setPass(pass);



boolean isLoginSuccess = dao.isRightUser(member);

if(isLoginSuccess ==true) {
	session.setAttribute("sId", id); //id, 저장할 값
	response.sendRedirect("../main/main.jsp");	
%>
	
	
<% }else{%>
<script>
	alert("로그인 실패");
	location.href = "login.jsp";
</script>
	
<%} %>

