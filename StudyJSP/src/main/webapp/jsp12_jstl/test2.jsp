<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>test2.jsp -JSTL</h1>
	<c:set var="str"  value="Hello, World!"/>
	<h3>\${str } = ${str }</h3>
	
	<%--�ڹ��ڵ�� ������ ���� �������� ���� ����ϱ� ���ؼ��� --%>
	<%String str2 = "Hello, World!"; %>
	<%-- ��� 1. page ���� ��ü�� �Ӽ������� �� ���� --%>
	<%pageContext.setAttribute("str2", "str2"); %>
	
	<%-- ��� 2. c:set �±׷� JSTL������ ������ ��ȯ �� ������ �����ϴ� (value�� ǥ�������� �� ����) --%>
<%-- 	<c:set var="str2"  value="<%=str2 %>"/> --%>
	
	
	<%--��� ��� 1 --%>
	<h3>\${str2 } = ${str2 }</h3>
	<%--��� ��� 2 <c:out>  --%>

	<c:set var = "targetTag" value = "&lt;c:out&gt;"/>
	<h3>
		<c:out value="${targetTag }"/><br>
		<c:out value="${targetTag }" escapeXml="false"/><br>
	</h3>
	
	<hr>
	<%-- �� ���� --%>
	<c:remove var="str"/>
	<h3>\${str }�� ���� �� = ${str }</h3>
	<h3>\${empty str } empty ���� = ${empty str }</h3>
</body>
</html>