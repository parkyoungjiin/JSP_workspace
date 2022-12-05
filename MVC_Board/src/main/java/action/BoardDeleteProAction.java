package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.BoardDeleteProService;
import vo.ActionForward;

public class BoardDeleteProAction implements Action{

	//삭제 작업(패스워드, 게시물 번호)
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("BoardDeleteProAction");
		ActionForward forward = null;
		BoardDeleteProService service = new BoardDeleteProService();
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		String board_pass = request.getParameter("board_pass");
		
		request.setAttribute("board_num", board_num);
		request.setAttribute("board_pass", board_pass);
		
//		System.out.println("board_num: " + board_num);
//		System.out.println("board_pass : " + board_pass);
		
		int deleteCount = service.getDelete(board_num, board_pass);
		
		if(deleteCount > 0) {
			forward = new ActionForward();
			forward.setPath("BoardList.bo?pageNum=" + request.getParameter("pageNum"));
			forward.setRedirect(true);
		}
		
		
		
		
		
		return forward;
	}
	
}
