<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

//작성일자 표시 형식 변경을 위해 SimpleDateFormat 활용
// yy-MM-dd HH:mm

SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");


// board 테이블의 게시물 목록을 조회
//1. BoardDAO 객체의 selectListCount() 메서드를 통해 전체 게시물 수 조회(listcount)
BoardDAO dao = new BoardDAO();



// 2. 게시물 목록 조회
// List<BoardDTO>boardlist = dao.selectBoardList();



// System.out.println("총 게시물 수 : " + listcount);

//3.  페이징 처리를 위한 계산 작업
int listLimit = 10; // 한 페이지에서 표시할 게시물 목록을 10개로 제한

//3-1pageNum 파라미터를 사용하여 현재 페이지 번호 설정 // ?pageNum 으로 넘기
int pageNum = 1;
if(request.getParameter("pageNum") != null ){
	pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
}
System.out.println(pageNum);

// 3-2. 현재 페이지에서 목록으로 표시할 첫 게시물의 행 번호 
// => (현재 페이지 번호 -1) + 페이지 당 게시물 목록 개수

int startRow = (pageNum-1) * listLimit;
List<BoardDTO> boardlist = dao.selectBoardList(startRow, listLimit);




%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice.jsp</title>
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
			<h1>Notice</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Write</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
				<!-- 글 목록 반복 표시할 위치 -->
				
				
				<%//향상된 for문
				for(BoardDTO board : boardlist){%>
				<tr onclick="#'">
					<td><%=board.getIdx() %></td>
					<td class="left"><%=board.getSubject() %></td>
					<td><%=board.getName() %></td>
					<td><%=sdf.format(board.getDate()) %></td>
					<td><%=board.getReadcount() %></td>
				</tr>
				<%} %>
			</table>
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn" onclick="location.href='notice_write.jsp'">
			</div>
			<div id="table_search">
				<form action="#" method="post">
					<input type="text" name="search" class="input_box">
					<input type="submit" value="Search" class="btn">
				</form>
			</div>

			<div class="clear"></div>
			<div id="page_control">
			<%// 한 페이지에서 표시할 페이지 목록(번호) 갯수 계산
			int listcount = dao.selectListCount();
			
			//페이지 목록 개수 계산
			int pageListLimit = 3;
			
			//3. 전체 게시물 수를 페이지 당 게시물 목록 수로 나눈 나머지 Ex) 21개일 때 
// 			int maxPage = listcount / listLimit;
			
// 			if( listcount % listLimit > 0){
// 				maxPage++;
// 			}

			//삼항 연산자 사용한 것으로 위 코드와 동일함.
			int maxPage = listcount / listLimit + (listcount % listLimit ==0 ? 0 : 1);
			// 나머지가 0일 때 0, 나머지가 0이 아닐 때 1을 더한다 !
			
			
			System.out.println("전체 페이지 수 : " + maxPage);
			//4. 시작 페이지 번호 계산
			int startPage = (pageNum-1) / pageListLimit * pageListLimit + 1;
			//5. 끝 페이지
			int endPage = startPage + pageListLimit-1;
			
			%>
				<a href="#">Prev</a>
				
				
				<%
				for(int i = startPage ; i<endPage ; i++){%>
					<%if(pageNum ==i){%>
						<%=i %>
					<%}else{
						%>
					<a href="notice.jsp?pageNum=<%=i %>"></a>
					<%} %>}
					
				<% }%>
				
				<a href="#">Next</a>
				
				
				
				
		
			</div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


