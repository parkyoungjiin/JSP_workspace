package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import encrypt.MyMessageDigest;
import svc.MemberJoinProService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberJoinProAction implements Action{
	//
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
//		request.setCharacterEncoding("UTF-8");
		MemberJoinProService service = new MemberJoinProService();
		
		MemberBean member = new MemberBean();
		member.setName(request.getParameter("name"));
		member.setGender(request.getParameter("gender"));
		member.setEmail(request.getParameter("email1") + "@" + request.getParameter("email2"));
		member.setId(request.getParameter("id"));
		member.setPasswd(request.getParameter("passwd"));
		System.out.println(member);
		
		MyMessageDigest md = new MyMessageDigest("SHA-256");
		md.hashing(request.getParameter("passwd"));
		
		try {
			boolean isJoinSuccess = service.JoinMember(member);
			if(isJoinSuccess) {//로그인 작업 성공 시
				forward = new ActionForward();
				forward.setPath("member/member_login_form.jsp");
				forward.setRedirect(false);
				
			}else {//로그인 작업 실패 시 
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
