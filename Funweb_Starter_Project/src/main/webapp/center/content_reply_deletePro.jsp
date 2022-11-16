<%@page import="board.BoardReplyDAO"%>
<%@page import="board.BoardReplyDTO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//삭제 시 해당 board_type, ref_idx, 내용를 가져와서 이에 맞는 값을 삭제.

//댓글 번호(idx) , 게시물 번호 (ref_idx)
int idx = Integer.parseInt(request.getParameter("idx"));
//페이지 번호
String pageNum = request.getParameter("pageNum");
// System.out.println(pageNum);
if(pageNum == null){
	pageNum = request.getParameter("pageNum");
}

BoardReplyDTO reply = new BoardReplyDTO();
reply.setBoard_type(request.getParameter("board_type"));
reply.setRef_idx(Integer.parseInt(request.getParameter("ref_idx")));
reply.toString();
BoardReplyDAO dao = new BoardReplyDAO();
%>
<script>
	if(confirm("댓글을 삭제하시겠습니까?")){

		<%
		int deleteCount = dao.deleteReply(idx);

		if(deleteCount > 0){%>
		
		alert("삭제 되었습니다.");
		//삭제 한 후 이동할 때 해당 게시물 번호를 파라미터로 넘겨야 함.
		location.href ="<%=reply.getBoard_type()%>_content.jsp?idx=<%=reply.getRef_idx()%>&pageNum=<%=pageNum%>";
		<%}%>
	
	};
</script>



	
