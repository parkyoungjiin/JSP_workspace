<%@page import="java.io.File"%>
<%@page import="java.util.function.Function"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%


int idx = Integer.parseInt(request.getParameter("idx"));
String pageNum = request.getParameter("pageNum");
String pass = request.getParameter("pass");

FileBoardDAO dao = new FileBoardDAO();

int deleteCount = dao.FileBoardDelete(idx, pass);

if(deleteCount > 0 ){%>
<%
// ----------------파일삭제---------------------
// 경로 구분자를 직접 지정하는 대신, separator 
String uploadPath = File.separator + "upload";

String realPath = request.getServletContext().getRealPath(uploadPath).toString();

// File f = new File(realPath, ); 

%>
	<script>
	alert("삭제되었습니다.")
	locaton.href = "driver.jsp";
	</script>

<%}else{%>
	<script>
	alert("삭제에 실패했습니다.")
	history.back();
	</script>
<%} %>

