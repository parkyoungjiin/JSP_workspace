package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.cj.protocol.Resultset;

import db.JdbcUtil;
import vo.BoardBean;
import vo.MemberBean;

// 실제 비즈니스 로직을 수행하는 BoardDAO 클래스 정의
// => 각 Service 클래스 인스턴스에서 BoardDAO 인스턴스에 접근 시 고유 데이터가 불필요하므로
//    BoardDAO 인스턴스는 애플리케이션에서 단 하나만 생성하여 공유해도 된다!
//    따라서, 싱글톤 디자인 패턴을 적용하여 클래스를 정의하면 메모리 낭비를 막을 수 있다!
public class MemberDAO {
	// ------------ 싱글톤 디자인 패턴을 활용한 BoardDAO 인스턴스 생성 작업 -------------
	// 1. 외부에서 인스턴스 생성이 불가능하도록 생성자를 private 접근제한자로 선언
	// 2. 자신의 클래스 내에서 직접 인스턴스를 생성하여 멤버변수에 저장
	//    => 인스턴스 생성없이 클래스가 메모리에 로딩될 때 함께 로딩되도록 static 변수로 선언
	//    => 외부에서 접근하여 함부로 값을 변경할 수 없도록 private 접근제한자로 선언
	// 3. 생성된 인스턴스를 외부로 리턴하는 Getter 메서드 정의
	//    => 인스턴스 생성없이 클래스가 메모리에 로딩될 때 함께 로딩되도록 static 메서드로 선언
	//    => 누구나 접근 가능하도록 public 접근제한자로 선언
	private MemberDAO() {}
	
	private static MemberDAO instance = new MemberDAO();

	public static MemberDAO getInstance() {
		return instance;
	}
	// ----------------------------------------------------------------------------------
	// 데이터베이스 접근에 사용할 Connection 객체를 Service 객체로부터 전달받기 위한
	// Connection 타입 멤버변수 선언 및 Setter 메서드 정의
	private Connection con;

	public void setConnection(Connection con) {
		this.con = con;
	}
	// ----------------------------------------------------------------------------------

	public int insertMember(MemberBean member) {
		System.out.println("회원정보 등록작업(DB)");
		int insertCount = 0;
		
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO member VALUES(?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getId());
			pstmt.setString(3, member.getPasswd());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getGender());

			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - Insertmember");
			e.printStackTrace();
		}
		
		
		
		return insertCount;
	}

	public int selectMember(MemberBean member) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int selectCount = 0;
		String sql = "SELECT * FROM member WHERE id =? AND passwd =?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				selectCount++;
			}
		} catch (SQLException e) {
			System.out.println("selectMember 실패 ");
			e.printStackTrace();
		}
		
		
		
		return selectCount;
	}
//--------------------------- 전체 회원 목록을 가져오는 메서드 ------------------------------
	public List<MemberBean> selectMemberList() {
		List<MemberBean> memberList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			memberList = new ArrayList<MemberBean>();
			while(rs.next()) {
				
				MemberBean member = new MemberBean();
				member.setName(rs.getString("name"));
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setEmail(rs.getString("email"));
				member.setGender(rs.getString("gender"));
				member.setDate(rs.getDate("date"));
				memberList.add(member);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return memberList;
	}

	
	
	
	
	
	
	
}












