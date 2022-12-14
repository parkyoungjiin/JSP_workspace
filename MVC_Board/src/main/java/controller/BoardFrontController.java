package controller;

import java.io.IOException;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.BoardDeleteProAction;
import action.BoardDetailAction;
import action.BoardListAction;
import action.BoardModifyAction;
import action.BoardModifyProAction;
import action.BoardReplyFormAction;
import action.BoardReplyProAction;
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
			
			
		}else if(command.equals("/BoardDetail.bo")) {
			action = new BoardDetailAction();
			//ActionForward 객체에 action 작업을 통해 포워딩 정보를 저장.
			forward = action.execute(request, response);
					
		}else if(command.equals("/BoardDeleteForm.bo")) {
			forward = new ActionForward();
			forward.setPath("board/qna_board_delete.jsp");
			
		}else if(command.equals("/BoardDeleteProForm.bo")) {
			action = new BoardDeleteProAction();
			forward = action.execute(request, response);
			
		// 수정 버튼 눌렀을 때, 해당 게시물 값의 데이터를 가져옴.(폼으로 이동)
		}else if(command.equals("/BoardModifyForm.bo")) {
			action = new BoardModifyAction(); 
			forward = action.execute(request, response);
		// 수정 폼에서 수정한 값들을 파라미터로 넘기고, 이를 DB에 수정하는 작업
		}else if(command.equals("/BoardModifyPro.bo")) {
			action = new BoardModifyProAction();
			forward = action.execute(request, response);
			
		}else if(command.equals("/BoardReplyForm.bo")) {
			action = new BoardReplyFormAction();
			forward = action.execute(request, response);
		
		}else if(command.equals("/BoardReplyPro.bo")) {
			action = new BoardReplyProAction();
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
