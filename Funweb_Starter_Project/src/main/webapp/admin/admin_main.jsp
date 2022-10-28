<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//관리자가 맞는지 재확인
String id = (String)session.getAttribute("sId");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%if(id == null | !id.equals("admin")){
	%>
	<script>
	alert("잘못된 접근입니다!");
	location.href = "../main/main.jsp";
	</script>
<% }%>

<h1>관리자 페이지 admin_main.jsp</h1>
<!-- 전체회원 목록 표시 select_jsp8_2 파일참조 / 상세정보(detail)와 삭제 버튼도 같이 만들기 -->

<table border ="1">
	<tr>
		<th>id</th>
		<th>pass</th>
		<th>name</th>
		<th>email</th>
		<th>mobile</th>
		<th>post_code</th>
		<th>address1</th>
		<th>address2</th>
		<th>phone</th>
		<th>date</th>
		<th colspan="2">기타</th>
	</tr>
	<%
	MemberDAO dao = new MemberDAO();
	ArrayList memberList = dao.select_admin();
	
	for(int i = 0 ; i<memberList.size(); i++){
		MemberDTO dto = (MemberDTO)memberList.get(i);
		%>
	
	
	<tr>
		<td><%=dto.getId() %></td>
		<td><%=dto.getPass() %></td>
		<td><%=dto.getName() %></td>
		<td><%=dto.getEmail() %></td>
		<td><%=dto.getMobile() %></td>
		<td><%=dto.getPost_code() %></td>
		<td><%=dto.getAddress1() %></td>
		<td><%=dto.getAddress2() %></td>
		<td><%=dto.getPhone() %></td>
		<td><%=dto.getDate() %></td>
		<td><input type="button" value ="삭제" onclick = "delete.jsp"></td>
		<td><input type="button" value ="상세정보" onclick = "detail.jsp"></td>
	</tr>
	<%} %>
</table>


</body>
</html>