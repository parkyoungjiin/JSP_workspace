<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// login에서 id, password가 같으면 로그인 하도록 함.
MemberDTO member = new MemberDTO();
MemberDAO dao = new MemberDAO();

//login.jsp 파일에서 가져온 id, pass 값을 DTO에 저장
String id = request.getParameter("id");
String pass = request.getParameter("pass");

member.setId(id);
member.setPass(pass);

boolean isRightUser = dao.isRightUser(id, pass);
if(isRightUser){
	session.setAttribute("sId", id);
	response.sendRedirect("../main/main.jsp");
}else{%>
	<script>
	alert("로그인에 실패했습니다.");
	history.back();
	</script>
<%} %>





