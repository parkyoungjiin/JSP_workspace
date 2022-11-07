<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
int idx = Integer.parseInt(request.getParameter("idx"));
String pageNum = request.getParameter("pageNum");

// DTO에 저장
BoardDTO board = new BoardDTO();
board.setIdx(Integer.parseInt(request.getParameter("idx")));
board.setName(request.getParameter("name"));
board.setPass(request.getParameter("pass"));
board.setSubject(request.getParameter("subject"));
board.setContent(request.getParameter("content"));

System.out.println(board.toString());

// DAO 생성 
BoardDAO dao = new BoardDAO();
// 업데이트 성공하면 상세 조회 페이지(notice_content.jsp)
// 실패 시 이전 페이지 

int updateCount = dao.updateBoard(board);
%>
<%if(updateCount > 0){
	response.sendRedirect("notice_content.jsp?idx=" + idx + "&pageNum=" + pageNum);
%>
<%}else {%>
	<script>
	alert("글 수정 실패!");
	history.back();
	</script>
<%} %>



