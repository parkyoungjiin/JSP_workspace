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
dto.setAddress1(request.getParameter("address1"));
dto.setAddress2(request.getParameter("address2"));
dto.setPhone(request.getParameter("phone"));
dto.setMobile(request.getParameter("mobile"));

out.println(dto.toString());
// MemberDAO 객체의 insertMember()메서드를 호출하여 회원가입 작업 수행
//파라미터 : MemberDTO 객체 :member 리턴타입 :int (insertcount)

//회원가입 결과 판별
// 실패시 자바스크립트를 사용하여 회원가입실패 출력후 이전페이지 돌아가기
//아니면 메인페이지로 이동 
%>
<%
MemberDAO dao = new MemberDAO();

if(dao.insertMember(dto) > 0){ %>
	<script>
	alert("회원가입에 성공했습니다.");
 	</script> 
<% }else{%>
	<script>
	alert("회원가입에 실패했습니다.");
	location.href("main.jsp");
	</script>
<%} %>
