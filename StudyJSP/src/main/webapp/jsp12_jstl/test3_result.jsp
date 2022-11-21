<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
   

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>test3_result.jsp</title>
</head>
<body>
	<h1>test3_result.jsp</h1>
	<!-- 변수 num을 선언, 10으로 초기화 -->
	<c:set var = "num" value = "10"/>
	<!-- name, age, num 출력 EL 활용 -->
	
	\${파라미터 name} = ${param.name } <br>
	\${파라미터 age} = ${param.age } <br>
	\${변수 age} = ${num } <br>
	<hr>
	<%--JSTL 문법 (조건문, 반복문) --%>
	<c:if test="${num ge 0 }">
		\${num }값이 0 보다 크다 <br>
		그러므로, 이 메세지는 현재 페이지에서 출력된다.	<br>
	
	</c:if>
	
	<%-- 파라미터 name이 비어있을 경우 판별하여 "name"값이 없습니다 출력 --%>
	<c:if test="${empty param.name}">
		name 값이 없습니다.	
	</c:if>
	<c:if test="${empty param.name}">
		name 값이 없습니다.	
	</c:if>
	
	<hr>
	
	<%--변수 num에 대해 양수 음수 0 판별 --%>
	
	<c:choose>
		<c:when test="${num gt 0 }">
			num은 양수입니다.
		</c:when>
		<c:when test="${num lt 0  }">
			num은 음수입니다.		
		</c:when>
		<c:otherwise>
			num은 0입니다.		
		</c:otherwise>
	
	</c:choose>
	<hr>
	
	<h3>\${param.name } = ${param.name }</h3>
	
	<%-- name 값 홍길동, 이순신, 그 외 나머지 판별--%>
	
	<c:choose>
		<c:when test="${empty param.name }">
			<script>
			alert("이름 입력 필수");
			history.back()
			</script>
		</c:when>
		
		<c:when test="${param.name  eq '홍길동'}">
			<h3>\${param.name }값은 홍길동입니다.</h3>
		</c:when>
		
		<c:when test="${param.name  eq '이순신'}">
			<h3>\${param.name }값은 이순신입니다.</h3>
		</c:when>
		
		<c:otherwise>
			<h3>나머지</h3>
		</c:otherwise>
	
	
	</c:choose>
	
	
	
	
	

</body>
</html>