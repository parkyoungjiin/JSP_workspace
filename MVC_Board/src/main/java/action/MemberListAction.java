package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Member;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.BoardListService;
import svc.MemberListService;
import vo.ActionForward;
import vo.BoardBean;
import vo.MemberBean;
import vo.PageInfo;

public class MemberListAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("BoardListAction");
		

		
		ActionForward forward = null;
		MemberListService service = new MemberListService();
		
		List<MemberBean> memberList = new ArrayList<MemberBean>();
		
		memberList = service.getMemberList();
		//sId가 admin일 때만 이 페이지를 열 수 있도록 설정.	
		try {
			if(memberList.isEmpty()) { // 비었을 떄 true
				response.setContentType("text/html; charset=UTF-8");
				
				//출력스트림으로 사용할 객체 PrintWriter 사용
				// response객체의 getWriter 메서드 사용
				PrintWriter out = response.getWriter();
				
				out.println("<script>");		
				out.println("alert('회원멤버가 없습니다.')");
				out.println("history.back()");
				out.println("</script>");
			}else { // 리스트가 안비었을 때 false
				//리스트 값을 저장해야함.
				request.setAttribute("memberList", memberList);
				
				
				forward = new ActionForward();
				forward.setPath("member/member_list.jsp?");
				forward.setRedirect(false);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		
		//forward 이동할 페이지 : member/member_list.jsp
		return forward;
	}
		
	
}
