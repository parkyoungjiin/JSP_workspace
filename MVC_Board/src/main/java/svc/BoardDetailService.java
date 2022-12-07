package svc;

import java.security.Provider.Service;
import java.sql.Connection;


import dao.BoardDAO;
import db.JdbcUtil;
import vo.BoardBean;


public class BoardDetailService {

	public BoardBean getDetialList(int board_num, boolean isUpdateReadCount) {
		BoardBean board = null;
		//서비스 클래스의 공통작업
		//1. 커넥션 받기
		Connection con = JdbcUtil.getConnection();
		//2. dao객체 가져오기
		BoardDAO dao = BoardDAO.getInstance();
		//3. dao객체에 커넥션 넣어주기
		dao.setConnection(con);
		
		//먼저 조회 작업을 수행. 	
		board = dao.selectBoard(board_num);
		
		//리턴받은 boardBean 객체가 Null이 아니고, isUpdateReadCount가 true일 경우
		// updateReadCOunt() 메서드를 통해 조회수 증가 작업 수행하고, Commit 작업 수행 + 수동으로 조회수 1 + 작업.
		
		if(board != null && isUpdateReadCount) {
			int updateCount = dao.updateReadCount(board_num);
			if(updateCount > 0) {
				JdbcUtil.commit(con);
				//만약, 조회수 증가 전 조회 작업을 먼저 수행했을 경우
				// 수동으로 BoardBean 객체의 조회수를 1만큼 증가 시켜야 함.
				board.setBoard_readcount(board.getBoard_readcount()+1);
				
			}
			
		}
		//4. 커넥션 반환
		JdbcUtil.close(con);
		
		
		return board;
	}

}
