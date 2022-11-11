<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String sId = (String)session.getAttribute("sId");
System.out.println(sId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 문의사항</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		
		<!-- 헤더 들어가는곳 -->
		  
		<!-- 본문들어가는 곳 -->
		  <!-- 본문 메인 이미지 -->
		  <!-- 왼쪽 메뉴 -->
		  <div id="sub_img_member"></div>
		  <nav id="sub_menu">
		  	<ul>
		  		<li><a href="#">Join us</a></li>
		  		<li><a href="#">Privacy policy</a></li>
		  	</ul>
		  </nav>
		  <!-- 본문 내용 -->
		  <h1>고객 문의 사항</h1>
	<form action="mail_pro.jsp" method="post">
		<table border="1">
<!-- 			<tr> -->
<!-- 				<td>받는 사람</td> -->
<!-- 				<td><input type="text" name="receiver"></td> -->
<!-- 			</tr> -->
			<tr>
				<td>제목</td>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name = "content" rows = "20" cols="40"></textarea></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="메일발송"></td>
			</tr>
		
		</table>
	
	
	</form>
		  
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


