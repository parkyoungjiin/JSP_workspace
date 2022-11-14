package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DB.JdbcUtil;

public class freeDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt2 = null;
	ResultSet rs = null;
	
	
//	----------------전체 게시물 개수 조회----------------------------
	public int selectListCount() {
		int selectCount = 0;
		con = JdbcUtil.getConnection();
		// 연결하는데 , JDBcutil 클래스의 getConnection 메서드를 통해 연결
		
		String sql = "SELECT COUNT(*) FROM free_board";
		//실행
		try {
			pstmt = con.prepareStatement(sql);
			
			//결과 저장
			rs = pstmt.executeQuery();
			
			//rs에 저장된 값을 출력
			if(rs.next()) {
				selectCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return selectCount;
	}//selectListCount 끝
	
	
//	-------------------게시판 목록 뿌리는 메서드-------------------------------
	public List<freeDTO> selectList(int startRow, int listLimit, String keyword){ // LIMIT : startRow, listLimit / LIKE : keyword 
		List<freeDTO> freeList  =null;
		con = JdbcUtil.getConnection();
		
		String sql = "SELECT * FROM free_board WHERE subject LIKE ? ORDER BY idx DESC LIMIT ?,?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, listLimit);
			
			rs = pstmt.executeQuery();
			
			//DTO의 값들을 저장할 리스트 선언
			freeList = new ArrayList<freeDTO>();
			
			while(rs.next()) {
				freeDTO freeboard = new freeDTO();
				
				freeboard.setIdx(rs.getInt(1));
				freeboard.setSubject(rs.getString("subject"));
				freeboard.setName(rs.getString("name"));
				freeboard.setDate(rs.getTimestamp("date"));
				freeboard.setReadcount(rs.getInt("readcount"));
				
				freeList.add(freeboard);
				
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectList");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
				
		return freeList;
	}//selectList 끝
//	-------------------------------- 게시글 등록 (글쓰기) ----------------------------------
	public int FreeBoardInsert(freeDTO freeboard) {
		int insertCount = 0;
		int idx = 1;
		con = JdbcUtil.getConnection();
		
		
		try {
			//1. 게시물 번호 : idx 최대값을 조회한 뒤, 그 값에 1을 더해주면 자동으로 1씩 증가함.
			String sql = "SELECT MAX(idx) FROM free_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				idx = rs.getInt(1) + 1;
			}
			//2. 게시글 등록
			sql = "INSERT INTO free_board VALUES(?,?,?,?,?,?,?,now(),?)";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, idx);
			pstmt2.setString(2, freeboard.getName());
			pstmt2.setString(3, freeboard.getPass());
			pstmt2.setString(4, freeboard.getSubject());
			pstmt2.setString(5, freeboard.getContent());
			pstmt2.setString(6, freeboard.getOriginal_file());
			pstmt2.setString(7, freeboard.getReal_file());
			pstmt2.setInt(8, freeboard.getReadcount());
			
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

	public freeDTO FreeSelectContent(int idx) {
		freeDTO freeboard = null;
		con = JdbcUtil.getConnection();
		String sql = "SELECT * FROM free_board WHERE idx = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				freeboard = new freeDTO();
				freeboard.setIdx(rs.getInt("idx"));
				freeboard.setName(rs.getString("name"));
				freeboard.setDate(rs.getTimestamp("date"));
				freeboard.setReadcount(rs.getInt("readcount"w));
				freeboard.setSubject(rs.getString("subject"));
				freeboard.setOriginal_file(rs.getString("original_file"));
				freeboard.setReal_file(rs.getString("real_file"));
				freeboard.setContent(rs.getString("content"));
			}
		} catch (SQLException e) {
			System.out.println("SQL구문 오류");
			e.printStackTrace();
		}
		
		
		
		
		return freeboard;
		
	}

}
