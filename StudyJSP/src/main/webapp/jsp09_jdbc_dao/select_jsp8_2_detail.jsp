<%@page import="jsp09_jdbc_dao.Jsp8_2DTO"%>
<%@page import="jsp09_jdbc_dao.Jsp8_2DAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function confirmDelete(id){
	//confirm dialog 사용하여 확인 요청 
	let confirmDele = confirm(id + " 회원을 삭제하시겠습니까?");
	if(confirmDele){
		location.href = "delete_jsp_8_2.jsp?id=" + id; // id도 같이 넘김. (웹페이지에)
	}else{
		alert("취소되었습니다")
	}

}

</script>
</head>
<body>
   
<%
	 String id = request.getParameter("id");

	//리턴타입 dto, 파라미터 id 
	// -> dao에 있는 메서드를 호출해서 dto에 저장한다. 
	String sId = (String)session.getAttribute("sId");	
	
	if(id ==null || sId ==null || !id.equals(sId) && !sId.equals("admin")){%>
		<script>
			alert("잘못된 접근입니다.");
			location.href = "index.jsp";
		</script>
		<%
	}
	
	Jsp8_2DAO dao = new Jsp8_2DAO();
	Jsp8_2DTO dto = dao.selectDetail(id);	
	//만약 조회결과가 있을 경우(Jsp8_2DTO 객체가 Null 이 아닌경우 ) 테이블에 겨
	if(dto != null){	

 %>
   
      <table border="1">
      <tr>
         <td>이름</td>
         <td colspan="3"><%=dto.getName() %></td>
      </tr>   
       
       <tr>
          <td>ID</td>
          <td><%=dto.getId() %></td>
       </tr>
   
      <tr>
         <td>비밀번호</td>
         <td><%=dto.getPasswd() %></td>
      </tr>
      
      <tr>
         <td>주민등록번호</td>
         <td><%=dto.getJumin() %></td>
      </tr>
      
      <tr>
         <td>이메일</td>
         <td><%=dto.getEmail() %></td>
      </tr>
      
      <tr>
         <td>직업</td>
         <td><%=dto.getJob() %></td>
      </tr>      
   
      <tr>
         <td>성별</td>
         <td><%=dto.getGender() %></td>
      </tr>
   
      <tr>
         <td>취미</td>
         <td><%=dto.getHobby() %></td>
      </tr>
      
      <tr>
         <td>가입동기</td>
         <td><%=dto.getContent() %></td>
      </tr>
      
      <tr>
         <td>가입일</td>
         <td><%=dto.getHire_date() %></td>
      </tr>
   
      <tr>
         <td colspan="2">
            <input type="reset" value="삭제" onclick = "confirmDelete('<%=dto.getId() %>')"> <!-- 이 id는 sql에서 가져온 String id이다. -->
            <input type="submit" value="이전" onclick="history.back()">
         </td>
      </tr>
   </table>
<%
} //if문 끝 (39번)
%>

   
</body>
</html>