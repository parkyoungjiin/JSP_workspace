<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	

</script>
</head>
<body>
	<h1>requestPro1.jsp -request 객체</h1>
	<h1>request 객체 처리 페이지</h1>
	
	<% 
	request.setCharacterEncoding("UTF-8"); //request 객체에 있는 데이터들을 모두 한글로 변경.
		String strName = request.getParameter("name");
// 		out.print("이름 :" + strName + "<br>");
	
		String strAge = request.getParameter("age");
// 		out.print("나이 :" + strAge + "<br>");
	
		String strGender = request.getParameter("gender");
// 		out.print("성별 :" + strGender + "<br>");
	
		String strHobby = request.getParameter("hobby");
// 		out.print("취미 :" + strHobby + "<br>");
		
		String[] strHobbies = request.getParameterValues("hobby");
// 		out.print("취미 :" + strHobbies + "<br>");
		
// 		checkbox 항목을 하나도 체크하지 않을 경우, hobby 파라미터가 없으므로
// 		Strhobbies 배열에는 null값이 저장된다(배열이 존재하지 않음)

	%>
	<table border = "1">
			<tr>
				<th>이름</th>
				<td><%=strName %></td>
			</tr>
		
			<tr>
				<th>나이</th>
				<td><%=strAge %></td>
			</tr>
		
			<tr>
				<th>성별</th>
				<td><%=strAge %></td>
			</tr>
			<tr>
				<th>취미</th>
				<td>
<%-- 				 <%=strHobbies[0] %> <%=strHobbies[1] %> <%=strHobbies[2] %> --%>
					<%
					for(int i = 0 ; i < strHobbies.length; i++){
						out.println(strHobbies[i] +"");
					}
					
					%>
					
<%-- 					<%if(strHobbies == null) { %> --%>
						<script type="text/javascript">
// 							alert("취미 선택 필수!")
// 							history.back();
						</script>
<%-- 					<%} %> --%>


					<%
					if(strHobbies == null){
						out.println("없음");
					} else {
						for(int i = 0 ; i < strHobbies.length ; i++){
							out.println(strHobbies[i] +" ");
						}
					}
					%>
				</td>
				
			</tr>
			<tr>
				<td colspan = "2" align ="center">
					<input type="button" value = "뒤로가기" onclick = "history.back()">
				</td>
			</tr>
		</table>
</body>
</html>