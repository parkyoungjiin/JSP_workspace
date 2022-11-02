<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//post 방식 한글 처ㅣ리
request.setCharacterEncoding("UTF-8");
BoardDTO board = new BoardDTO();

board.setName(request.getParameter("name"));
board.setPass(request.getParameter("pass"));
board.setSubject(request.getParameter("subject"));
board.setContent(request.getParameter("content"));

out.println(board.toString());
System.out.println(board.toString());

//dao 객체 insertBoard 메서드 호출하여 글쓰기 작업 수행 

BoardDAO dao = new BoardDAO();
int insertCount = dao.insertBoard(board);

if(insertCount > 0){
	response.sendRedirect("notice.jsp");
}else{
	%>
	<script>
	alert("글쓰기 실패!");
	history.back();
	</script>
<%}%>