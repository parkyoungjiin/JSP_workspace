<%@page import="board.BoardReplyDAO"%>
<%@page import="board.BoardReplyDTO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//�Խñ� ��ȣ
// int ref_idx = Integer.parseInt(request.getParameter("ref_idx"));
// // Ÿ��
// String board_type = request.getParameter("board_type");
// // ����
// String content = request.getParameter("content");

// System.out.println(ref_idx + "," + board_type + ","+ content +"," + sId);



//�ѱ� ó��

request.setCharacterEncoding("UTF-8");

//������ ��ȣ ��������

String pageNum = request.getParameter("pageNum");
System.out.println(pageNum);
if(pageNum == null){
	pageNum = request.getParameter("pageNum");
}

//���� ���̵�
String sId = (String)session.getAttribute("sId");
//DTO ����
BoardReplyDTO reply = new BoardReplyDTO();
reply.setId(sId);
reply.setContent(request.getParameter("content"));
reply.setRef_idx(Integer.parseInt(request.getParameter("ref_idx")));//�Խñ� ��ȣ
reply.setBoard_type(request.getParameter("board_type"));
//���(Ȯ�ο�)
System.out.println(reply);	
//insert ���� ����
BoardReplyDAO dao = new BoardReplyDAO();
int insertCount = dao.insertReplyBoard(reply);

if(insertCount > 0){%>
<script>
alert("����� ��ϵǾ����ϴ�.");
// �Խñ� �̵� �κ� : xxx_content.jsp(xxx�� �Խ���Ÿ���� ����)
location.href = "<%=reply.getBoard_type()%>_content.jsp?idx=<%=reply.getRef_idx()%>&pageNum=<%=pageNum%>";
</script>	
<%}else{%>

<script>
alert("��Ͽ� �����߽��ϴ�.");
history.back();
</script>
<% }%>
