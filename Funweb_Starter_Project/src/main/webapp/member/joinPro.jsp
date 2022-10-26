<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

// String id = request.getParameter("id");
// String pass1 = request.getParameter("pass1");
// String pass2 = request.getParameter("pass2");
// String name = request.getParameter("name");
// String email = request.getParameter("email");
// String post_code = request.getParameter("post_code");
// String address1 = request.getParameter("address1");
// String address2 = request.getParameter("address2");
// String phone = request.getParameter("phone");
// String mobile = request.getParameter("mobile");

MemberDTO dto = new MemberDTO();
dto.setId(request.getParameter("id"));
dto.setPass(request.getParameter("pass"));
dto.setName(request.getParameter("name"));
dto.setEmail(request.getParameter("email"));
dto.setPost_code(request.getParameter("post_code"));
dto.setAddress1(request.getParameter("Address1"));
dto.setAddress2(request.getParameter("Address2"));
dto.setPhone(request.getParameter("phone"));
dto.setMobile(request.getParameter("mobile"));


//MemberDAO 객체의 insertMember() 메서드르 호출하여 회원가입 작업 수행
// -> 파라미터 : MemberDTO 객체(member) 리턴 : int(insertCount)
out.print(dto.toString());
%>