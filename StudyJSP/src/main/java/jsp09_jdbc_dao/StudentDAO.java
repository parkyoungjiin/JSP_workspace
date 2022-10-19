package jsp09_jdbc_dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

// DAO(Data Access Object, 데이터 접근 객체) 역할을 수행할 StudentDAO 클래스 정의
// => 데이터베이스 접근, 자원 반환, 각 SQL 구문을 실행할 메서드 정의
public class StudentDAO {
	// < 메서드 정의 기본 문법 >
	// [제한자] 리턴타입 메서드명([매개변수...]) {}
	
	// insertForm.jsp 페이지에서 전달받은 데이터를 저장한 StudentDTO 객체를 전달받아
	// 데이터를 student 테이블에 추가(INSERT)하는 insert() 메서드 정의
	// => 파라미터 : StudentDTO 객체(student), 리턴타입 : int(insertCount)
	public int insert(StudentDTO student) {
		System.out.println("StudentDAO - insert()");
		
		int insertCount = 0;
		
		// 데이터베이스 작업에 필요한 클래스 타입 변수 선언
		// => try, catch, finally 블록 등 여러 블록에 걸쳐 변수를 사용하기 위함
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			// JDBC 작업 4단계.
			// 0단계. DB 연결에 필요한 정보 문자열 4가지를 변수에 별도로 저장
			String driver = "com.mysql.cj.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/study_jsp";
			String user = "root";
			String password = "1234";
			
			// 1단계. JDBC 드라이버 로드
			Class.forName(driver);
			
			// 2단계. DB 연결
			// => 연결 성공 시 java.sql.Connection 타입 객체 리턴됨
			con = DriverManager.getConnection(url, user, password);
			
			// study_jsp5 데이터베이스의 student 테이블에 데이터 추가(INSERT)
			// => 리턴되는 추가 작업 결과 변수(count)에 저장
			String sql = "INSERT INTO student VALUES (?,?)";
			pstmt = con.prepareStatement(sql);
			// 만능문자를 치환할 데이터는 StudentDTO 객체에 저장되어 있음 => Getter 사용
			pstmt.setInt(1, student.getIdx()); // idx 데이터 가져와서 전달
			pstmt.setString(2, student.getName()); // name 데이터 가져와서 전달
			
			// SQL 구문 실행 후 리턴되는 결과값(int 타입)을 변수에 저장 후 리턴
			insertCount = pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로드 실패!");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("DB 연결 실패 또는 SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			// 데이터베이스 자원을 반환하기 위한 코드 작성하는 블럭
			// => Connection, PreparedStatement, ResultSet 등의 객체의 close() 메서드 호출
			//    단, 객체를 생성한 순서의 역순으로 반환해야함
			try {
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return insertCount; // insertPro.jsp 로 리턴
	}
	
	// 회원 목록 조회 작업을 수행하는 select() 메서드 정의
	// => 파라미터 : 없음    리턴타입 : java.util.ArrayList
	public ArrayList select() {
		// JDBC 4단계
		// 0단계. 데이터베이스 작업에 필요한 String 타입 변수 4개 선언
		String driver = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/study_jsp";
		String user = "root";
		String password = "1234";
		
		// 데이터베이스 작업에 사용되는 객체 타입 변수 선언
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList studentList = null;
		
		try {
			// 1단계. 드라이버 클래스 로드
			Class.forName(driver);
			
			// 2단계. DB 연결
			con = DriverManager.getConnection(url, user, password);
			
			// 3단계. SQL 구문 작성 및 전달
			// SELECT 구문을 사용하여 student 테이블의 모든 레코드 검색
			String sql = "SELECT * FROM student";
			pstmt = con.prepareStatement(sql);
			
			// 4단계. SQL 구문 실행 및 결과 처리
			rs = pstmt.executeQuery();
			
			// 전체 레코드를 저장할 ArrayList 객체 생성
			// => 반복문(while) 내에서 생성되는 StudentDTO 객체를 반복 저장해야하므로
			//    while 문 보다 윗쪽(앞쪽)에서 객체를 생성해야한다!
			
			studentList = new ArrayList();
			// while 문을 사용하여 다음 레코드가 존재할 동안 반복
			while(rs.next()) {
				// 각 레코드의 컬럼 데이터를 가져와서 변수에 저장 후 출력
				int idx = rs.getInt("idx");
				String name = rs.getString("name");
//				System.out.println(idx + ", " + name);
				// => 위의 변수들을 모으면 1개 레코드에 해당하는 데이터가 됨
				//    따라서, 1개 레코드를 관리할 수 있는 StudentDTO 객체에 저장 가능
				// StudentDTO 객체(student) 생성 후 데이터 저장
				StudentDTO student = new StudentDTO();
				student.setIdx(idx);
				student.setName(name);
				
				// 전체 레코드를 저장 가능한 ArrayList 객체에 
				// 1개 레코드가 저장된 StudentDTO 객체 추가(저장)
				studentList.add(student); // StudentDTO -> Object 타입으로 업캐스팅 됨
			}
			
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로드 실패!");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("DB 연결 실패 또는 SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			// 예외 발생 여부와 관계없이 무조건 마지막에 실행되는 블록
			// => 데이터베이스 작업에 사용된 객체(자원)를 반환하는 작업은 항상 수행되어야 함
			try {
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		// 전체 레코드가 저장된 ArrayList 객체 리턴 => select.jsp
		return studentList;
		
	}
	
}















