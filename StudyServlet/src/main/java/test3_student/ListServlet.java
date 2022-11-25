package test3_student;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class WriteFormServlet
 */
@WebServlet("/test3_student/List")
public class ListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ListServlet - doGet()");
		//포워딩 될 새 주소가 나타나지 않게 하기 위해 기존 서블릿 주소 유지 -> 디스패치
	
		
		//강제로 글 목록에 대한 데이터를 조회했다고 가정하고
		//List에 DTO객체를 저장.
		
		List<StudentDTO> studentList = new ArrayList<StudentDTO>();
		
		studentList.add(new StudentDTO(1, "홍길동"));
		studentList.add(new StudentDTO(2, "이순신"));
		studentList.add(new StudentDTO(3, "강감찬"));
		
		//List 객체를 저장하기
		request.setAttribute("studentList", studentList);
		//포워딩 (주소 변경 X, 데이터 유지)
		RequestDispatcher dispatcher = request.getRequestDispatcher("list.jsp"); 
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ListServlet - doPost()");
		
		request.setCharacterEncoding("UTF-8");
		int idx = Integer.parseInt(request.getParameter("idx"));
		String name = request.getParameter("name");
		System.out.println("번호 :" + idx);
		System.out.println("이름 : " + name);
		
		//List라는 서블릿 주소를 요청
		RequestDispatcher dispatch = request.getRequestDispatcher("list.jsp");
		dispatch.forward(request, response);
		
	}
	

}
