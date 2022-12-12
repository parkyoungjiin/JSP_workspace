package encrypt;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MyMessageDigest {
	private String hashAlgorithm = ""; // 해싱 알고리즘명 저장할 변수(믹서기브랜드)

	
	//파라미터 생성자 정의
	// => 암호화 알고리즘명을 전달받아 초기화
	public MyMessageDigest(String hashAlgorithm) {
		this.hashAlgorithm = hashAlgorithm;
	}
	
	//해싱(=단방향 암호화) 작업을 수행할 hashing() 메서드 정의
	public String hashing(String strPlainText) {
		String strCipherText = ""; //암호화 결과를 문자열(= 암호문)을 저장할 변수 
		try {
			MessageDigest md = MessageDigest.getInstance(hashAlgorithm);
			
			// 평문이 저장된 객체의 getBytes() 메서드를 호출하여
			// 평문-> byte[]타입으로 변환
			byte[] byteData= strPlainText.getBytes();
			
			md.update(byteData);
			
			byte[] digestResult = md.digest();
			
			for(int i = 0 ; i<digestResult.length; i++) {
				
			}
		} catch (NoSuchAlgorithmException e) {
			System.out.println(hashAlgorithm + "알고리즘이 존재하지 않습니다.");
			e.printStackTrace();
		}
		
		return strCipherText;
	}
	
	
}
