<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
int idx = Integer.parseInt(request.getParameter("idx"));
String pageNum = "1";
if(request.getParameter("pageNum") != null ){
	pageNum = request.getParameter("pageNum");
	
}

BoardDAO dao = new BoardDAO();

//조회수 증가 작업
dao.updateReadcount(idx);

//클릭했을 때 목록을 보여줌
BoardDTO board = dao.selectBoard(idx);

// board.setContent(board.getContent().replaceAll(System.getProperty("line.separator"), "<br>"));

//날짜 표시 형식 : 'xxxx-xx-xx xx:xx:xx" (연-월-일- 시:분:초) SimpleaDateFormat

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_content.jsp</title>
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
					<td> <%=board.getIdx() %></td>
					<td>글쓴이</td>
					<td><%=board.getName() %></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td><%=sdf.format(board.getDate()) %></td>
					<td>조회수 </td>
					<td><%=board.getReadcount() %></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><%=board.getSubject() %></td>
				</tr>
				<tr>
					<td height ="300" >내용</td>
					<td colspan="3"><%=board.getContent() %></td>
				</tr>
			</table>

			<div id="table_search">
				<input type="button" value="글수정" class="btn" onclick="location.href = 'notice_update.jsp?idx=<%=board.getIdx()%>&pageNum=<%=pageNum%>'"> 
				<input type="button" value="글삭제" class="btn" onclick="location.href = 'notice_delete.jsp?idx=<%=board.getIdx()%>&pageNum=<%=pageNum%>'"> 
				<input type="button" value="글목록" class="btn" onclick="location.href = 'notice.jsp?pageNum=<%=pageNum %>'">
			</div>

			<div class="clear"></div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


