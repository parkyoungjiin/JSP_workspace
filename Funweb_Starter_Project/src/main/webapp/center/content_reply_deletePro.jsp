<%@page import="board.BoardReplyDAO"%>
<%@page import="board.BoardReplyDTO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//���� �� �ش� board_type, ref_idx, ���븦 �����ͼ� �̿� �´� ���� ����.

//��� ��ȣ(idx) , �Խù� ��ȣ (ref_idx)
int idx = Integer.parseInt(request.getParameter("idx"));
//������ ��ȣ
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
	if(confirm("����� �����Ͻðڽ��ϱ�?")){

		<%
		int deleteCount = dao.deleteReply(idx);

		if(deleteCount > 0){%>
		
		alert("���� �Ǿ����ϴ�.");
		//���� �� �� �̵��� �� �ش� �Խù� ��ȣ�� �Ķ���ͷ� �Ѱܾ� ��.
		location.href ="<%=reply.getBoard_type()%>_content.jsp?idx=<%=reply.getRef_idx()%>&pageNum=<%=pageNum%>";
		<%}%>
	
	};
</script>



	
