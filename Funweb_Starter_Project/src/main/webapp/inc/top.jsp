<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
function confirm_logout(){
	//confirm dialog를 통해 리턴을 받을 수 있다.
	let result = confirm("로그아웃 하시겠습니까");
	if(result){
		location.href = "../member/logout.jsp";
	}
}
</script>    
    
<header>
  <!-- login join -->
  <%
  String id = (String)session.getAttribute("sId");
  System.out.println(id);
  if(id == null || id ==""){ //null이거나 null string일 때 login / join을 띄운다.%>
  <div id="login"><a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a></div>
  
  <% }else{ %>
  <div id="login">
  <a href ="../member/member_info.jsp?id=<%=id%>"><%=id%>님</a> <a href = "javascript:confirm_logout()">logout</a>
  <%if(id.equals("admin")) {%>
  	| <a href ="../admin/admin_main.jsp">관리자페이지</a>
  <%} %>
  </div>
  
  <%} %>
  
  <div class="clear"></div>
  <!-- 로고들어가는 곳 -->
  <div id="logo" onclick="location.href = '../main/main.jsp'"><img src="../images/logo.gif"></div>
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