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
		
		ActionForward forward = null;
		String realPath = "";
		String deleteFileName = "";

		try {
			String uploadPath = "upload"; // 업로드 가상 디렉토리(이클립스가 관리)
			realPath = request.getServletContext().getRealPath(uploadPath);// 업로드 실제 디렉토리(톰캣)
			System.out.println("실제 업로드 경로 : " + realPath);
			File f = new File(realPath);
			//디렉토리가 존재하지 않을 경우 디렉토리 생성
			//단, file 객체가 생성되더라도 해당 디렉토리 또는 파일을 직접 생성하지 않음.
			if(!f.exists()) {//
				//
				f.mkdir(); 
			}
			int filesize = 1024 * 1024 * 10;
			
//	-----------파일 업로드 처리-----------------
			MultipartRequest multi = new MultipartRequest(
					request, 
					realPath,
					filesize,
					"UTF-8",
					new DefaultFileRenamePolicy()
					);
			
			BoardBean board = new BoardBean();
			board.setBoard_num(Integer.parseInt(multi.getParameter("board_num")));
			board.setBoard_name(multi.getParameter("board_name"));
			board.setBoard_pass(multi.getParameter("board_pass"));
			board.setBoard_subject(multi.getParameter("board_subject"));
			board.setBoard_content(multi.getParameter("board_content"));
			//만약 수정할 파일을 선택하지 않았을 경우 파일명은 null값이 저장된다. ( 알아둘 것)
			board.setBoard_file(multi.getOriginalFileName("board_file"));
			board.setBoard_real_file(multi.getFilesystemName("board_file"));
			System.out.println(board);
			
			//수정 작업 결과에 따라 삭제할 파일이 달라지므로
			//파일명을 저장할 변수를 선언 (try 밖에 선언함)
			
			
			BoardModifyProService service = new BoardModifyProService();
			
			//패스워드 일치 여부 확인
			boolean isBoardWriter = service.isBoardWriter(board);
			//일치한 지 아닌지에 따라 다르게 처리
			if(!isBoardWriter) { // 수정 권한 없음 (비밀번호 불일치)
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('수정 권한이 없습니다!')");
				out.println("history.back()");
				out.println("</script>");
				
				//삭제할 파일명을 새 파일명의 실제 파일명으로 지정
				deleteFileName = board.getBoard_real_file();
				
			} else { // 수정권한 있음(비밀번호 일치)
				//있을때만 수정할 수 있도록 작업
				boolean isModifySuccess = service.modifyBoard(board);
				
				if(!isModifySuccess) { // 수정 실패 시(비밀번호는 일치한데, 작업 실패 시) 
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('수정 실패!')");
					out.println("history.back()");
					out.println("</script>");
					
					//삭제할 파일명을 새 파일명의 실제 파일명으로 지정
					deleteFileName = board.getBoard_real_file();
				} else { // 수정 성공 시 ( detail.bo로 가야되며, 게시글번호와 페이지 번호를 같이 넘겨야 함)
					forward = new ActionForward();
					forward.setPath("BoardDetail.bo?board_num=" + board.getBoard_num() + "&pageNum=" + multi.getParameter("pageNum"));
					forward.setRedirect(true);
					
					//삭제할 파일명을 기존 파일의 실제 파일명으로 지정 
					//(modify form에서 hidden 속성으로 전달받은 기존 파일명에 대한 파라미터를 사용)
					//단, 수정할 새 파일을 선택했을 경우에만 파일명 지정
					if(board.getBoard_file() !=null) {
						deleteFileName = multi.getParameter("board_real_file");

					}
					
					
					
					
				}
			}
		}catch (IOException e) {
			e.printStackTrace();
		}finally {
			//예외 발생하더라도 파일 삭제는 무조건 수행하도록 finally 블록에서 작성
			//1. File 객체 생성(파라미터 : 디렉토리명, 파일명 전달)
			File f = new File(realPath, deleteFileName);
			
			//해당 디렉토리 및 파일 존재 여부 판별
			if(f.exists()) {
				f.delete();
			}
			
		}
		
		
		
		
		return forward;
	}

}
