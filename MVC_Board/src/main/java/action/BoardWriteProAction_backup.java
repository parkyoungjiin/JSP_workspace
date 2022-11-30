package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;

public class BoardWriteProAction_backup {
	//
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		//글쓰기 데이터 가져와야 함. (request는 내장 객체, 자바 클래스에서 불가능)
		ActionForward forward = null;
		String subject = request.getParameter("board_subject");
		System.out.println("제목 : " + subject);
		
		//글쓰기 비즈니스 로직 수행했다고 가정
		boolean isWriteSuccess = true;
		
		if(!isWriteSuccess) {
			
		}else {
			forward = new ActionForward();
			
			forward.setPath("BoardList.bo");
			
			forward.setRedirect(true);
		}
		
		return forward;
		
	}
}
