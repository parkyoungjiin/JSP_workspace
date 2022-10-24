<%@page import="jsp09_jdbc_dao.Jsp8_2DAO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// URL 파라미터로 전달받은 아이디 가져와서 변수에 저장
String id = request.getParameter("id");
// out.println(id);

   Jsp8_2DAO dao = new Jsp8_2DAO();
   int count = dao.delete(id);

if(count > 0) {
   response.sendRedirect("select_jsp8_2.jsp");
} else {
   %>
   <script>
      alert("회원 삭제 실패!");
      history.back();
   </script>
   <%
}
%>












