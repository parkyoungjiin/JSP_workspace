<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
  <!-- login join -->
  <%
  String id = (String)session.getAttribute("sId");
  if(id == null || id ==""){%>
  <div id="login"><a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a></div>
  <% }else{ %>
	  <a href =""><%=id%>님</a> 
	  <a href = "../member/logout.jsp">로그아웃</a>
  <%} %>
  <div class="clear"></div>
  <!-- 로고들어가는 곳 -->
  <div id="logo"><img src="../images/logo.gif"></div>
  <!-- 메뉴들어가는 곳 -->
  <nav id="top_menu">
  	<ul>
  		<li><a href="../main/main.jsp">HOME</a></li>
  		<li><a href="../company/welcome.jsp">COMPANY</a></li>
  		<li><a href="../company/welcome.jsp">SOLUTIONS</a></li>
  		<li><a href="../center/notice.jsp">CUSTOMER CENTER</a></li>
  		<li><a href="../mail/mailForm.jsp">CONTACT US</a></li>
  	</ul>
  </nav>
</header>