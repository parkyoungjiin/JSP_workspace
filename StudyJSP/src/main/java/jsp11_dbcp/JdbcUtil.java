package jsp11_dbcp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

//DB 접근 작업 준비 및 해제, 자원반환 작업을 공통으로 수행하는 클래스 생성
public class JdbcUtil {
	//1. Connection 객체 생성하는 getConnection 메서드 정의
	public static Connection getConnection() {
		//context.xml에 설정된 DBCP로 부터 Connection 객체를 가져와 리턴
		
		Connection con = null;
		
		
		try {
			//1. context.xml 파일 내의 <Context> 태그에 해당하는 부분 가져옴.
			Context initCtx = new InitialContext(); // 업캐스팅 ( 클래스명이 다름 ! )
			
			//2. Resource 태그 부분 가져오기
			//=> Context 객체의 lookup() 메서드 호출하여 "java:comp/env" 문자열 전달
//		Context envCtx = (Context)initCtx.lookup("java:comp/env"); // 다운캐스팅 (리턴타입이 오브젝트 -> Context)
			
			//3. Resource 태그 내 name속성( = 리소스 이름 jdbc/MySQL)을 가져오기 위해 envCtx의 lookup() 을 통해 리소스 이름 전달
			//DataSource는 type 속성에 지정된 객체명임. 
//		DataSource ds = (DataSource)envCtx.lookup("jdbc/MySQL");
			
			
			// ** 참고 2,3번 과정을 하나의 문장으로 결합**
			DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/MySQL");
			
			//4. DataSource 객체(=커넥션 풀)로부터 미리 생성된 Connection 객체 가져오기
			
			//5. (옵션) 
			//=> JDBC 사용 시 Auto Commit 기능이 동작되도록 설정되어 있는데, 이를 해제
//			con.setAutoCommit(false); // Auto Commit 해제
			con = ds.getConnection();
		} catch (NamingException e) { //이름이 틀리면 나옴
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return con;
	
	
	}//getConnection 메서드 끝
	
	//2. close() 메서드 정의 (자원반환을 공통으로 수행)
	public static void close(Connection con) {
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//close 끝
	public static void close(PreparedStatement pstmt) {
		try {
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//close 끝
	public static void close(ResultSet rs) {
		try {
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//close 끝
	
}
