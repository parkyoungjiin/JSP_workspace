package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.BoardReplyFormService;
import vo.ActionForward;
import vo.BoardBean;

public class BoardReplyFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		System.out.println("BoardReplyFormAction - 답글 폼 액션");
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));

		BoardReplyFormService service = new BoardReplyFormService();

		BoardBean board = service.getBoard(board_num, false);
		
		System.out.println(board);
		
		request.setAttribute("board_num", board_num);
		request.setAttribute("board", board);
		
		if(board != null) {//널이 아니면 성공 (액션 클래스는 forward 정보를 저장)
			forward = new ActionForward();
			forward.setPath("board/qna_board_reply.jsp");
			//setredirect는 디스패치 방식이기에 필요 없음.
		
		}
		return forward;
	}
}
