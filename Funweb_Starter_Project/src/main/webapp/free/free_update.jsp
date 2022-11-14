<%@page import="board.freeDTO"%>
<%@page import="board.freeDAO"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
int idx = Integer.parseInt(request.getParameter("idx"));
String pageNum = request.getParameter("pageNum");

freeDAO dao = new freeDAO();
freeDTO freeboard = dao.FreeSelectContent(idx);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/free_update.jsp</title>
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
			<h1>free Update</h1>
			<form action="free_updatePro.jsp" method="post">
				<input type ="hidden" name ="idx" value ="<%=idx %>">
				<input type ="hidden" name ="pageNum" value ="<%=pageNum %>">
				<table id="notice">
					<tr>
						<td>글쓴이</td>
						<td><input type="text" name="name" value ="<%=freeboard.getName()%>"></td>
					</tr>
					<tr>
						<td>패스워드</td>
						<td><input type="text" name="pass"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" value ="<%=freeboard.getSubject()%>"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="10" cols="20" name="content" ><%=freeboard.getContent() %></textarea></td>
					</tr>
					<tr>
						<td>파일</td>
						<td>
						<input type="file" name="original_file" ><br>
						현재 파일 : <%=freeboard.getOriginal_file() %>
						</td>
					</tr>
				</table>

				<div id="table_search">
					<input type="submit" value="글수정" class="btn">
				</div>
			</form>
			<div class="clear"></div>
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


