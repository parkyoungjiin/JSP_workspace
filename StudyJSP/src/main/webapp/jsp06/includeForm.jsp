<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>includeForm.jsp</h1>
	<hr>
	<jsp:include page="includePro.jsp">
		<jsp:param name="paramValue" value="Parameter Value" />
	</jsp:include>
	<hr>
</body>
</html>