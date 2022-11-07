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
	//-----------------검색 기능 추가------------------------
	public int selectListCount(String keyword) {
		int selectCount = 0;
		
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT COUNT(idx) FROM board WHERE keyword LIKE ? LIMIT 10";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+ keyword +"%");
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
	
	//-------------------------------검색 기능 추가한 select -----------------------------------------
	public List<BoardDTO> selectBoardList(int startRow, int listLimit, String keyword) {//오버로딩
		List<BoardDTO> boardlist = null;
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM board WHERE subject LIKE ? ORDER BY idx DESC LIMIT ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, listLimit);
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
	
	//-------------------------notice에서 클릭했을 때 notice_content (내용) 을 보여주는 메서드 ----------------------------------
	public BoardDTO selectBoard(int idx) {
		BoardDTO board = null;
		con = JdbcUtil.getConnection();
		String sql = "SELECT * FROM board WHERE idx = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery(); //rs에 저장
			
			if(rs.next()) {
				board = new BoardDTO(); // 객체만 만들기(선언을 해버리면 return을 if문에 넣어야 하기에, 오류가 발생할 수 있음.)
				board.setIdx(idx);
				board.setName(rs.getString("name"));
				board.setPass(rs.getString("pass"));
				board.setSubject(rs.getString("subject"));
				//textArea에 표시할 데이터는 문자열 치환(replace) 기느을 통해 줄바꿈 기호를 "<br>" 로 치환
				//방법 : 저장할 때 br로, 꺼낼 때 br로
				// 줄바꿈 기호를 찾는 메서드 존재. (System.getProperty("line.separator")
				// => replace는 char 혹은 String 한 개, replaceAll : regex 찾을 문자열을 바꿀 문자열로 모두 변환 
				board.setContent(rs.getString("content"));
//				board.setContent(rs.getString("content").replaceAll(System.getProperty("line.separator"), "<br>"));
				board.setDate(rs.getTimestamp("date"));
				board.setReadcount(rs.getInt("readcount"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		
		return board;
		
	}//selectBoard 끝
	
	// 조회수 올리는 메서드 -> onclick 했을 떄 1씩 DB에 올라가게 update
	public void updateReadcount(int idx) {
		con = JdbcUtil.getConnection();
		String sql = "UPDATE board SET readcount=readcount + 1 WHERE idx=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			int updateCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
	}//updateReadCount 끝
	public int updateBoard(BoardDTO board) {
		int updateCount = 0;
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "UPDATE board SET name=?, subject=?, content =? where idx = ? AND pass =?";
			//select 절을 통해 패스워드가 같을 때 업데이트 작업을 실행하도록 해야 한다.
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getName());
			pstmt.setString(2, board.getSubject());
			pstmt.setString(3, board.getContent());
			pstmt.setInt(4, board.getIdx());
			pstmt.setString(5, board.getPass());
			
			updateCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - updateBoard");
			e.printStackTrace();
		}finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		
		return updateCount;
		
	}//updateBoard 끝
	
	public int deleteBoard(int idx, String pass) {
		int deleteCount = 0;
		
		con = JdbcUtil.getConnection();
		try {
			String sql = "DELETE FROM board WHERE idx =? AND pass =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, pass);
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - deleteBoard");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		
		return deleteCount;
	}//deleteBoard 끝
}
