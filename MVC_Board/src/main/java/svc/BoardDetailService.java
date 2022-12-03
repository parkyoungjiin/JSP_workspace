package svc;

import java.sql.Connection;


import dao.BoardDAO;
import db.JdbcUtil;
import vo.BoardBean;


public class BoardDetailService {

	public BoardBean getDetialList(int board_num) {
		BoardBean board = null;
		//서비스 클래스의 공통작업
		//1. 커넥션 받기
		Connection con = JdbcUtil.getConnection();
		//2. dao객체 가져오기
		BoardDAO dao = BoardDAO.getInstance();
		//3. dao객체에 커넥션 넣어주기
		dao.setConnection(con);
		
		board = dao.selectBoard(board_num);
		
		//4. 커넥션 반환
		JdbcUtil.close(con);
		
		
		return board;
	}

}
