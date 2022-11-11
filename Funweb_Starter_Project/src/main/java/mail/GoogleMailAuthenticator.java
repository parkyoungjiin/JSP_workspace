package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleMailAuthenticator extends Authenticator{
	//인증정보를 관리할 Pass
	private PasswordAuthentication passwordAuthentication;
	
	public GoogleMailAuthenticator() {
		passwordAuthentication = new PasswordAuthentication("pyjs18593", "spfvhsxxvpavkdos");
	}//생성자 끝

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		// TODO Auto-generated method stub
		return passwordAuthentication;
	}
}
