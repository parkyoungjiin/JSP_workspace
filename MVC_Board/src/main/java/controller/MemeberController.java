package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.MemberJoinProAction;
import action.MemberListAction;
import action.MemberLoginProAction;
import action.MemberLogoutAction;
import vo.ActionForward;

/**
 * Servlet implementation class MemeberController
 */
@WebServlet("*.me")
public class MemeberController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);

	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);

	}
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("MemberController - doProcess");
		
		request.setCharacterEncoding("UTF-8");
		//서블릿 주소 추출
		//0. 전체 URL 가져오기 (참고)
		String requestURL = request.getRequestURL().toString();
//		System.out.println("requestURL : " + requestURL);
		
		//1. 요청 주소 중 URI 부분(프로젝트 / 서블릿 주소) 추출 
		String requestURI = request.getRequestURI();
//		System.out.println("requestURI : " + requestURI);
	
		
		//2. 요청 주소 중 컨텍스트 경로 추출 (/프로젝트명) 추출
		String contextPath = request.getContextPath();
//		System.out.println("contextPath : "  + contextPath);
		
		//3. 요청 주소 중 서블릿 주소 부분(/서블릿 주소) 추출
		// 방법 1. replace 사용
//		String command = requestURI.replace(contextPath, "");
		
		// 방법 2. substring 사용
		
		// subString(시작인덱스) : length를 하면 10이 나오는데, 인덱스는 0부터 시작하므로 URI의 10번째부터 추출.
//		String command = requestURI.substring(contextPath.length());
		
		
//		System.out.println("서블릿 주소 : " + command);
		
		//위의 1~3번 과정을 하나의 메서드로 압축 가능 (request 객체 - getServletPath() );
		
		
		String command = request.getServletPath();
		System.out.println("서블릿 주소 : " + command);

		
		//공통으로 사용할 변수 선언
		Action action = null; //XXXAction 클래스를 공통으로 관리할 Action 인터페이스 타입 선언
		
		ActionForward forward = null; // 포워딩 정보 저장할 변수
		
		if(command.equals("/MemberJoinForm.me")) {
			System.out.println("회원가입 폼으로 이동");
			
			forward = new ActionForward();
			forward.setPath("member/member_join_form.jsp");
			forward.setRedirect(false);
			
		}else if(command.equals("/MemberLoginForm.me")) {
			System.out.println("로그인 폼으로 이동");
			
			forward = new ActionForward();
			forward.setPath("member/member_login_form.jsp");
			forward.setRedirect(false);
			
		}else if(command.equals("/MemberJoinPro.me")) {
			System.out.println("회원가입정보 DB 등록");
			action = new MemberJoinProAction();
			forward = action.execute(request, response);
		
		}else if(command.equals("/MemberLoginPro.me")) {
			System.out.println("로그인 작업");
			action = new MemberLoginProAction();
			forward = action.execute(request, response);
			
			
		}else if(command.equals("/MemberList.me")) {
			System.out.println("회원목록으로 이동 ");
			action = new MemberListAction();
			forward = action.execute(request, response);
			
		}else if(command.equals("/MemberLogout.me")) {
			System.out.println("로그아웃 폼");
			action = new MemberLogoutAction();
			forward = action.execute(request, response);
		}
	
		if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			}else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
	
		
	
	}
}