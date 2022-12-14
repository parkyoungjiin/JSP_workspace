package test2_forwarding;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TestServlet_Dispatch
 */
@WebServlet("/dispatchServlet")
public class TestServlet_Dispatch extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	
	}

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("TestServlet_Dispatch - doProcess()");
		request.setCharacterEncoding("UTF-8");
		
		
		String id = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		
		System.out.println("이름 : " + id);
		System.out.println("나이 : " + age);
		
//	RequestDispatcher dispatcher =request.getRequestDispatcher("test6_dispatch_result.jsp");
	RequestDispatcher dispatcher =request.getRequestDispatcher("test2_forwarding/test6_dispatch_result.jsp");
		
	//dispatch는 request, response가 유지되기에 같이 넘기는 것. (리다이렉트는 매번 요청, 응답이 초기화되기에 안적음)	
	dispatcher.forward(request, response);
		
		
		
	}

}
