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
		location.href = "delete2.jsp?id=" + id; // id도 같이 넘김. (웹페이지에)
	}else{
		alert("취소되었습니다")
	}

}

</script>
</head>
<body>
   
<%
   String id = request.getParameter("id");

   String driver="com.mysql.cj.jdbc.Driver";
   String url = "jdbc:mysql://localhost:3306/study_jsp";
   String user ="root";
   String password= "1234";
   
   Class.forName(driver);
   
   Connection con = DriverManager.getConnection(url, user, password);
   
   String sql = "select * from jsp8_2 where id=?";
   
   PreparedStatement pstmt = con.prepareStatement(sql);
   pstmt.setString(1, id);
   
   ResultSet rs = pstmt.executeQuery();
   %>
   
   <h1><%=id %> 님의 회원 정보</h1>
   
   <%
   while(rs.next()){
      String name = rs.getString(1);
      String passwd = rs.getString(3);
      String jumin = rs.getString(4);
      String email = rs.getString(5);
      String job = rs.getString(6);
      String gender = rs.getString(7);
      String hobby = rs.getString(8);
      String content = rs.getString(9);
      Date hire_date = rs.getDate(10);
   %>
      <table border="1">
      <tr>
         <td>이름</td>
         <td colspan="3"><%=name %></td>
      </tr>   
       
       <tr>
          <td>ID</td>
          <td><%=id %></td>
       </tr>
   
      <tr>
         <td>비밀번호</td>
         <td><%=passwd %></td>
      </tr>
      
      <tr>
         <td>주민등록번호</td>
         <td><%=jumin %></td>
      </tr>
      
      <tr>
         <td>이메일</td>
         <td><%=email %></td>
      </tr>
      
      <tr>
         <td>직업</td>
         <td><%=job %></td>
      </tr>      
   
      <tr>
         <td>성별</td>
         <td><%=gender %></td>
      </tr>
   
      <tr>
         <td>취미</td>
         <td><%=hobby %></td>
      </tr>
      
      <tr>
         <td>가입동기</td>
         <td><%=content %></td>
      </tr>
   
      <tr>
         <td colspan="2">
            <input type="reset" value="삭제" onclick = "confirmDelete('<%=id %>')"> <!-- 이 id는 sql에서 가져온 String id이다. --> %>
            <input type="submit" value="이전" onclick="history.back()">
         </td>
      </tr>
   </table>
   <%
   }
	%>


   
</body>
</html>