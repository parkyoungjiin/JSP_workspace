package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;

public interface Action {
	//공통 메서드인 execute()를 정의
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response);
}
