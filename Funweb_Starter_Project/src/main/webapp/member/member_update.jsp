<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
// member_info.jsp페이지로부터 전달받은 폼 파라미터를 사용하여
// 
MemberDTO dto = new MemberDTO();
dto.setId(request.getParameter("id"));
dto.setPass(request.getParameter("oldPass")); //기존 패스워드 가져옴(확인용)
dto.setName(request.getParameter("name"));
dto.setEmail(request.getParameter("email"));
dto.setPost_code(request.getParameter("post_code"));
dto.setAddress1(request.getParameter("address1"));
dto.setAddress2(request.getParameter("address2"));
dto.setPhone(request.getParameter("phone"));
dto.setMobile(request.getParameter("mobile"));

//MemberDAO 객체의 isRightUser() 메서드를 호출하여 패스워드 일치 여부 판별(로그인 작업과 동일하나 별도로 정의)
// - 파라미터 : DTO, 리턴타입 : boolean(isRightUser)
MemberDAO dao = new MemberDAO();
MemberDTO member = new MemberDTO();
boolean isRightUser = dao.isRightUser(member);

if(isRightUser){
	boolean isChangePass = false; //변경 여부 변수 선언 (false는 미변경)
	
	//newPass 존재할 경우 새 패스워드로 교체
	
	String newPass = request.getParameter("newPass");
	System.out.println("새 패스워드 : " + request.getParameter("newPass"));
	if(newPass!= null && !newPass.equals("")){
		member.setPass(newPass); // 변경용
		isChangePass =true;
	}
}
	int updateCount = dao.updateMember(member,isChangePass);
	
	if(updateCount > 0){
		%>
		<script>
		alert("회원 수정 성공!");
		location.href = "../main/main.jsp";
	 	</script>
	<%}else{%>
		<script>
		alert("회원 tnwjd tlfvo.");
		history.back();
		</script>
	
	<%}%>


// MemberDAO 객체의 insertMember()메서드를 호출하여 회원가입 작업 수행
//파라미터 : MemberDTO 객체 :member 리턴타입 :int (insertcount)

//회원가입 결과 판별
// 실패시 자바스크립트를 사용하여 회원가입실패 출력후 이전페이지 돌아가기
//아니면 메인페이지로 이동 
%>
<%-- <% --%>

<%-- 	if(dao.insertMember(dto) > 0){ %> --%>
		<script>
// 		alert("회원가입에 축하합니다!\n3000 포인트가 적립되었습니다.");
// 		location.href = "../main/main.jsp";
	 	</script> 
<%-- 	<% }else{%> --%>
		<script>
// 		alert("회원가입에 실패했습니다.");
// 		history.back();
		</script>
<%-- 	<%} %> --%>
