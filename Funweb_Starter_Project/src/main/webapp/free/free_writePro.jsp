<%@page import="board.freeDAO"%>
<%@page import="board.freeDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="javax.swing.plaf.multi.MultiMenuItemUI"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//post 방식 한글 처리
request.setCharacterEncoding("UTF-8");
freeDTO freeboard = new freeDTO(); 
//파일 처리를 위한 MultipartRequest 클래스

//1. 실제 경로

String upload = "/upload";
ServletContext context = request.getServletContext();
String realPath = context.getRealPath(upload);

//2. 파일 사이즈
int size = 10 * 1024 * 1024;

MultipartRequest multi = new MultipartRequest(request, realPath, size, "UTF-8", new DefaultFileRenamePolicy());
//3. write 창에서 파라미터를 가져옴.


//3-1 파일도 가져오는 작업
freeboard.setName(multi.getParameter("name"));
freeboard.setPass(multi.getParameter("pass"));
freeboard.setSubject(multi.getParameter("subject"));
freeboard.setContent(multi.getParameter("content"));

String fileElement = multi.getFileNames().nextElement().toString();
freeboard.setOriginal_file(multi.getOriginalFileName(fileElement));
freeboard.setReal_file(multi.getFilesystemName(fileElement));
System.out.println("원본 파일 : " + multi.getOriginalFileName(fileElement) + " 실제 업로드 파일 : " + multi.getFilesystemName(fileElement));


//dao 객체 insertBoard 메서드 호출하여 글쓰기 작업 수행 
freeDAO dao = new freeDAO();

int insertCount = dao.FreeBoardInsert(freeboard);

if(insertCount > 0){%>
	<script>
	alert("글쓰기 성공!");
	location.href = "free_board.jsp";
	</script>
<%}else{
	%>
	<script>
	alert("글쓰기 실패!");
	history.back();
	</script>
<%}%>