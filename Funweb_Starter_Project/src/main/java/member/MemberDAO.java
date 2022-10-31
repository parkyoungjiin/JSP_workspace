package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
	
	public MemberDTO selectMember(String id) {
		MemberDTO member = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			// 아이디가 일치하는 레코드 검색
			String sql = "SELECT * FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			// 조회 결과 레코드가 존재할 경우 MemberDTO 객체에 저장
			if(rs.next()) {
				// MemberDTO 객체 생성
				member = new MemberDTO();
				
				// MemberDTO 객체에 조회 결과 각 컬럼 데이터 저장
				member.setId(rs.getString("id"));
				member.setPass(rs.getString("pass"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setMobile(rs.getString("mobile"));
				member.setPost_code(rs.getString("post_code"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setPhone(rs.getString("phone"));
				member.setDate(rs.getDate("date"));
//				System.out.println(member.toString());
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생! - loginMember()");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return member;
	}
	
	public List<MemberDTO> select_admin() {
		List<MemberDTO> memberList = null;
		MemberDTO member = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		con = JdbcUtil.getConnection();
		try {
			
			String sql = "SELECT * FROM member";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			memberList = new ArrayList<MemberDTO>();
			while(rs.next()) {
				member = new MemberDTO();
				
				member.setId(rs.getString("id"));
				member.setPass(rs.getString("pass"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setMobile(rs.getString("mobile"));
				member.setPost_code(rs.getString("post_code"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setPhone(rs.getString("phone"));
				member.setDate(rs.getDate("date"));
				memberList.add(member);
			}
			
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		return memberList;
	}
	//로그인 판별, 게시물 수정 권한 여부 판별 -> dao에서 true, false를 판별한 값을 각 pro 파일에서 각각의 변수를 선언하여 메서드를 재사용할 수 있
	
	public boolean isRightUser(MemberDTO member) {
		boolean isRightUser = false;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		con = JdbcUtil.getConnection();
		
		String sql = "SELECT * FROM member WHERE id= ? AND pass = ?";
		
		//1,2 단계 수행 (연결)
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				isRightUser = true;
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류");
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
			
		}
		
		
		return isRightUser; 
	}//isRightUser 끝
	
	public int updateMember(MemberDTO member, boolean isChangePass) {
		int upDateCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		con = JdbcUtil .getConnection();
		try {
			if(isChangePass) {
				String sql = "UPDATE member SET pass = ?, name = ?, email = ?, post_code = ?, address1 = ?, phone =?, mobile=? WHERE id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, member.getPass());
				pstmt.setString(2, member.getName());
				pstmt.setString(3, member.getEmail());
				pstmt.setString(4, member.getPost_code());
				pstmt.setString(5, member.getAddress1());
				pstmt.setString(6, member.getAddress2());
				pstmt.setString(7, member.getPhone());
				pstmt.setString(8, member.getMobile());
				pstmt.setString(9, member.getId());
				
			}else {
				String sql = "UPDATE member SET name = ?, email = ?, post_code = ?, address1 = ?, phone =?, mobile=? WHERE id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, member.getName());
				pstmt.setString(2, member.getEmail());
				pstmt.setString(3, member.getPost_code());
				pstmt.setString(4, member.getAddress1());
				pstmt.setString(5, member.getAddress2());
				pstmt.setString(6, member.getPhone());
				pstmt.setString(7, member.getMobile());
				pstmt.setString(8, member.getId());
			}
			upDateCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL구문 오류");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
			
		}
		
		
		
		return upDateCount;
	}//update 끝
	
	public int deleteMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int deleteCount = 0;
		
		try {
			con = JdbcUtil .getConnection();
			String sql = "DELETE FROM member WHERE ID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL구문 오류");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
			
		}
		
		
		return deleteCount;
	}
}
