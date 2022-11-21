<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="jsp11_dbcp.StudentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
request.setAttribute("idx", 3);
request.setAttribute("name", "홍길동");

StudentDTO dto = new StudentDTO();

List<StudentDTO> studentList = new ArrayList<StudentDTO>();

studentList.add(new StudentDTO(1, "박영진"));
studentList.add(new StudentDTO(2, "아"));
studentList.add(new StudentDTO(3, "김태훈"));

request.setAttribute("studentList", studentList);
//배열
String [] names = {"홍길동", "박영진", "박"};
request.setAttribute("names",names );

// response.sendRedirect는  새로운 request객체가 만들어지기에 사용 x
// request 객체 유지하면서 result 페이지로 포워딩 하기 위해 pageContext.forward() 메서드로 포워딩

pageContext.forward("test4_result.jsp");

%>