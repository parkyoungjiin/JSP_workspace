package jsp09_jdbc_dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.cj.protocol.Resultset;

public class Jsp8_2DAO {
	public int insert(Jsp8_2DTO dto) {
		String driver = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/study_jsp";
		String user = "root";
		String password = "1234";
		
		Connection con = null;
		PreparedStatement pstmt = null;
		int insertCount = 0;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			
			String sql = "INSERT INTO jsp8_2 VALUES(?,?,?,?,?,?,?,?,?,now())";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getPasswd());
			pstmt.setString(4, dto.getJumin());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getJob());
			pstmt.setString(7, dto.getGender());
			pstmt.setString(8, dto.getHobby());
			pstmt.setString(9, dto.getContent());
			
			insertCount = pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 연결 실패");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("DB 연결 실패 혹은 구문 작성 오류");
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return insertCount;
	}//insert 끝
	
	public ArrayList select() {
		String driver = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/study_jsp";
		String user = "root";
		String password = "1234";
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList jspList = null;
		
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			
			String sql = "SELECT * FROM jsp8_2 WHERE = ?";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			//전체 레코드를 저장할 객체 생성
			jspList = new ArrayList();
			
			while(rs.next()) {
				//변수 선언해서 값을 가져옴
				String name = rs.getString("name");
				String id = rs.getString("id");
				String passwd = rs.getString("passwd");
				String jumin = rs.getString("jumin");
				String email = rs.getString("email");
				String job = rs.getString("job");
				String gender = rs.getString("gender");
				String hobby = rs.getString("hobby");
				String content = rs.getString("content");
				
				//1개 레코드 정보를 저장할 Jsp8_2DTO객체 생성 후 데이터 저장 (set으로 get한 것을 저장)
				Jsp8_2DTO dto = new Jsp8_2DTO();
				dto.setName(name);
				dto.setId(id);
				dto.setPasswd(passwd);
				dto.setJumin(jumin);
				dto.setEmail(email);
				dto.setJob(job);
				dto.setGender(gender);
				dto.setHobby(hobby);
				dto.setContent(content);
				
				
				//위의 2문장을 다른 형식으로 적을 수 있음.
				
				
				//전체 레코드를 저장하는 ArrayList 객체에 1개 레코드 저장
				jspList.add(dto);
				
			}
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 연결 실패");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("DB 연결 실패 혹은 구문 작성 오류");
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
	return jspList;
	}
}
