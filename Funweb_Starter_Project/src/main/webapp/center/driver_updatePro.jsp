<%@page import="board.FileBoardDTO"%>
<%@page import="board.FileBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//패스워드 일치 시 업데이트 실행
int idx = Integer.parseInt(request.getParameter("idx"));
String pageNum = request.getParameter("pageNum");

FileBoardDTO fileboard = new FileBoardDTO();
fileboard.setName(request.getParameter("name"));
fileboard.setPass(request.getParameter("pass"));
fileboard.setSubject(request.getParameter("subject"));
fileboard.setContent(request.getParameter("content"));

// System.out.println(pass);

FileBoardDAO dao = new FileBoardDAO();
int updateCount = dao.FileBoardUpdate(fileboard);

%>