package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DB.JdbcUtil;

public class FileBoardDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt2 = null;
	ResultSet rs = null;
	
	public int FileBoardInsert(FileBoardDTO fileboard) {
		int insertCount = 0;
		int idx = 1;
		con = JdbcUtil.getConnection();
		
		
		try {
			String sql = "SELECT MAX(idx) FROM file_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				idx = rs.getInt(1) + 1;
			}

			sql = "INSERT INTO file_board VALUES(?,?,?,?,?,?,?,now(),?)";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, idx);
			pstmt2.setString(2, fileboard.getName());
			pstmt2.setString(3, fileboard.getPass());
			pstmt2.setString(4, fileboard.getSubject());
			pstmt2.setString(5, fileboard.getContent());
			pstmt2.setString(6, fileboard.getOriginal_file());
			pstmt2.setString(7, fileboard.getReal_file());
			pstmt2.setInt(8, fileboard.getReadcount());
			
			insertCount = pstmt2.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - FileBoardinsert");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(pstmt2);
			JdbcUtil.close(con);
		}
		
		return insertCount;
	
	}//FileBoardInsert 끝
	// --------------------------------게시판에 뿌리는 메서드 -------------------------------------------------
	
	public List<FileBoardDTO> FileBoardSelect(int startRow, int listLimit, String keyword){
		con = JdbcUtil.getConnection();
		List<FileBoardDTO> fileList = null;
		
		String sql = "SELECT * FROM file_board WHERE subject LIKE ? ORDER BY idx DESC LIMIT ?,?";
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, listLimit);
			rs = pstmt.executeQuery();
			
			fileList = new ArrayList<FileBoardDTO>();
			
			while(rs.next()) {
				FileBoardDTO fileboard = new FileBoardDTO();
				
				fileboard.setIdx(rs.getInt(1));
				fileboard.setSubject(rs.getString("subject"));
				fileboard.setName(rs.getString("name"));
				fileboard.setDate(rs.getTimestamp("date"));
				fileboard.setReadcount(rs.getInt("readcount"));
				
				fileList.add(fileboard);
				System.out.println(fileboard);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - FIleBoardSelect 끝");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return fileList;
		
	}//
	public int selectListCount() {
		int selectCount = 0;
		
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT COUNT(idx) FROM file_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { 
				selectCount = rs.getInt(1);
			}
			
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectListCount()");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		return selectCount;
	
	}//selectListCount 끝
	
	public FileBoardDTO selectContent(int idx) {
		FileBoardDTO fileboard = null;
		con = JdbcUtil.getConnection();
		String sql = "SELECT * FROM file_board WHERE idx = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				fileboard = new FileBoardDTO();
				
				fileboard.setIdx(idx);
				fileboard.setName(rs.getString("name"));
				fileboard.setDate(rs.getTimestamp("date"));
				fileboard.setReadcount(rs.getInt("readcount"));
				fileboard.setSubject(rs.getString("subject"));
				fileboard.setOriginal_file(rs.getString("original_file"));
				fileboard.setReal_file(rs.getString("real_file"));
				fileboard.setContent(rs.getString("content"));
			}
		} catch (SQLException e) {
			System.out.println("SQL구문 오류 - selectContent");
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return fileboard;
	}//selectContent - idx값을 통해 DTO 조회
	
	public String selectRealFile(int idx) {
		con = JdbcUtil.getConnection();
		String realFile = null;
		String sql = "SELECT real_file FROM file_board WHERE idx = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				realFile = rs.getString(1);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectRealFile");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
			
		return realFile;
	}
	//첫 페이지에 최근 5개 게시물만 나타내는 메서드
	public List<FileBoardDTO> selectRecentBoardList(){
		List<FileBoardDTO> recentList = null;
		con = JdbcUtil.getConnection();
		
		String sql = "SELECT idx, name, subject, date FROM file_board ORDER BY idx DESC LIMIT 5";
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			recentList = new ArrayList<FileBoardDTO>();
			while(rs.next()) {
				FileBoardDTO fileboard = new FileBoardDTO();
				fileboard.setIdx(rs.getInt("idx"));
				fileboard.setSubject(rs.getString("subject"));
				fileboard.setName(rs.getString("name"));
				fileboard.setDate(rs.getTimestamp("date"));
				
				recentList.add(fileboard);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectRecentBoardList");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
			
		}
		return recentList;
	}
	public int FileBoardDelete(int idx, String pass) {
		int deleteCount = 0;
		
		con = JdbcUtil.getConnection();
		
		String sql = "DELETE FROM file_board WHERE idx = ? AND pass = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, idx);
			pstmt.setString(2, pass);
			
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - FileBoardDelete");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return deleteCount;
		
	} //FileBoardDelete 끝 - 게시글 삭제 메서드
	
	public int FileBoardUpdate(FileBoardDTO fileboard) { // update 구문
		
		int updateCount = 0;
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "UPDATE file_board SET subject =?, content =?, original_file=?, real_file=? WHERE idx = ? AND pass = ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, fileboard.getSubject());
			pstmt.setString(2, fileboard.getContent());
			pstmt.setString(3, fileboard.getOriginal_file());
			pstmt.setString(4, fileboard.getReal_file());
			pstmt.setInt(5, fileboard.getIdx());
			pstmt.setString(6, fileboard.getPass());
			
			updateCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - update");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return updateCount;
		
		
		
	}//FileBoardUpdate 끝
}
