<%@page import="java.io.File"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

// request.setCharacterEncoding("UTF-8");

//  기존 일반 폼 파라미터를 가져오는 request.getParameter() 메서드 사용 불가능 !
// String name =request.getParameter("name");
// out.println(name); // 널값이 출력된다.

// ---------------------------파일 업로드 관련 처리 -----------------------------
// 1. webapp/upload 디렉토리 생성하여 이 곳에 업로드(경로설정)
String uploadPath = "/upload";

// 2. 파일 크기 정수형으로 지정
// 만약 업로드 가능 크기를 10MB 지정
int fileSize = 10 * 1024 * 1024; // byte -> KB -> MB -> 10MB

//3. 현재 프로젝트(서블릿)를 처리하는 객체 -> 서블릿 컨텍스트(Servlet Context)
// 이 서블릭 컨텍스트를 객체 형태로 가져오기
ServletContext context = request.getServletContext();

//4. 프로젝트 상의 가상 업로드 디렉토리에 대한 실제 업로드 디렉토리 알아내기
String realPath = context.getRealPath(uploadPath);
// out.println(realPath);

// D:\workspace_jsp5\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Funweb_Starter_Project\ upload

//5. MultipartRequest 객체 생성
// 파일 업로드가 포함된 게시물 작성 시 전달받은 파라미터는 request 객체를 통해 전달되지만 request.getParameter() 메서드는 안된다.
// 대신, MultipartRequest 객체의 getParameter() 메서드 호출하여 파라미터 가져올 수 있음.

MultipartRequest multi = new MultipartRequest(
	request,// 1) 실제 요청 정보가 포함된 객체
	realPath, // 2) 실제 업로드 되는 경로
	fileSize, // 3) 업로드 최대 크기
	"UTF-8", // 4)인코딩 방식 - request.setCharacterEncoding("UTF-8"); 이 구문 생략 가능
	new DefaultFileRenamePolicy() // 5) 이름 중복 시 
		
);

// 6. FileBoardDTO 객체 생성하여 업로드 파라미터 데이터 저장

FileBoardDTO fileboard = new FileBoardDTO();
fileboard.setName(multi.getParameter("name"));
fileboard.setPass(multi.getParameter("pass"));
fileboard.setSubject(multi.getParameter("subject"));
fileboard.setContent(multi.getParameter("content"));
// fileboard.setOriginal_file(multi.getParameter("original_file"));

//파일명을 관리하는 객체에 접근하여 파일명 목록 중 첫 번째 파일명 가져오기
String fileElement = multi.getFileNames().nextElement().toString();
//원본 파일 명 - 
out.println(fileElement); // 파일명을 담고 있는 속성 - name (파일명이 출력되지 않음.)
fileboard.setOriginal_file(multi.getOriginalFileName(fileElement));
fileboard.setReal_file(multi.getFilesystemName(fileElement));
out.println(fileboard);
out.println("원본 파일명 : " + fileboard.getOriginal_file() + "실제 파일명  : " + fileboard.getReal_file());

// 글쓰기 작업 수행 


FileBoardDAO dao = new FileBoardDAO();
int insertCount = dao.FileBoardInsert(fileboard);

if(insertCount > 0){%>
	<script>
	alert("등록에 성공했습니다.");
	location.href = "driver.jsp";
	</script>	
<%}else{
	File f = new File(realPath, fileboard.getReal_file()); 
	
	if(f.exists()){
		f.delete();
	}
%>

	<script>
	alert("등록에 실패했습니다.");
	history.back();
	</script>
<%} %>


%>