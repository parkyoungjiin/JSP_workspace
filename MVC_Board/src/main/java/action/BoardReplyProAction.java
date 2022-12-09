package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.BoardReplyProService;
import svc.BoardWriteProService;
import vo.ActionForward;
import vo.BoardBean;

public class BoardReplyProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		try {
			String uploadPath = "upload"; // 업로드 가상 디렉토리(이클립스가 관리)
			String realPath = request.getServletContext().getRealPath(uploadPath);// 업로드 실제 디렉토리(톰캣)
			System.out.println("실제 업로드 경로 : " + realPath);
			int filesize = 1024 * 1024 * 10;
			
//		-----------파일 업로드 처리-----------------
			MultipartRequest multi = new MultipartRequest(
					request, 
					realPath,
					filesize,
					"UTF-8",
					new DefaultFileRenamePolicy()
			);
			
			//전달받은 파라미터 데이터를 BoardBean 클래스 인스턴스 생성 후 저장
			BoardBean board = new BoardBean();
			board.setBoard_num(Integer.parseInt(multi.getParameter("board_num")));
			board.setBoard_name(multi.getParameter("board_name"));
			board.setBoard_pass(multi.getParameter("board_pass"));
			board.setBoard_subject(multi.getParameter("board_subject"));
			board.setBoard_content(multi.getParameter("board_content"));
			board.setBoard_file(multi.getOriginalFileName("board_file"));
			board.setBoard_real_file(multi.getFilesystemName("board_file"));
			//입력받지 않고 hidden 속성으로 전달한 값도 저장해야 함.
			board.setBoard_re_ref(Integer.parseInt(multi.getParameter("board_re_ref")));
			board.setBoard_re_lev(Integer.parseInt(multi.getParameter("board_re_lev")));
			board.setBoard_re_seq(Integer.parseInt(multi.getParameter("board_re_seq")));
			System.out.println(board);
			
			//만약 파일명이 null 일 경우 널스트링으로 교체 (답글은 파일업로드가 선택사항 이기에)
			if(board.getBoard_file() == null) {
				board.setBoard_file("");
				board.setBoard_real_file("");
			}
			
			//-----------------------
			// BoardReplyProService 클래스 호출
			// registReplyBoard() 메서드 호출하여 글쓰기 작업 요청
			// 파라미터 : BoardBean 객체 , 리턴타입 : boolean (isWriteSuccess성공했는가 실패했는가)
			
			BoardReplyProService service = new BoardReplyProService();
			boolean isWriteSuccess = service.registBoard(board);
			
			// 성공, 실패에 따른 결과
			if(!isWriteSuccess) { // 실패 시
				//웹 브라우저로 HTML 태그 등을 내보내기(출력) 위한 작업 수행
				//setContentType을 통해 HTML 형식에 대한 문서 타입을 설정
				response.setContentType("text/html; charset=UTF-8");
				
				//출력스트림으로 사용할 객체 PrintWriter 사용
				// response객체의 getWriter 메서드 사용
				PrintWriter out = response.getWriter();
				
				out.println("<script>");		
				out.println("alert('글쓰기 실패')");
				out.println("history.back()");
				out.println("</script>");		
				
			}else { // 성공 시 
				// 포워딩 정보 저장을 위한 ActionForward 생성
				// => replyForm에서 페이지 번호 전달
				forward = new ActionForward();
				forward.setPath("BoardList.bo?pageNum=" + multi.getParameter("pageNum"));
				forward.setRedirect(true);
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return forward;
	}

}
