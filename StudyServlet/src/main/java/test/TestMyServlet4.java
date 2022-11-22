package test;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/test4/myServlet")

//EL은 JSP 파일에서만 사용할 수 있기에 자바 파일에서 EL을 사용할 수 없다
//그렇기에 파라미터를 받아오기 위해서는 request, response 내장객체를 사용.
public class TestMyServlet4 extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("GET 방식 호출 - TestMyServlet4");
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("POST 방식 호출 - TestMyServlet4");
		doProcess(request, response);
		
	}

	//GET, POST 방식 공통 작업 수행 (중복에 대한 처리)
	// => 오버라이딩은 아니지만, 파라미터는 동일하게 선언
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("POST 방식 호출 - TestMyServlet4");
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("name");
		
		int age = Integer.parseInt(request.getParameter("age"));
		
		System.out.println("이름 : " + name);
		System.out.println("나이 : " + age);
		
	}
}
