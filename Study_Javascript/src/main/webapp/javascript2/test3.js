/**
 * 
 */
 // 외부로부터 아이디, 패스워드를 전달받아 판별하는 login() 함수 정의
 
 
 function login(id, password){
	if(id == "admin" && password == "1234"){
		document.write("로그인 성공" + "<br>");
	}else{
		document.write("로그인 실패" + "<br>");
	}
}