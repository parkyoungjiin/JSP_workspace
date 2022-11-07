<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int idx = Integer.parseInt(request.getParameter("idx"));
String pageNum = request.getParameter("pageNum");
BoardDAO dao = new BoardDAO();
//파라미터 : 글번호, 패스워드  , 리턴타입 : int

String pass = request.getParameter("pass");
BoardDTO board = new BoardDTO();

	int deleteCount = dao.deleteBoard(idx, pass);
	
	if(deleteCount > 0) {
		response.sendRedirect("notice.jsp?pageNum=" + pageNum);
	} else {
		%>
		<script>
			alert("글삭제 실패!");
			history.back();
		</script>
		<%
	}
	%>
	
	
<!-- //  	if(deleteCount > 0){ -->
<!--  	%> -->
<!-- 		<script> -->
<%-- 		location.href = "notice.jsp?idx=<%=board.getIdx()%>&pageNum<%=pageNum%>"; --%>
<!-- 		</script> -->
<%-- 	<%}else{%> --%>
		<script>
// 		alert("삭제에 실패했습니다.");
// 		history.back();
<!-- 		</script> -->
<%-- 	<%}%> --%>
	
<!-- //삭제 결과 판별 -->
<!-- //성공 시 글 목록 페이지(notice.jsp)로 이동하고 (=> 파라미터로 번호 전달 가능) -->
<!-- // 아니면(실패 시) -->
