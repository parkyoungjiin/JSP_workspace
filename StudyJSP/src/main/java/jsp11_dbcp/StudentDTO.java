package jsp11_dbcp;

public class StudentDTO {
	
	//1. 데이터를 저장하는데 필요한 멤버변수 선언
	private int idx;
	private String name; //Varchar을 String으로 표현
	
	//2. 멤버변수에 저장할 getter/setters 메서드 정의 
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
	
