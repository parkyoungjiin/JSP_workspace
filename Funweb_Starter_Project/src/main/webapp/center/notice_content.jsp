<%@page import="java.text.Format"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardReplyDTO"%>
<%@page import="board.BoardReplyDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
	
<%

// String sId = (String)session.getAttribute("sId");
//변수 idx => 게시글 번호
int ref_idx = Integer.parseInt(request.getParameter("idx"));
// String pageNum = "1";

// if(request.getParameter("pageNum") != null ){
// 	pageNum = request.getParameter("pageNum");
	
// }

BoardDAO dao = new BoardDAO();

//조회수 증가 작업
dao.updateReadcount(ref_idx);

//클릭했을 때 목록을 보여줌
BoardDTO board = dao.selectBoard(ref_idx);

// board.setContent(board.getContent().replaceAll(System.getProperty("line.separator"), "<br>"));

//날짜 표시 형식 : 'xxxx-xx-xx xx:xx:xx" (연-월-일- 시:분:초) SimpleaDateFormat

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

String board_type = "notice";

//-------------------JSTL, EL을 사용하여 BoardDTO 객체를 출력---------------
pageContext.setAttribute("board", board);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_content.jsp</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Kaushan+Script&family=Neucha&display=swap" rel="stylesheet">
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
			<h1>Notice Content</h1>
			<table id="notice">
				<tr>
					<td>글번호</td>
					<td> ${board.idx }</td>
					<td>글쓴이</td>
					<td>${board.name }</td>
				</tr>
				<tr>
					<td>작성일</td>
					<td>${board.date }</td>
					<td>조회수 </td>
					<td>${board.readcount }</td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3">${board.subject }</td>
				</tr>
				<tr>
					<td height ="300" >내용</td>
					<td colspan="3">${boardz.content }</td>
				</tr>
			</table>

			<div id="table_search">
				<c:if test="${not empty sessionScope.sId and sessionScope.sId eq 'admin'}">
					<input type="button" value="글수정" class="btn" onclick="location.href = 'notice_update.jsp?idx=${param.idx }&pageNum=${param.pageNum }'"> 
					<input type="button" value="글삭제" class="btn" onclick="location.href = 'notice_delete.jsp?idx=${param.idx }&pageNum=${param.pageNum }'"> 
				
				</c:if>
					<input type="button" value="글목록" class="btn" onclick="location.href = 'notice.jsp?pageNum=${param.pageNum }'">
			</div>

			<div class="clear"></div>
			
			<div id = "replyArea">
				<!-- 댓글 작성 영역 (글번호, 게시판타입, 아이디) ** 세션 아이디가 있을 때만 보여지도록 **-->
				<c:if test="${not empty sessionScope.sId }">
				<div id = "insertForm">
					<form action="content_reply_WritePro.jsp" method="post">
						<input type="hidden" name = "ref_idx" value = "<%=ref_idx%>">
						<input type="hidden" name = "pageNum" value = "${param.pageNum }">
						<input type="hidden" name = "board_type" value = "<%=board_type%>">
						<textarea rows="3" cols="40" name = "content"></textarea>
						<input type="submit" value = "등록">
					</form>
				</div>			
				
				</c:if>
				
				<!-- 댓글 표시 영역 -->
				<div id = "replyViewArea">
					<table>
						<tr>
							<th>삭제</th>
							<th>내용</th>
							<th>작성자</th>
							<th>날짜</th>
						</tr>
						<%
						int startRow = 0;
						int listLimit = 5;
						
						
						BoardReplyDAO dao2 = new BoardReplyDAO(); 
						List<BoardReplyDTO> replyList = dao2.getReplyList(ref_idx, board_type, startRow, listLimit);
						
		

						
						for(BoardReplyDTO reply : replyList){%>
						<tr>
							<td><img src="../images/delete.png" width="15px" height="15px" 
							onclick="location.href='content_reply_deletePro.jsp?idx=${param.idx }&pageNum=${param.pageNum }&board_type=<%=reply.getBoard_type()%>&ref_idx=<%=ref_idx%>'"></td>
							<td><%=reply.getContent() %></td>							
							<td><%=reply.getId()%></td>							
							<td><%=sdf.format(reply.getDate()) %></td>							
						</tr>
							
						<%}%>
					</table>
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


