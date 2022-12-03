package action;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.BoardDetailService;
import vo.ActionForward;
import vo.BoardBean;

public class BoardDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		
		
		//service 인스턴스 생성
		BoardDetailService service = new BoardDetailService();
		//파라미터의 board_num을 저장해야 함.
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		//request 객체에 저장.
		
		//메서드를 통해 리스트를 받아야 함. (board_num에 맞는 게시물을 가져와야 함. where절 사용)
		BoardBean board = service.getDetialList(board_num);
		request.setAttribute("board_num", board_num);
		request.setAttribute("board", board);
		
		if(board != null) {//널이 아니면 성공 (액션 클래스는 forward 정보를 저장)
			forward = new ActionForward();
			forward.setPath("board/qna_board_view.jsp");
			//setredirect는 디스패치 방식이기에 필요 없음.
			
		}else {// 널이면 실패
			
		}
				
		
		
		return forward;
	}

}
