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
	ResultSet rs = null;
	
	public int selectListCount() {
		int selectCount = 0;
		con = JdbcUtil.getConnection();
		// 연결하는데 , JDBcutil 클래스의 getConnection 메서드를 통해 연결
		
		String sql = "SELECT COUNT(*) FROM board";
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
		}
		
		return selectCount;
	}//selectListCount 끝
	
	public List<BoardDTO> selectList(){
		List<BoardDTO> boardList  =null;
		con = JdbcUtil.getConnection();
		
		String sql = "SELECT * FROM board";
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			//DTO의 값들을 저장할 리스트 선언
			boardList = new ArrayList<BoardDTO>();
			
			while(rs.next()) {
				BoardDTO board = new BoardDTO();
				
				board.setIdx(rs.getInt("idx"));
				board.setName(rs.getString("name"));
				board.setPass(rs.getString("pass"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setDate(rs.getTimestamp("date"));
				board.setReadcount(rs.getInt("readcount"));
				
				boardList.add(board);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		return boardList;
	}
}
