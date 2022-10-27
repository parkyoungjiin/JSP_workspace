package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import DB.JdbcUtil;

public class MemberDAO {
	public int insertMember(MemberDTO dto) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int insertMember = 0;
		
		try {
			con = JdbcUtil .getConnection();
			String sql = "INSERT INTO member VALUES(?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPass());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getPost_code());
			pstmt.setString(6, dto.getAddress1());
			pstmt.setString(7, dto.getAddress2());
			pstmt.setString(8, dto.getPhone());
			pstmt.setString(9, dto.getMobile());
			
			insertMember = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL구문 오류");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
			
		}
		
		
		return insertMember;
		
	}//insertMember 끝
	
	public boolean login(String id, String password) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean isLoginSuccess = false;
		con = JdbcUtil.getConnection();
		String sql = "SELECT * FROM member WHERE id= ? AND pass = ?";
		
		//1,2 단계 수행 (연결)
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
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
