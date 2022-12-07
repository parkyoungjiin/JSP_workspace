package svc;

import java.sql.Connection;

import dao.BoardDAO;
import db.JdbcUtil;
import vo.BoardBean;

// Action 클래스로부터 작업 요청을 받아 DAO 클래스와 상호작용을 통해
// 실제 비즈니스 로직(DB 작업)을 수행하는 클래스
// 또한, DB 작업 수행 후 결과 판별을 통해 트랜잭션 처리(commit or rollback)도 수행
public class BoardModifyProService {
	// 글쓰기 작업 요청을 위한 registBoard() 메서드 정의
	// => 파라미터 : BoardBean 객체   리턴타입 : boolean(isWriteSuccess)
	public boolean modifyBoard(BoardBean board) {
		System.out.println("BoardModifyProService - registBoard()");
		//메서드 결과 저장
		boolean isModifySuccess = false;
		
		Connection con = JdbcUtil.getConnection();
		//DAO 객체 생성하여 , 인스턴스를 받고 커넥션을 전달
		
		BoardDAO dao = BoardDAO.getInstance();
		dao.setConnection(con);
		
		int updateCount = dao.updateBoard(board);
		
		if(updateCount > 0) { // 성공 시 
			JdbcUtil.commit(con);
			isModifySuccess = true;
		} else { // 실패 시 
			JdbcUtil.rollback(con);
		}
		
		JdbcUtil.close(con); // Service 클래스에서 Connection 자원을 반환해야 함. ( DAO에서 하면 절대 안된다.)
		
		
		return isModifySuccess;
	}//modifyBoard 끝
	
	public boolean isBoardWriter(BoardBean board) {
		boolean isBoardWriter = false;
		
		// 공통작업-1. Connection 객체 가져오기
		Connection con = JdbcUtil.getConnection();
		
		// 공통작업-2. BoardDAO 객체 가져오기
		BoardDAO dao = BoardDAO.getInstance();
		
		// 공통작업-3. BoardDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);
		
		// BoardDAO 의 isBoardWriter() 메서드를 호출하여 패스워드 확인 작업 수행
		// => 파라미터 : 글번호, 패스워드    리턴타입 : boolean(isBoardWriter)
		isBoardWriter = dao.isBoardWriter(board.getBoard_num(), board.getBoard_pass());
		
		// 공통작업-4. Connection 객체 반환하기
		JdbcUtil.close(con);
		
		return isBoardWriter;
	}
	
}














