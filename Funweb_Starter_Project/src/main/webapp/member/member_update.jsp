<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 1. 폼 파라미터를 통해 info에서 입력된 값들을 DTO에 값들을 저장.
MemberDTO member = new MemberDTO();

member.setId(request.getParameter("id"));
member.setPass(request.getParameter("oldPass"));
member.setName(request.getParameter("name"));
member.setEmail(request.getParameter("email"));
member.setMobile(request.getParameter("mobile"));
member.setPost_code(request.getParameter("post_code"));
member.setAddress1(request.getParameter("address1"));
member.setAddress2(request.getParameter("address2"));
member.setPhone(request.getParameter("phone"));

String id = member.getId();
String pass = member.getPass();
//2. dao를 생성하여 패스워드 일치 여부에 따라 true일 경우 수정할 수 있도록

MemberDAO dao = new MemberDAO();
boolean isRightUser = dao.isRightUser(id, pass);
//3. 패스워드가 일치할 경우 작업하는데 newPass 가 있을 경우 DTO 객체의 패스워드를 새 패스워드로 교체 
if(isRightUser){
	boolean isChangePass = false;
	String newPass = request.getParameter("newPass");
	System.out.println("newPass :" + newPass );
	
	if(newPass !=null && !newPass.equals("")){
		member.setPass(newPass);
		isChangePass = true;
	}
	int updateCount = dao.updateMember(member, isChangePass);
	
	if(updateCount > 0){%>
		<script>
		alert("업데이트 완료");
		location.href = "member_info.jsp";
		</script>
	<%}else{%>
		<script>
		alert("업데이트 실패");
		history.back();
		</script>
	
	<%} %>
<%} %>





