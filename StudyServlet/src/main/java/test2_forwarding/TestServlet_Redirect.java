package test2_forwarding;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TestServlet_Redirect
 */
@WebServlet("/redirectServlet")
public class TestServlet_Redirect extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);

	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);

	}
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("TestServlet_Redirect - doProcess()");
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		
		System.out.println("이름 : " + id);
		System.out.println("나이 : " + age);
		
		
		//1. test2_forwarding 파일 내에 있는 결과
//		response.sendRedirect("test2_forwarding/test6_redirect_result.jsp");
		
		
		//2. webapp에 있는 결과
		response.sendRedirect("test6_redirect_result.jsp");
		
	}
}
