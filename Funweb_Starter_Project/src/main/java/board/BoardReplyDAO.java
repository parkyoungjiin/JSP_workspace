package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import DB.JdbcUtil;

public class BoardReplyDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public int insertReplyBoard(BoardReplyDTO reply) {
		con = JdbcUtil.getConnection();
		int insertCount = 0;
		String sql = "INSERT INTO board_reply VALUES(NULL,?,?,now(),?,?)";
		
		try {
			pstmt = con.prepareStatement(sql);
			
			
			pstmt.setString(1, reply.getId());
			pstmt.setString(2, reply.getContent());
			pstmt.setInt(3, reply.getRef_idx());
			pstmt.setString(4, reply.getBoard_type());
			
			insertCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("insert 구문 오류");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return insertCount;
	} // insertReplyBoard
	
	public List<BoardReplyDTO> getReplyList(int ref_idx, String board_type, int startRow, int listLimit){
		List<BoardReplyDTO> replyList = null;
		con = JdbcUtil.getConnection();
		
		String sql ="SELECT * FROM board_reply WHERE ref_idx = ? AND board_type = ? ORDER BY idx DESC LIMIT ?,?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ref_idx);
			pstmt.setString(2, board_type);
			pstmt.setInt(3, startRow);
			pstmt.setInt(4, listLimit);

			rs = pstmt.executeQuery();
			replyList = new ArrayList<>();
			
			while(rs.next()) {
				BoardReplyDTO reply = new BoardReplyDTO();
				reply.setIdx(rs.getInt("idx"));
				reply.setId(rs.getString("id"));
				reply.setContent(rs.getString("content"));
				reply.setDate(rs.getTimestamp("date"));
				reply.setRef_idx(rs.getInt("ref_idx"));
				reply.setBoard_type(rs.getString("board_type"));
				
				replyList.add(reply);
				System.out.println(reply);
			}
		} catch (SQLException e) {
			System.out.println("댓글 조회 구문 오류");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		
		
		return replyList;
		
	}//getReplyList
	
	public int deleteReply(int idx) {
		int deleteCount = 0;
		
		con = JdbcUtil.getConnection();
		try {
			String sql = "DELETE FROM board_reply WHERE idx =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("deleteReply 구문 오류");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		
		return deleteCount;
	}
}
