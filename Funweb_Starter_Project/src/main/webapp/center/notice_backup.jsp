<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
	
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
//------------------------------------------------------------------------------------
// pageNum(페이지번호)  listLimit(게시물 수)    startRow(시작행번호)   endRow(끝행번호)
// ------------------------------------------------------------------------------------
//         1                    10              (1 - 1) * 10 =  0행        (~ 9행)
//         2                    10              (2 - 1) * 10 = 10행       (~ 19행)
//         3                    10              (3 - 1) * 10 = 20행       (~ 29행)
// => (현재 페이지 번호 -1) + 페이지 당 게시물 목록 개수

int startRow = (pageNum-1) * listLimit;
List<BoardDTO> boardlist = dao.selectBoardList(startRow, listLimit);




%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice.jsp</title>
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
				<tr onclick="location.href='notice_content.jsp?idx=<%=board.getIdx()%>&pageNum=<%=pageNum %>'">
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
				<form action="notice_search.jsp" method="get">
					<input type="text" name="keyword" class="input_box">
					<input type="submit" value="Search" class="btn">
				</form>
			</div>

			<div class="clear"></div>
			<div id="page_control">
			<%// 한 페이지에서 표시할 페이지 목록(번호) 갯수 계산
			int listcount = dao.selectListCount(); //전체 게시물 개수 
			
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
			//listcount 가 총 게시물 개수, listLimit는 한 페이지에 나타낼 때 제한 개수
			// 만약 나눴을 때 0이 아니면 다음 페이지가 필요함.
			// 예를 들어, 21개일 때 limit가 10이기에 나머지가 1인데, 이 떄 기존에는 1페이지였지만
			// 삼항연산자 계산을 통해서 + 1 이되어 maxPage가 1증가하여 2페이지가 된다.
			
			System.out.println("전체 페이지 수 : " + maxPage);
			//4. 시작 페이지 번호 계산
			int startPage = (pageNum-1) / pageListLimit * pageListLimit + 1;
			//5. 끝 페이지
			int endPage = startPage + pageListLimit-1;
			
			%>
				<!--  현재 페이지가 1보다 클 경우 -1값, 아니면 링크 동작을 제거 -->
				<%
					if(pageNum > 1){%>
						<a href="notice.jsp?pageNum=<%=pageNum -1%>">Prev</a>
					<%}else{ %>
						<a href="javascript:void(0)">Prev</a>
					<% }%>
				
				
				<%
				for(int i = startPage ; i < endPage ; i++){%>
					<%if(pageNum ==i){%>
						<a href="javascript:void(0)"><%=i %></a>
					<%}else{
						%>
						<a href="notice.jsp?pageNum=<%=i%>"><%=i %></a>
					<%} %>
					
				<% }%>
				
				
				<!--  next(현재페이지번호 + 1) 의 경우는 현재 페이지가 마지막 페이지일 때 링크 동작을 제거 -->
				<%
				if(pageNum < maxPage  ){// next는 마지막 페이지보다 작을 때까지 동작%> 
					<a href="notice.jsp?pageNum=<%=pageNum + 1%>">Next</a>
				<%}else{%>
					<a href="javascript:void(0)">Next</a>
				<%} %>
				
				
				
				
		
			</div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


