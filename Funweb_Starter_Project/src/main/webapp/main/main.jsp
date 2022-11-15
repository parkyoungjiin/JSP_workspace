<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="board.FileBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main/main.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->
		  
		<div class="clear"></div>   
		<!-- 본문들어가는 곳 -->
		<!-- 메인 이미지 -->
		<div id="main_img"><img src="../images/main_img.jpg"></div>
		<!-- 본문 내용 -->
		<article id="front">
		  	<div id="solution">
		  		<div id="hosting">
		  			<h3>Web Hosting Solution</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		  		</div>
		  		<div id="security">
		  		  	<h3>Web Security Solution</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		  		</div>
		  		<div id="payment">
		  			<h3>Web Payment Solution</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		  		</div>
		  	</div>
		  	<div class="clear"></div>
			<div id="sec_news">
				<h3><span class="brown">File board</span></h3>
				<table>
				
				<%
				SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
				FileBoardDAO dao = new FileBoardDAO();
				
				//selectRecentBoardList(); -> 파라미터 X (5개로 고정할 거기 때문) / 리턴타입 : List<DTO>
				
				List<FileBoardDTO> recentList = dao.selectRecentBoardList();
				for(FileBoardDTO fileboard : recentList){%>
				<tr>
					<td class=td.td_title><a href ="../center/driver_content.jsp?idx=<%=fileboard.getIdx()%>"><%=fileboard.getSubject() %></a></td>
<%-- 					<td><%=fileboard.getName() %></td> --%>
					<td><%=sdf.format(fileboard.getDate())%></td>
				</tr>
				
				<% }%>
				
				</table>
			</div>
		
			<div id="news_notice">
		  		<h3 class="brown">Notice board</h3>
				<table>
					<tr>
						<td></td>
						<td></td>
					</tr>
				
				</table>
				
		  	</div>
	  	</article>
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


