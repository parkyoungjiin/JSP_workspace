<%@page import="jsp09_jdbc_dao.Jsp8_2DAO"%>
<%@page import="jsp09_jdbc_dao.Jsp8_2DTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			location.href = "delete_jsp_8_2.jsp?id=" + id; // id도 같이 넘김. (웹페이지에)
		}else{
			alert("취소되었습니다")
		}
	
	}
</script>
</head>
<body>
	<%
	String id = (String)session.getAttribute("sId");
	if(id == null || id.equals("")){%>	

	<script type="text/javascript">
		alert("잘못된 접근입니다.");
		location.href ="index.jsp";
	</script>
	<%} %>
	<h1>회원가입 목록</h1>
		<table border ="1">
			<tr>
				<th width ="100">이름</th>
				<th width="100">아이디</th>
<!-- 				<th>주민번호</th> -->
				<th width="50">이메일</th>
<!-- 				<th>직업</th> -->
				<th width ="50">성별</th>
<!-- 				<th>직업</th> -->
<!-- 				<th>동기내용</th> -->
				<th width ="100">가입일</th>
				<th width ="100" colspan ="2">기타</th>
			</tr>
			
			<%
			//회원목록 조회를 위해 Jsp8_2DAO 객체 생성 후 select() 메서드 호출
			Jsp8_2DAO dao = new Jsp8_2DAO();
			
			ArrayList jspList = dao.select();
			
			//테이블 내 회원 목록 출력
			for(int i = 0; i <jspList.size(); i++){
				//타입이 Object이기에 업캐스팅 필요
				Jsp8_2DTO dto= (Jsp8_2DTO)jspList.get(i);	
			%>
			
			<tr>
				<td><%=dto.getName() %></td>
				<td><%=dto.getId() %></td>
<%-- 				<td><%=dto.getPasswd() %></td> --%>
<%-- 				<td><%=dto.getJumin() %></td> --%>
				<td><%=dto.getEmail() %></td>
<%-- 				<td><%=dto.getJob() %></td> --%>
				<td><%=dto.getGender() %></td>
<%-- 				<td><%=dto.getHobby() %></td> --%>
<%-- 				<td><%=dto.getContent() %></td> --%>
				<td><%=dto.getHire_date()%></td>
				<td><input type="button" value ="상세정보" onclick ="location.href='select_jsp8_2_detail.jsp?id=<%=dto.getId() %>'"></td>
				<td><input type="button" value ="삭제" onclick ="confirmDelete('<%=dto.getId() %>')"></td>
			</tr>
			<%}%>
		<tr><input type="button" value ="뒤로가기" onclick="history.back()"></tr>
		</table>
			
		
		
		
		
</body>
</html>