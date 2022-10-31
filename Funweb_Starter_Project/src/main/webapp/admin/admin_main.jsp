<%@page import="java.util.List"%>
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
<script type="text/javascript">
	function confirmDelete(id){
		//confirm dialog 사용하여 확인 요청 
		let confirmDele = confirm(id + " 회원을 삭제하시겠습니까?");
		if(confirmDele){
			location.href = "../member/member_delete.jsp?id=" + id; // id도 같이 넘김. (웹페이지에)
		}else{
			alert("취소되었습니다")
		}
	
	}
</script>
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
	List<MemberDTO> memberList = dao.select_admin(); //DAO에서 list를 리턴하는데 이 값을 memberList에 저장.
	
// 	for(int i = 0 ; i<memberList.size(); i++){ //list 크기만큼 반복하여 DTO에 저장한 뒤 각각 출력하는 구문임.
// 		MemberDTO dto = memberList.get(i);
	
// 위 방법 대신에 향상된 for문을 사용 가능. (위 방법은 인덱스 사용이 필요할 때 사용.)
	for(MemberDTO dto : memberList){
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
		<td><input type="button" value ="상세정보" onclick="../member/member_info.jsp?id=<%=dto.getId()%>"></td>		
 		<td><input type="button" value ="삭제" onclick = "confirmDelete('<%=dto.getId()%>')"></td>
	</tr>
	<%}%>
</table>
</body>
</html>