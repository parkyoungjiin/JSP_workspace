package jsp09_jdbc_dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Jsp8_2DAO {
	public int insert(Jsp8_2DTO dto) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		int insertCount = 0;
		try {
			con = JdbcUtil.getConnection();
			
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
		} catch (SQLException e) {
			System.out.println("SQL구문 작성 오류");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
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
			con = JdbcUtil.getConnection();
			
			String sql = "SELECT * FROM jsp8_2";
			
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
		} catch (SQLException e) {
			System.out.println("SQL구문 작성 오류");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
			
		}
		
	return jspList;
	}
	public Jsp8_2DTO selectDetail(String id) {
		Jsp8_2DTO dto = null;
		
	  
	   Connection con = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   
	   try {
		   con = JdbcUtil.getConnection();

		   
		   String sql = "select * from jsp8_2 where id =?";
		   
		    pstmt = con.prepareStatement(sql);
		    pstmt.setString(1, id);
		    rs = pstmt.executeQuery();
		   
		   while(rs.next()){
			   dto = new Jsp8_2DTO();
			  dto.setName(rs.getString("name")); 
			  dto.setId(rs.getString("id"));
			  dto.setPasswd(rs.getString("passwd"));
			  dto.setJumin(rs.getString("jumin"));
			  dto.setEmail(rs.getString("email"));
			  dto.setJob(rs.getString("job"));
			  dto.setGender(rs.getString("gender"));
			  dto.setHobby(rs.getString("hobby"));
			  dto.setContent(rs.getString("content"));
			  dto.setHire_date(rs.getDate("hire_date"));
			  
			  
		   
		   }
		} catch (SQLException e) {
			System.out.println("SQL구문 작성 오류");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
			
		}
		return dto;
		
	}//selectDetail 끝
	
	public int delete(String id) {
	      // JDBC 작업 4단계.
	      // 0단계. DB 연결에 필요한 정보 문자열 4가지를 변수에 별도로 저장
	    Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;
	      try {
	    	 //jdbcUtil 불러오기
	    	 con = JdbcUtil.getConnection();
	         String sql = "DELETE FROM jsp8_2 WHERE id=?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setString(1, id);
	         
	         result = pstmt.executeUpdate();
	      } catch (SQLException e) {
	         System.out.println("SQL문장 오류!");
	         e.printStackTrace();
	      } finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
			
		}
	      
	      return result;
	   }
	
	public boolean login(String id, String password) {
		boolean isLoginSuccess = false;
		//JDBC 1, 2단계
		Connection con = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;

		con = JdbcUtil.getConnection();
		
		//3단계 : 아이디, 패스워드 일치하는 레코드 조회
		String sql = "SELECT * FROM jsp8_2 where id = ? AND passwd = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id); // dto.getId() 
			pstmt.setString(2, password); // dto.getPasswd()
			
		    rs = pstmt.executeQuery();
		    
		    if(rs.next()) {
		    	isLoginSuccess = true;
		    }
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류");
			e.printStackTrace();
		}
		
		
		return isLoginSuccess;
		
	}
}
