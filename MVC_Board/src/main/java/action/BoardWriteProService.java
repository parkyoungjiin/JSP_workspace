package action;

import java.sql.Connection;

import dao.BoardDAO;
import db.JdbcUtil;
import vo.BoardBean;

// Action 클래스로부터 작업 요청을 받아 DAO 클래스와 상호작용을 통해
// 실제 비즈니스 로직(DB 작업)을 수행하는 클래스
// 또한, DB 작업 수행 후 결과 판별을 통해 트랜잭션 처리(commit or rollback)도 수행
public class BoardWriteProService {
	// 글쓰기 작업 요청을 위한 registBoard() 메서드 정의
	// => 파라미터 : BoardBean 객체   리턴타입 : boolean(isWriteSuccess)
	public boolean registBoard(BoardBean board) {
		System.out.println("BoardWriteProService - registBoard()");
		//메서드 결과 저장
		boolean isWriteSuccess = false;
		
		Connection con = JdbcUtil.getConnection();
		//DAO 객체 생성하여 , 인스턴스를 받고 커넥션을 전달
		
		BoardDAO dao = BoardDAO.getInstance();
		dao.setConnection(con);
		
		int insertCount = dao.insertBoard(board);
		
		if(insertCount > 0) { // 성공 시 
			JdbcUtil.commit(con);
			isWriteSuccess = true;
		} else { // 실패 시 
			JdbcUtil.rollback(con);
		}
		
		JdbcUtil.close(con); // Service 클래스에서 Connection 자원을 반환해야 함. ( DAO에서 하면 절대 안된다.)
		
		
		return isWriteSuccess;
	}
	
}














