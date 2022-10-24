<%@page import="jsp09_jdbc_dao.Jsp8_2DAO"%>
<%@page import="jsp09_jdbc_dao.Jsp8_2DTO"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String jumin = request.getParameter("jumin1") + request.getParameter("jumin2"); 
	String email = request.getParameter("email1") + "@" + request.getParameter("email2");
	String job = request.getParameter("job");
	String gender = request.getParameter("gender");
	String hobby = "";
	String[] arrHobbies = request.getParameterValues("hobby");
	
// 	for (int i = 0 ; i<arrHobbies.length; i++){
// 		hobby += arrHobbies[i] + "/";
// 	}
	
	for(String strHobby : arrHobbies){
		hobby += strHobby + "/";
	}
	String content = request.getParameter("content");
	
	out.println(name + "<br>" + id + "<br>" + jumin + "<br>" + email + "<br>" + job + "<br>" + gender + "<br>" + hobby + "<br>"+ content + "<br>");

	//DTO 객체를 생성하여 DTO에 있는 객체를 하나하나 저장함.
	Jsp8_2DTO dto = new Jsp8_2DTO();
	
	
	dto.setName(name);
	dto.setId(id);
	dto.setPasswd(passwd);
	dto.setJumin(jumin);
	dto.setEmail(email);
	dto.setJob(job);
	dto.setGender(gender);
	dto.setHobby(hobby);
	dto.setContent(content);
	// Jsp8_2DAO 객체 insert() 메서드 호출하여 회원 가입 요청
	
	Jsp8_2DAO dao = new Jsp8_2DAO();
	//DAO로 생성한 dao 객체를 통해서 insert 문을 통한 결과를 insertCount에 넣는다.
	int insertCount = dao.insert(dto);

%>
	<%
	if(insertCount > 0) {
		response.sendRedirect("select_jsp8_2.jsp");
	}else{
	%>
	<script type="text/javascript">
		alert("회원 가입 실패!");
		history.back();
		</script>
	<%} 
	%>
	




