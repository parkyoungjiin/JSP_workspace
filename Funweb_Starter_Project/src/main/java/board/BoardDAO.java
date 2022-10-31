package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DB.JdbcUtil;

public class BoardDAO {
	public int insertBoard(BoardDTO board) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int insertCount = 0;
// max 설명하다 말았음(10.31) 회원 파일 복습하기
		con = JdbcUtil.getConnection();
		String sql = "INSERT INTO board VALUES(?,?,?,?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, board.getName());
		pstmt.setString(2, board.getName());
		pstmt.setString(3, board.getName());
		pstmt.setString(4, board.getName());
		
		
		
		return insertCount;
		
	}
}
