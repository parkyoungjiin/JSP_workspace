<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// URL 파라미터로 전달받은 아이디 가져와서 변수에 저장
String id = request.getParameter("id");
String sId = (String)session.getAttribute("sId");
// out.println(id);
	MemberDAO dao = new MemberDAO();
	
   int deleteCount = dao.deleteMember(id);
   
   //삭제성공- > (1. 세션 아이디가 admin일경우 2. 회원이 탈퇴했을 경우)
   if(sId == null | sId.equals("") || id == null || !sId.equals(id) && !sId.equals("admin")){%>
	<script>
	alert("잘못된 접근입니다.");
	location.href = "../main/main.jsp";
	</script>
<%} 
// admin일 때 -> admin_main.jsp로
// 아닐경우 -> 세션 초기화 후에 main.jsp로

if(deleteCount > 0) {
	if(sId.equals("admin")){
		response.sendRedirect("../admin/admin_main.jsp");
	}else {
		session.invalidate();		
		response.sendRedirect("../main/main.jsp");
	}
} else {
   %>
   <script>
      alert("회원 삭제 실패!");
      history.back();
   </script>
 <%
}
%>












