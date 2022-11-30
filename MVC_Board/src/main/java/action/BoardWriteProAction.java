package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.BoardWriteProService;
import vo.ActionForward;
import vo.BoardBean;
//WritePro 파일과 동일한 작업을 할 것.
public class BoardWriteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("BoardWriteProAction");
		ActionForward forward = null;
		
		
		
		
		
		try {
			String uploadPath = "upload"; // 업로드 가상 디렉토리(이클립스가 관리)
			String realPath = request.getServletContext().getRealPath(uploadPath);// 업로드 실제 디렉토리(톰캣)
			System.out.println("실제 업로드 경로 : " + realPath);
			int filesize = 1024 * 1024 * 10;
			
//		----------------클라이언트(작성자) IP 주소를 얻어와야 할 경우 ----------------------
			String writerIpAddr = request.getRemoteAddr();
			System.out.println("작성자 IP주소 : " + writerIpAddr);
			
//		-----------파일 업로드 처리-----------------
			MultipartRequest multi = new MultipartRequest(
					request, 
					realPath,
					filesize,
					"UTF-8",
					new DefaultFileRenamePolicy()
			);
			
			//전달받은 파라미터 데이터를 BoardBean 클래스 인스턴스 생성 후 저장
			BoardBean vo = new BoardBean();
			vo.setBoard_name(multi.getParameter("board_name"));
			vo.setBoard_pass(multi.getParameter("board_pass"));
			vo.setBoard_subject(multi.getParameter("board_subject"));
			vo.setBoard_content(multi.getParameter("board_content"));
			vo.setBoard_file(multi.getOriginalFileName("board_file"));
			vo.setBoard_real_file(multi.getFilesystemName("board_file"));
			System.out.println(vo);
			
			//-----------------------
			// BoardWriteProService 클래스 호출
			// registBoard() 메서드 호출하여 글쓰기 작업 요청
			// 파라미터 : BoardBean 객체 , 리턴타입 : boolean (isWriteSuccess성공했는가 실패했는가)
			
			BoardWriteProService service = new BoardWriteProService();
			boolean isWriteSuccess = service.registBoard(vo);
			
			// 성공, 실패에 따른 결과
			if(!isWriteSuccess) { // 실패 시
				//웹 브라우저로 HTML 태그 등을 내보내기(출력) 위한 작업 수행
				response.setContentType("text/html; charset=UTF-8");
				
				PrintWriter out = response.getWriter();
				
				out.println("<script>");		
				out.println("alert('글쓰기 실패')");
				out.println("history.back()");
				out.println("</script>");		
				
			}else { // 성공 시 
				// 포워딩 정보 저장을 위한 ActionForward 생성
				forward = new ActionForward();
				forward.setPath("BoardList.bo");
				forward.setRedirect(true);
			}
			
			
			
			//파일 명은 단순처리 불가능
			
			
			//파라미터명이 다른 복수개의 파일이 전달될 경우 복수개의 파라미터 처리 방법
//			// 1) 파일에 대한 파라미터명을 관리하는 객체(Enumeration) 가져오기
//			Enumeration e = multi.getFileNames();
//			// 2) while문을 활용하여 Enumeration 객체 hasMoreElements() 메서드가
//			// true일 동안 반복( 다음 요소가 존재할 동안 반복)
//
//			while(e.hasMoreElements()) {
//				// 3) nextElement() 메서드 호출하여 다음 요소(파라미터 이름) 가져오기 (Object 리턴타입이기에 문자열로 변환)
//				String fileElement = e.nextElement().toString();
//				System.out.println("원본 파일명 :" + multi.getOriginalFileName("board_file"));
//				System.out.println("실제 파일명 :" + multi.getFilesystemName("board_file"));
//
//				
//			}
			
			
//			System.out.println(vo.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		return forward; //이 파일에서 이동하는 것이 아니라 forward 정보를 리턴하여 컨트롤러에서 이동.
	}

}
