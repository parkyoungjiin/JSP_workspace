package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.BoardListAction;
import action.BoardWriteProAction;
import vo.ActionForward;

/**
 * Servlet implementation class BoardFrontController
 */
@WebServlet("*.bo")
public class BoardFrontController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}//get
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}//post

	
	//GET, POST 공통으로 처리할 doProcess 메서드
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("BoardFrontController - doProcess");
		
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
		
		
		
		if(command.equals("/BoardWriteForm.bo")) {
			System.out.println("글쓰기!");
			 forward = new ActionForward();
			 // ActionForward 객체 생성 후 이동할 경로와 포워딩 방식을 저장함.
			 forward.setPath("board/qna_board_write.jsp");
			 forward.setRedirect(false);
			
			
		}else if(command.equals("/BoardWritePro.bo")) {
			System.out.println("Pro!");
			
			//글쓰기 비즈니스 로직 요청
			//비즈니스 로직(DB) 처리할 Action 클 래스의 execute 메서드 호출
			action = new BoardWriteProAction();
			forward = action.execute(request, response);
			
			
		}else if(command.equals("/BoardList.bo")) {
			System.out.println("List 폼!");
			
			action = new BoardListAction();
			
			forward = action.execute(request, response);
			
			
		}
		
		//---------------ActionForward 객체 내용에 따라 각각 다른 방식의 포워딩 작업----------------------
		
		//1. ActionForward 객체 Null 아닐경우
		
		if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			}else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
		
	}//doProcess 끝
}
