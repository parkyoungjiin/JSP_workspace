<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
    
<div id = "member_area">
<c:choose>
	<c:when test="${not empty sessionScope.sId and sessionScope.sId eq 'admin'}">
	<a href="./">Home</a> | <a href="">${sessionScope.sId }님</a> | <a href="MemberLogout.me">Logout</a>  | <a href="MemberList.me">관리자페이지</a>
	</c:when>
	
	<c:when test="${not empty sessionScope.sId }">
	<a href="./">Home</a> | <a href="">${sessionScope.sId }님</a> | <a href="MemberLogout.me">Logout</a> 
	</c:when>
	
		
	<c:otherwise>
	<a href="./">Home</a> | <a href="MemberLoginForm.me">Login</a> | <a href="MemberJoinForm.me">Join</a>
	</c:otherwise>

</c:choose>

</div>