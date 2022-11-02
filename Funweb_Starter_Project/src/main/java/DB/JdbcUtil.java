package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//DB 접근 작업 준비 및 해제, 자원반환 작업을 공통으로 수행하는 클래스 생성
public class JdbcUtil {
	//1. Connection 객체 생성하는 getConnection 메서드 정의
	public static Connection getConnection() {
		Connection con = null;
		//0단계 :DB연결에 필요한 
		String driver = "com.mysql.cj.jdbc.Driver";
	    String url = "jdbc:mysql://localhost:3306/funweb5";
	    String user = "root";
	    String password = "1234";
		
	    
	    //1단계. 드라이버 연결
	    try {
			Class.forName(driver);

			// 2단계. DB 연결
			// => 연결 성공 시 java.sql.Connection 타입 객체 리턴됨
			con = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 클래스 로드 실패");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("DB 연결 실패");
			e.printStackTrace();
		}
        
		return con;
	}//getConnection 메서드 끝
	
	//2. close() 메서드 정의 (자원반환을 공통으로 수행)
	public static void close(Connection con) {
		try {
			if(con != null) {
				con.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//close 끝
	public static void close(PreparedStatement pstmt) {
		try {
			if(pstmt != null) {
				pstmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//close 끝
	public static void close(ResultSet rs) {
		try {
			if(rs != null) {
			rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//close 끝
	
}
