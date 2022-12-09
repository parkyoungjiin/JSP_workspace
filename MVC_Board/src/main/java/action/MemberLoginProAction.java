package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.Provider.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import svc.MemberLoginProService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberLoginProAction implements Action{
	//
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		
		MemberBean member = new MemberBean();
		String id =request.getParameter("id");
		member.setId(request.getParameter("id"));
		member.setPasswd(request.getParameter("passwd"));
		System.out.println(member);
		
		boolean isLoginSuccess = false;
		
		MemberLoginProService service = new MemberLoginProService();
		isLoginSuccess = service.loginMember(member);
		try {
			if(isLoginSuccess) {//로그인 성공 시
				forward = new ActionForward();
				forward.setPath("./");
				forward.setRedirect(true);
				
				HttpSession session = request.getSession();
				session.setAttribute("sId",id);
				System.out.println(session.getAttribute("sId"));
				
			}else {//로그인 실패 시
				response.setContentType("text/html; charset=UTF-8");
				
				//출력스트림으로 사용할 객체 PrintWriter 사용
				// response객체의 getWriter 메서드 사용
				PrintWriter out = response.getWriter();
				
				out.println("<script>");		
				out.println("alert('회원가입 실패')");
				out.println("history.back()");
				out.println("</script>");	
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		
		
		
		return forward;
		
	}
}
