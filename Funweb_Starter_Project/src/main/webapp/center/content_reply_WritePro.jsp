<%@page import="board.BoardReplyDAO"%>
<%@page import="board.BoardReplyDTO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//게시글 번호
// int ref_idx = Integer.parseInt(request.getParameter("ref_idx"));
// // 타입
// String board_type = request.getParameter("board_type");
// // 내용
// String content = request.getParameter("content");

// System.out.println(ref_idx + "," + board_type + ","+ content +"," + sId);



//한글 처리

request.setCharacterEncoding("UTF-8");

//페이지 번호 가져오기

String pageNum = request.getParameter("pageNum");
System.out.println(pageNum);
if(pageNum == null){
	pageNum = request.getParameter("pageNum");
}

//세션 아이디
String sId = (String)session.getAttribute("sId");
//DTO 생성
BoardReplyDTO reply = new BoardReplyDTO();
reply.setId(sId);
reply.setContent(request.getParameter("content"));
reply.setRef_idx(Integer.parseInt(request.getParameter("ref_idx")));//게시글 번호
reply.setBoard_type(request.getParameter("board_type"));
//출력(확인용)
System.out.println(reply);	
//insert 구문 실행
BoardReplyDAO dao = new BoardReplyDAO();
int insertCount = dao.insertReplyBoard(reply);

if(insertCount > 0){%>
<script>
alert("댓글이 등록되었습니다.");
// 게시글 이동 부분 : xxx_content.jsp(xxx는 게시판타입을 결합)
location.href = "<%=reply.getBoard_type()%>_content.jsp?idx=<%=reply.getRef_idx()%>&pageNum=<%=pageNum%>";
</script>	
<%}else{%>

<script>
alert("등록에 실패했습니다.");
history.back();
</script>
<% }%>
