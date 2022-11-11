<%@page import="mail.GoogleMailAuthenticator"%>
<%@page import="javax.mail.Transport"%>
<%@page import="java.util.Date"%>
<%@page import="javax.mail.Message.RecipientType"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

// String sender = request.getParameter("sender");
// String receiver = request.getParameter("receiver");
String sId = (String)session.getAttribute("sId");
String sender = sId;
String receiver = "pyjs18593@gmail.com";
String title = request.getParameter("title");
String content = request.getParameter("content");

// out.println(sender + receiver + title + content);
//--------메일 전송을 위한 작업-------------


try{
//1. 시스템(서버=톰캣)의 속성 정보(서버 정보)를 Properties 객체로 리턴 받기

Properties properties = System.getProperties();

//2. Properties 객체를 활용하여 메일 전송에 필요한 기본 정보를 서버 속성 정보에 저장
properties.put("mail.smtp.host", "smtp.gmail.com");
properties.put("mail.smtp.auth", "true"); //SMTP 서버에 대한 인증 여부 설정
properties.put("mail.smtp.port", "587"); // SMTP 서비스 포트 (gogle은 587);

//메일 인증 관련 정보 설정
properties.put("mail.smtp.starttls.enable", "true"); // TLS 인증 프로토콜 사용 여부;
properties.put("mail.smtp.ssl.protocols", "TLSv1.2"); // 인증 프로토콜 버전 설정
// 만약 TLS 버전 관련 문제 발생

//3. 메일 서버 인증 정보를 생성하는 사용자 정의 클래스 인스턴스 생성

GoogleMailAuthenticator authenticator = new GoogleMailAuthenticator();


//4. 자바 메일 전송을 수행하는 작업의 기본단위를 객체로 관리하므로 session 클래스의 메서드를 호출하여 session 객체 얻어오기

Session mailSession = Session.getDefaultInstance(properties, authenticator);

//5. 서버 정보, 인증 정보를 포함하는 MimeMessage 객체 생성
// => 파라미터 : javax.mail.Session 객체 전달
Message mailMessage = new MimeMessage(mailSession);

//6. 전송할 메일에 대한 정보 설정
// 1) 발신자 정보 설정
// => 단, 상용 메일 서버(구글, 네이버 등)의 경 
Address senderAddress = new InternetAddress(sender, sId);

// 2) 수신자 정보 설정
Address receiverAddress = new InternetAddress(receiver);

// 3) Message 객체를 통해 전송할 메일에 대한 내용 정보 설정
// 3-1) 메일 헤더 정보
mailMessage.setHeader("content-type", "text/html; charset=UTF-8");

// 3-2) 발신자 정보 설정
mailMessage.setFrom(senderAddress);

// 3-3) 수신자 정보 설정
// addRecipient() 메서드를 통해 정보 설정
// 파라미터 : 수신 타입(기본수신자이므로 to 상수 활용),수신자 정보 객체
mailMessage.addRecipient(RecipientType.TO, receiverAddress); //cc 는 참조로 설정, to는 수신자로 설정, BCC는 블라인드로 참조


// 3-4) 메일 제목 설정
mailMessage.setSubject(title);
// 3-5) 메일 본문 설정
mailMessage.setContent(content, "text/html; charset=UTF-8");
// 3-6) 메일 전송 날짜 및 시각 정보 설정
mailMessage.setSentDate(new Date());


//7. 메일 전송
// transport 클래스의 send() 메서드를 호출하여 보낼 수 있음. (파라미터 : Message 객체)
Transport.send(mailMessage);
// out.println("<h3>메일이 정상적으로 발송되었습니다.</h3>");
%>
<script>
alert("문의가 완료되었습니다.");
location.href = 'mailForm.jsp';
</script>

<%}catch(Exception e){
	e.printStackTrace();
	out.println("<h3>SMTP 서버 설정 또는 서비스 문제 발생!</h3>");
}
	


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>