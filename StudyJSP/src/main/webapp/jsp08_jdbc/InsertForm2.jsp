<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function checkId() {
		let id = document.fr.id.value;
		let result = document.getElementById("checkIdResult")
		if(id.length >= 4 && id.length <= 8 ){
			window.open("check_id.html", "checkId", "width=300, height=500");
			result.innerHTML = "중복확인완료";
		}else{
			alert("4~8글자만 사용가능합니다");
			result.innerHTML = "";
		}
	}//1번 문제.
	
	function passwdCheck(passwd){
		let result = document.getElementById("checkPasswdResult");
		if(passwd.length == 0){
			result.innerHTML = "";
		}else if(passwd.length >= 8 && passwd.length <= 16){
			result.innerHTML = "사용가능한 패스워드";
			result.style.color = "BLUE";
		}else{
			result.innerHTML = "사용 불가능한 패스워드";
			result.style.color = "RED";
		}
	}
	
	function passwdCheck2(passwd2) {
		let passwd = document.fr.passwd.value;
		let result = document.getElementById("checkConfirmPasswdResult");
		if(passwd.length == 0){
			result.innerHTML = "";
		}else if(passwd == passwd2){
			result.innerHTML = "비밀번호 일치";
			result.style.color = "BLUE";
		}else{
			result.innerHTML = "비밀번호 불일치";
			result.style.color = "RED";
		}
	}
	
	function  juminCheck() {
		jumin1 = document.fr.jumin1.value;
		
		if(jumin1.length == 6 ){
			document.fr.jumin2.focus();
		}
		
		jumin2 = document.fr.jumin2.value;
		if(jumin2.length == 7){
			document.fr.jumin2.blur();
		}
	}
	
		function emailCheck(value) {
		document.fr.email2.value = value;
		
		
		for(options of document.fr.emailSelected){
			if(options.selected && value == ""){
				options.disabled = true;
			}else{
				options.disabled = false;
				
			}
		}	
	}
		function hobbyCheck(){
		for(hobby of document.fr.hobby) {
			hobby.checked = document.fr.hobbyAll.checked;
		}
	}
		</script>


</head>
<body>
<h1>회원가입</h1>
<form action = "insertPro2.jsp" name="fr" method ="post">
	<table border="1">
		<tr>
			<td>이름</td>
			<td colspan="3"><input type="text" name="name"></td>
		</tr>	
	 	
	 	<tr>
	 		<td>ID</td>
	 		<td>
	 		<input type ="text"  name="id" placeholder="4~8글자 사이를 입력하세요.">
	 		<input type="button" value="중복확인" onclick="checkId()">
	 		<span id="checkIdResult"></span>
	 		</td>
	 	</tr>
	
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="passwd" placeholder="8~16글자 사이를 입력하세요." onkeyup="passwdCheck(this.value)"> 
			<span id="checkPasswdResult"></span></td>
		</tr>
		
		<tr>
			<td>비밀번호확인</td>
			<td><input type="password" name="passwd2"  onkeyup="passwdCheck2(this.value)"> 
			<span id="checkConfirmPasswdResult"></span></td>
		</tr>
		
		<tr>
			<td>주민등록번호</td>
			<td><input type="text" name ="jumin1" onkeyup="juminCheck()"> - 
				<input type="password" name ="jumin2" onkeyup="juminCheck()"></td>
		</tr>
		
		<tr>
			<td>이메일</td>
			<td><input type="text" name="email1">@<input type="text" name="email2" readonly="readonly">
				<select name="emailSelected" onchange="emailCheck(this.value)"> 
					<option value="" select="selected">이메일을 선택하세요</option>
					<option value ="naver.com">naver.com</option> 
					<option value = "nate.com">nate.com</option>
					<option value = "google.com">google.com</option>
			</select>
			</td>
		</tr>
		
		<tr>
			<td>직업</td>
			<td>
				<select name = "job">
					<option select="selected">항목을 선택하시오.</option>
					<option>개발자</option> 
					<option>선생님</option>
					<option>학생</option>
				</select>
			</td>
		</tr>		
	
		<tr>
			<td>성별</td>
			<td><input type="radio" name="gender" value ="남">남
					  <input type="radio" name="gender" value ="여">여
			</td>
		</tr>
	
		<tr>
			<td>취미</td>
			<td>
				<input name="hobby" type="checkbox" value ="여행">여행
				<input name="hobby" type="checkbox" value ="독서">독서
				<input name ="hobby"type="checkbox" value =게임">게임
				<input name ="hobbyAll" type="checkbox" onclick="hobbyCheck(this.value)">전체선택
			</td>
		</tr>
		
		<tr>
			<td>가입동기</td>
			<td><textarea rows="40" cols="10" name = "content"></textarea></td>
		</tr>
	
		<tr>
			<td colspan="2">
				<input type="submit" value="가입">
				<input type="reset" value="초기화">
				<input type="submit" value="돌아가기" onclick="history.back()">
			</td>
		</tr>
	</table>

</form>
</body>
</html>