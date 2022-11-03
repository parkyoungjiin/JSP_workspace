package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DB.JdbcUtil;

public class BoardDAO {
	Connection con = null;
	PreparedStatement pstmt = null, pstmt2 = null;
	ResultSet rs = null;
	
	public int insertBoard(BoardDTO board) {
		int insertCount = 0;
		con = JdbcUtil.getConnection();
		
		
		
		try {
			String sql = "SELECT MAX(idx) FROM board";
			int idx = 1; // 새 글 번호
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { 
				 //true -> 조회결과가 있을 경우 (= 게시물이 하나라도 존재할 경우)
				 //존재하지 않을 경우 rs.next는 false , DB에서는 NULL이 표기된다.
				idx = rs.getInt(1) + 1;
			}
			System.out.println("새글 번호 :" + idx);
			// 게시물 등록 작업 insert
			sql = "INSERT INTO board VALUES(?,?,?,?,?,now(),0)";
			pstmt2 = con.prepareStatement(sql);
			
			pstmt2.setInt(1,idx); // 생성한 새 글 번호 확인
			pstmt2.setString(2, board.getName());
			pstmt2.setString(3, board.getPass());
			pstmt2.setString(4, board.getSubject());
			pstmt2.setString(5, board.getContent());
			
			insertCount = pstmt2.executeUpdate();
			
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - insertBoard()");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(pstmt2);
			JdbcUtil.close(con);
		}
		return insertCount;
		
	}//insertBoard 끝
	
	public int selectListCount() {
		int selectCount = 0;
		
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT COUNT(idx) FROM board";
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
	
	public List<BoardDTO> selectBoardList() {
		List<BoardDTO> boardlist = null;
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM board ORDER BY idx DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			boardlist = new ArrayList<BoardDTO>();
			// 1개 레코드를 저장할 DTO 객체를 생성
			
			while(rs.next()) { 
				BoardDTO board = new BoardDTO();
				
				board.setIdx(rs.getInt("idx"));
				board.setName(rs.getString("name"));
				board.setPass(rs.getString("pass"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setDate(rs.getTimestamp("date"));
				board.setReadcount(rs.getInt("readcount"));
				System.out.println(board);
				
				boardlist.add(board);
				
			}
			
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectBoardList()");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return boardlist;
	}//selectBoardList 끝
	public List<BoardDTO> selectBoardList(int startRow, int listLimit) {//오버로딩
		List<BoardDTO> boardlist = null;
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM board ORDER BY idx DESC LIMIT ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);
			rs = pstmt.executeQuery();
			
			boardlist = new ArrayList<BoardDTO>();
			// 1개 레코드를 저장할 DTO 객체를 생성
			
			while(rs.next()) { 
				BoardDTO board = new BoardDTO();
				
				board.setIdx(rs.getInt("idx"));
				board.setName(rs.getString("name"));
				board.setPass(rs.getString("pass"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setDate(rs.getTimestamp("date"));
				board.setReadcount(rs.getInt("readcount"));
				System.out.println(board);
				
				boardlist.add(board);
				
			}
			
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectBoardList()");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return boardlist;
	}//selectBoardList 끝
}
