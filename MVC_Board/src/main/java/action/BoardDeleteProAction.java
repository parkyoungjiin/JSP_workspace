package action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.BoardDeleteProService;
import svc.BoardDetailService;
import vo.ActionForward;
import vo.BoardBean;

public class BoardDeleteProAction implements Action{

	//삭제 작업(패스워드, 게시물 번호)
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("BoardDeleteProAction");
		ActionForward forward = null;
		//게시판 번호, 비밀번호 파라미터로 가져오기 (action 클래스에서는 request, response 객체를 가져올 수 있기 때문.)
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		String board_pass = request.getParameter("board_pass");
//		System.out.println("board_num: " + board_num);
//		System.out.println("board_pass : " + board_pass);
		
		request.setAttribute("board_num", board_num);
		request.setAttribute("board_pass", board_pass);
		
		//파일 삭제 작업을 위해 board 객체를 조회해서 가져와야 함.
		BoardDetailService service2 = new BoardDetailService();
		BoardBean board = service2.getDetialList(board_num, false);
		
		try {
			BoardDeleteProService service = new BoardDeleteProService();

			boolean isWriter = service.isBoardWriter(board_num, board_pass);
			
			if(isWriter) {//비밀번호 일치 시
				//삭제 작업
				int deleteCount = service.getDelete(board_num);
				
				if(deleteCount > 0) {
					String uploadPath = "upload";
					String realPath = request.getServletContext().getRealPath(uploadPath);
					
					File f = new File(realPath, board.getBoard_real_file());
					if(f.exists()) {
						f.delete();
					}
					
					
					forward = new ActionForward();
					forward.setPath("BoardList.bo?pageNum=" + request.getParameter("pageNum"));
					forward.setRedirect(true);
				}
				
			}else { //비밀번호 틀렸을 때(틀렸을 때는 삭제가 될 필요가 없음 !)		
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('삭제 권한이 없습니다!')");
				out.println("history.back()");
				out.println("</script>");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
			
		
		
		
		
		
		
		
		return forward;
	}
	
}
