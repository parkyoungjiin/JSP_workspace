package svc;

import java.sql.Connection;

import dao.BoardDAO;
import db.JdbcUtil;

public class BoardDeleteProService {

	public int getDelete(int board_num, String board_pass) {
		System.out.println("BoardDeleteProService - getDelete");
		int deleteCount = 0;		
		//공통작업 (DAO)
		//1. 커넥션 가져오기
		Connection con = JdbcUtil.getConnection();
		
		//2. DAO 객체 가져오기
		BoardDAO dao = BoardDAO.getInstance();
		
		//3. 커넥션 저장
		dao.setConnection(con);
		
				
		deleteCount = dao.BoardDelete(board_num, board_pass);
		
		if(deleteCount > 0) { // true일 때 (작업 성공 시)
			JdbcUtil.commit(con);
		}else {
			JdbcUtil.rollback(con);
		}
		
		//4. 커넥션 반환
		JdbcUtil.close(con);
				
		
		
		return deleteCount;
	}

}
