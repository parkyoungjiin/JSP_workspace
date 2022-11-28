package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;

public class BoardListAction {
	//
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		//글쓰기 데이터 가져와야 함. (request는 내장 객체, 자바 클래스에서 불가능)
		ActionForward forward = null;
		
		//글쓰기 비즈니스 로직 수행했다고 가정
		
			forward = new ActionForward();
			
			forward.setPath("board/qna_board_list.jsp");
			
			forward.setRedirect(false);
		
		
		return forward;
		
	}
}
