package test;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// http://localhost:8080/StudyServlet/myServlet3 주소를 매핑하기 위해 어노테이션 설정 (매핑말고 다른 방법임)
@WebServlet("/myServlet3")
public class TestMyServlet3 extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//GET 요청 발생 시 자동으로 호출되는 메서드
		System.out.println("GET 방식 - TestMyServlet3");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//POST 요청 발생 시 자동으로 호출되는 메서드
		System.out.println("POST 방식 - TestMyServlet3");
	}

}
