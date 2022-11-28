package vo;

//포워딩 정보를 관리하는 클래스 정의 ( 주소 ) 
public class ActionForward {
	
	private String path; // 주소 (URL)
	
	private boolean isRedirect; // 포워딩 방식(True 일 때 redirect, false 일 때 dispatch)

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public boolean isRedirect() {
		return isRedirect;
	}

	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}
	
	
}
