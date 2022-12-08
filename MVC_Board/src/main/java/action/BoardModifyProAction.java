package action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.BoardModifyProService;
import vo.ActionForward;
import vo.BoardBean;

public class BoardModifyProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("BoardModifyProAction - DB 수정 작업");
		ActionForward forward = null;
		String realPath = "";
		String deleteFileName = "";
		
		try {
			// 파일 변경을 할 수 있도록 작업
			String uploadPath = "upload";
			realPath = request.getServletContext().getRealPath(uploadPath);
			int filesize = 10 * 1024 * 1024;
			MultipartRequest multi = new MultipartRequest(
					request, 
					realPath,
					filesize,
					"UTF-8",
					new DefaultFileRenamePolicy()
					);
		// 수정한 값들을 저장하여 넘길 수 있도록 BoardBean 작업
		BoardBean board = new BoardBean();
		
		board.setBoard_num(Integer.parseInt(multi.getParameter("board_num")));
		board.setBoard_pass(multi.getParameter("board_pass"));
		board.setBoard_subject(multi.getParameter("board_subject"));
		board.setBoard_content(multi.getParameter("board_content"));
		board.setBoard_file(multi.getFilesystemName("board_file"));
		board.setBoard_real_file(multi.getOriginalFileName("board_file"));
		
		System.out.println(board);
		
		// 비밀번호 일치 여부 판별 필요
		BoardModifyProService service = new BoardModifyProService();
		// 비밀번호 판별 여부 확인
		boolean isBoardWriter = service.getBoardWriter(board);
		
		
		if(isBoardWriter) {//비밀번호 일치 시
//			일치할 경우 수정 작업을 시작. 
			BoardModifyProService service2 = new BoardModifyProService();
			
			Boolean isModifySuccess = service2.getModify(board); //수정 메서드 : 
			
			if(isModifySuccess) {//비밀번호 일치 + 수정 작업 완료 시
				//포워딩 정보 저장하여 Detail로 이동.
				forward = new ActionForward();
				forward.setPath("BoardDetail.bo?board_num=" + board.getBoard_num() +"&pageNum=" + multi.getParameter("pageNum"));
				forward.setRedirect(false);
				
				
				//기존 파일 삭제 (파일 변경을 했을 때, 기존에 있는 리얼 파일은 삭제되고 새로운 파일이 올라가야 함.)
				// -> board_real_file의 경우 qna_board_modify에서 hidden으로 파라미터로 넘김.
				deleteFileName = multi.getParameter("board_real_file");
				
				
			}else{ //비밀번호 일치 + 수정 작업 실패
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('수정에 실패했습니다!')");
				out.println("history.back()");
				out.println("</script>");
//				deleteFileName = multi.getFilesystemName("board_file");
				deleteFileName = board.getBoard_real_file();

			}
			
		}else {//비밀번호 불일치 시 자바스크립트로 처리.
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('수정 권한이 없습니다!')");
			out.println("history.back()");
			out.println("</script>");
			
			//파일과 같이 변경할 때 비밀번호를 틀렸을 때도 파일이 upload 경로로 자동으로 올라간다.
			// 이를 삭제하기 위해 삭제할 파일명을 설정함. 
			// 이 떄 파일명을 새 파일명의 실제 파일명(real_file)으로 지정
			// 업로드되면 중복이 있을 때 뒤에 숫자가 붙어서 올라가는데
			// 만약 실패했을 경우 숫자가 붙은 파일을 삭제해야 하기에 real_file을 삭제한다.
			
			deleteFileName = board.getBoard_real_file();
//			deleteFileName = multi.getFilesystemName("board_file");

		}
		
		
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			File f = new File(realPath, deleteFileName);
			if(f.exists()) {
				f.delete();
			}
		}
		
		
		
		
		return forward;
	}

}
