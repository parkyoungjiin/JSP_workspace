package test3_student;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class WriteFormServlet
 */
@WebServlet("/test3_student/WritePro")
public class WriteProServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("WriteProServlet - doGet()");
		//포워딩 될 새 주소가 나타나지 않게 하기 위해 기존 서블릿 주소 유지 -> 디스패치
		RequestDispatcher dispatch = request.getRequestDispatcher("writePro.jsp");
		dispatch.forward(request, response);
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("WriteFormServlet - doPost()");
		
		request.setCharacterEncoding("UTF-8");
		int idx = Integer.parseInt(request.getParameter("idx"));
		String name = request.getParameter("name");
		System.out.println("번호 :" + idx);
		System.out.println("이름 : " + name);
		
		//List라는 서블릿 주소를 요청
		response.sendRedirect("List");
		
	}
	

}
