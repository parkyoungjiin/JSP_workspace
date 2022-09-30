<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! 
	String str1 = "멤버변수입니다!";
	
	public void method1(){
		System.out.println("선언문의 method1()호출됨!");
	}
	
	public String method2(){
		return "method2() 메서드의 리턴값";
	}
%>

<%! String str2 = "두번쨰 멤버 변수입니다!"; %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>test3.jsp</h1>
	
	<%--
	표현식 <%= %>
	-선언문 또는 스크립틀릿에서 선언된 변수에 접근하여 값을 출력하거나
	메서드 호출 후 리턴되는 값을전달받아 출력하거나
	연산 결과를 출력하는 용도로 사용
	- 자바 코드이 System.out.println() 메서드와 동일한문법 구조 사용
	(단,System.out.println() 메서드는 이클빕스 콘솔에 출력되지만,
	표현식은웨페이지ㅐ에출력하므로 jsp 의 out.print 메서드와 동일 수행	
	 --%>
	<h3>멤버변수 str1 = <%=str1 %></h3>
	<h3>method2() 메서드 호출 결과 : <%=method2() %></h3>
	<%--스크립틀릿 내에서 선언된 로컬변수보다 윗쪽에서 접근 불가 --%>
<%-- 	<h3>로컬변수 str3 = <%=str3 %></h3> --%>
	<
	스크립틀릿 <% %>
	 --%>
	 <%
	 	//이곳 스크립틀릿 내부입니다.
	 	// 변수 선언도 가능하며, 해당 변수는 로컬 변수로 취급됨
	 	String str3 = "로컬변수입니다!";
	 	
	 	method1();
	 	method2();
	 	
	 	
	 	System.out.println("이 문장은 이클립스 콘솔창에 출력됨");
		System.out.println(str3);
		
		
	 	
	 %>
	 	<h3>로컬변수 str3 = <%=str3 %></h3>
	 <%-- 멤버변수는 선언문보다 윗쪽에서 접근하더라도 접근 가능 --%>
	 <h3>멤버변수 str4(선언문보다 아래)<%=str4 %></h3>
	 <%! String str4="멤버변수 str4 문자열 저장"; %>
	 
	 <h3>멤버변수 str4(선언문보다 아래)<%=str4 %></h3>
	 
	 
</body>
</html>