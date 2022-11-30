package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.BoardListAction;
import action.BoardWriteProAction;
import vo.ActionForward;

/**
 * Servlet implementation class BoardFrontController
 */
//@WebServlet("*.bo")
public class BoardFrontController_backup extends HttpServlet {
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
		
		//추출된 서블릿 주소를 통해 if문을 통해 문자열 비교
		
		if(command.equals("/BoardWriteForm.bo")) {
			System.out.println("글쓰기!");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("board/qna_board_write.jsp");
			dispatcher.forward(request, response);
			
			
		}else if(command.equals("/BoardWritePro.bo")) {
			System.out.println("Pro!");
			//BoardWriteProAction에서 객체 생성 후, execute 메서드를 통해 해당 페이지의
			// 주소, 포워딩 방식을 Action Forward에 저장 
			BoardWriteProAction action = new BoardWriteProAction();
			ActionForward forward = action.execute(request, response);

			//글 목록 표시를 위해 BoardList.bo 서블릿 주소 요청
			// -> 새로운 요청이므로, 주소표시줄이 변경되야 한다 (Redirect)
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			}else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
			
		}else if(command.equals("/BoardList.bo")) {
			System.out.println("List 폼!");
			
			BoardListAction listAction = new BoardListAction();
			ActionForward foward = listAction.execute(request, response);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("board/qna_board_list.jsp");
			dispatcher.forward(request, response);
		}
		
	}
}
