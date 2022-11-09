<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="board.FileBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//패스워드 일치 시 업데이트 실행
// request.setCharacterEncoding("UTF-8");

//---------------------------파일 업로드 관련 처리 -----------------------------
String uploadPath = "/upload";

int fileSize = 10 * 1024 * 1024; // byte -> KB -> MB -> 10MB
ServletContext context = request.getServletContext();

String realPath = context.getRealPath(uploadPath);

MultipartRequest multi = new MultipartRequest(
	request,// 1) 실제 요청 정보가 포함된 객체
	realPath, // 2) 실제 업로드 되는 경로
	fileSize, // 3) 업로드 최대 크기
	"UTF-8", // 4)인코딩 방식 - request.setCharacterEncoding("UTF-8"); 이 구문 생략 가능
	new DefaultFileRenamePolicy() // 5) 이름 중복 시 
		
);

FileBoardDTO fileboard = new FileBoardDTO();
fileboard.setName(multi.getParameter("name"));
fileboard.setPass(multi.getParameter("pass"));
fileboard.setSubject(multi.getParameter("subject"));
fileboard.setContent(multi.getParameter("content"));
// System.out.println(pass);

//파일명을 관리하는 객체에 접근하여 파일명 목록 중 첫 번째 파일명 가져오기
String fileElement = multi.getFileNames().nextElement().toString();
//원본 파일 명 - 
out.println(fileElement); // 파일명을 담고 있는 속성 - name (파일명이 출력되지 않음.)
fileboard.setOriginal_file(multi.getOriginalFileName(fileElement));
fileboard.setReal_file(multi.getFilesystemName(fileElement));

// out.println("원본 파일명 : " + fileboard.getOriginal_file() + "실제 파일명  : " + fileboard.getReal_file());

int idx = Integer.parseInt(multi.getParameter("idx"));
fileboard.setIdx(idx);
String pageNum = multi.getParameter("pageNum");

//새 파일이 업로드 됬는지에 대한 변수
boolean isNewFile =false;
if(fileboard.getOriginal_file()==null){
	fileboard.setOriginal_file(multi.getParameter("old_original_file"));
	fileboard.setReal_file(multi.getParameter("old_real_file"));
}else{
	isNewFile = true;
}

System.out.println(fileboard);
// System.out.println(fileboard.getOriginal_file() + "," + fileboard.getReal_file());


// 글쓰기 작업 수행 


//비밀번호 일치 여부 판별


FileBoardDAO dao = new FileBoardDAO();


int updateCount = dao.FileBoardUpdate(fileboard);
//패스워드 일치 여부에 따른 작업
	
if(updateCount > 0) { // 수정 성공 시
		// 새 파일 업로드 여부 판별
	if(isNewFile) { // 새 파일 업로드 시
			// 기존 파일(old_real_file 값에 해당하는 파일) 삭제
	 		File f = new File(realPath, multi.getParameter("old_real_file"));
		
		if(f.exists()) {
				f.delete(); 
		}
	}
		// 글 상세보기 페이지로 이동(글번호, 페이지번호)
		response.sendRedirect("driver_content.jsp?idx=" + idx + "&pageNum=" + pageNum);
	} else {// 수정 실패 시
		// 실패한 게시물에 대한 업로드 한 파일 삭제
		 File f = new File(realPath, fileboard.getReal_file());
		
		if(f.exists()) {
			f.delete(); 
		}
		
		%> 
		<script>
			alert("글수정 실패!");
			history.back();
		</script>
		
	<%}%>
	

	

