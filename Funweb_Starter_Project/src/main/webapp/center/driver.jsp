<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="board.FileBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// DRIVER 페이지에서 목록 표시
request.setCharacterEncoding("UTF-8");
FileBoardDAO dao = new FileBoardDAO();

SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm:ss");

int listLimit = 10;

int pageNum = 1;

if(request.getParameter("pageNum") != null){
	pageNum = Integer.parseInt(request.getParameter("pageNum"));
}

System.out.println("pageNum : " + pageNum);

int startRow = (pageNum-1) * listLimit;


String keyword = request.getParameter("keyword");
if(keyword == null){
	keyword = "";
}
List<FileBoardDTO> fileList = dao.FileBoardSelect(startRow, listLimit, keyword);
System.out.println("keyword :" + keyword);
// List<FileBoardDTO> fileList = dao.FileBoardSelect(startRow, listLimit,ke);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/driver_download.jsp</title>
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
			<h1>Driver Download</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Write</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
				<%
				for(FileBoardDTO fileboard : fileList){%>
					
				<tr onclick="location.href ='driver_content.jsp?idx=<%=fileboard.getIdx()%>&pageNum=<%=pageNum%>'">
					<td><%=fileboard.getIdx() %></td>
					<td class="left"><%=fileboard.getSubject() %></td>
					<td><%=fileboard.getName() %></td>
					<td><%=sdf.format(fileboard.getDate()) %></td>
					<td><%=fileboard.getReadcount() %></td>
				</tr>
				<%}%>
				
			</table>
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn" onclick="location.href = 'driver_write.jsp'">
			</div>
			<div id="table_search">
				<form action="driver_jsp" method="post">
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


