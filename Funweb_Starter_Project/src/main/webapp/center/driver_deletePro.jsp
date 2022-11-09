<%@page import="java.io.File"%>
<%@page import="java.util.function.Function"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

//파라미터 값 가져오기
int idx = Integer.parseInt(request.getParameter("idx"));
String pageNum = request.getParameter("pageNum");
String pass = request.getParameter("pass");
//DAO 생성
FileBoardDAO dao = new FileBoardDAO();
// 삭제 전에 파일명 가져옴.
String realFile = dao.selectRealFile(idx);
System.out.println("realFile: " + realFile);
//삭제 시행
int deleteCount = dao.FileBoardDelete(idx, pass);

if(deleteCount > 0 ){%>
<%
// ----------------파일삭제---------------------
// 경로 구분자를 직접 지정하는 대신, separator


String uploadPath = File.separator + "upload";

String realPath = request.getServletContext().getRealPath(uploadPath).toString();

File f = new File(realPath, realFile); 

if(f.exists()){
	boolean isFileDeleteSuccess = f.delete();
	System.out.println("파일 삭제 결과!");
}

%>
	<script>
	alert("삭제 되었습니다.");
	location.href="driver.jsp?pageNum=<%=pageNum%>";
	</script>

<%}else{%>
	<script>
	alert("삭제에 실패했습니다.");
	history.back();
	</script>
<%} %>

