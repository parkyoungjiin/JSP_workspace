package jsp09_jdbc_dao;

public class exDTO {
	String id;
	String name;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "exDTO [id=" + id + ", name=" + name + "]";
	} 
	
	

}//exDTO 끝
