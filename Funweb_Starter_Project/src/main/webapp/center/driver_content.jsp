<%@page import="java.util.List"%>
<%@page import="board.BoardReplyDTO"%>
<%@page import="board.BoardReplyDAO"%>
<%@page import="com.mysql.cj.result.Field"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//idx는 게시글 번호 !
int idx = Integer.parseInt(request.getParameter("idx"));
String pageNum = "1";
if(request.getParameter("pageNum") != null ){
	pageNum = request.getParameter("pageNum");
	
}

FileBoardDAO dao = new FileBoardDAO();

FileBoardDTO fileboard = dao.selectContent(idx);

String board_type = "driver";



%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/driver_content.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"></div>
		<!-- 왼쪽 메뉴 -->
		<jsp:include page="../inc/left.jsp" />
		<!-- 본문 내용 -->

		<article>
			<h1>Driver Content</h1>
			<table id="notice">
				<tr>
					<td>글번호</td>
					<td><%=fileboard.getIdx() %> </td>
					<td>글쓴이</td>
					<td><%=fileboard.getName() %></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td><%=fileboard.getDate() %></td>
					<td>조회수 </td>
					<td><%=fileboard.getReadcount() %></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><%=fileboard.getSubject() %></td>
				</tr>
				<tr>
					<td>파일</td>
					<td colspan="3">
					<a href ="../upload/<%=fileboard.getReal_file()%>" download ="<%=fileboard.getOriginal_file() %>"><%=fileboard.getOriginal_file() %></a>
					
					</td>
				</tr>
				<tr>
					<td height ="300" >내용</td>
					<td colspan="3"><%=fileboard.getContent() %></td>
				</tr>
			</table>
			<%if(session.getAttribute("sId") != null) {%>
			<div id="table_search">
				<input type="button" value="글수정" class="btn" onclick="location.href = 'driver_update.jsp?idx=<%=fileboard.getIdx()%>&pageNum=<%=pageNum%>'"> 
				<input type="button" value="글삭제" class="btn" onclick="location.href = 'driver_delete.jsp?idx=<%=fileboard.getIdx()%>&pageNum=<%=pageNum%>'"> 
			<%}%>	
				<input type="button" value="글목록" class="btn" onclick="location.href = 'driver.jsp'">
			</div>

			<div class="clear"></div>
			
			<div id = "replyArea">
				<!-- 댓글 작성 영역 (글번호, 게시판타입, 아이디) ** 세션 아이디가 있을 때만 보여지도록 **-->
				<%
				if(session.getAttribute("sId") != null){%>
					
				<div id = "insertForm">
					<form action="content_reply_WritePro.jsp" method="post">
						<input type="hidden" name = "ref_idx" value = "<%=idx%>">
						<input type="hidden" name = "pageNum" value = "<%=pageNum%>">
						<input type="hidden" name = "board_type" value = "<%=board_type%>">
						<textarea rows="3" cols="40" name = "content" id = "replyTextarea"></textarea>
						<input type="submit" value = "등록" id = "replySubmit">
					</form>
				</div>			
				<%}%>
				<!-- 댓글 표시 영역 -->
				<div id = "replyViewArea">
				<%
				int startRow = 0;
				int listLimit = 5;
				BoardReplyDAO dao2 = new BoardReplyDAO();
				
				List<BoardReplyDTO> replyList = dao2.getReplyList(idx, board_type, startRow, listLimit);
				
				for(BoardReplyDTO reply : replyList){
					%>
					<img src="../images/delete.png" width="15px" height="15px">
					<span id = "replyContent"><%=reply.getContent() %></span>
					<span id = "replyId"><%=reply.getId() %></span>
					<span id = "replyDate"><%=reply.getDate() %></span>
				<% }%>
				
				</div>
				
				<!-- 댓글 페이지 표시 영역 -->
				<div id = "">
				
				</div>
			</div>
						
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


