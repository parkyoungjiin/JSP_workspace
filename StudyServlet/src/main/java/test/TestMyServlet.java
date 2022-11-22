package test;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TestMyServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//GET 요청 발생 시 자동으로 호출되는 메서드
		System.out.println("GET방식 요청에 대한 doGET() 메서드 호출됨!");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//POST 요청 발생 시 자동으로 호출되는 메서드
		System.out.println("POST방식 요청에 대한 doPOST() 메서드 호출됨!");
	}

}
