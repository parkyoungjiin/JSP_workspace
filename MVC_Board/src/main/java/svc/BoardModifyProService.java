package svc;

import java.sql.Connection;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;

import dao.BoardDAO;
import db.JdbcUtil;
import vo.BoardBean;

// Action 클래스로부터 작업 요청을 받아 DAO 클래스와 상호작용을 통해
// 실제 비즈니스 로직(DB 작업)을 수행하는 클래스
// 또한, DB 작업 수행 후 결과 판별을 통해 트랜잭션 처리(commit or rollback)도 수행
public class BoardModifyProService {
	//비밀번호 판별 메서드
	public boolean getBoardWriter(BoardBean board) {
		boolean isBoardWriter = false;
		//공통 작업 - 커넥션 가져오기
		Connection con = JdbcUtil.getConnection();
		
		//공통작업 -dao 객체 인스턴스 가져오기
		BoardDAO dao = BoardDAO.getInstance();
		// 공통작업 - 커넥션 저장
		dao.setConnection(con);
		
		isBoardWriter = dao.isBoardWriter(board.getBoard_num(), board.getBoard_pass());
		
		//공통작업 - 커넥션 반환(꼭 서비스에서 해야 함)
		JdbcUtil.close(con);
		
		
		return isBoardWriter;
	}

	public boolean getModify(BoardBean board) {
		boolean isModifySuccess = false;
		int modifyCount = 0;
		
		//게시글 번호에 맞는 값을 수정해야 함.
		
		Connection con = JdbcUtil.getConnection();
		BoardDAO dao = BoardDAO.getInstance();
		dao.setConnection(con);
		
		modifyCount = dao.updateBoard(board);
		if(modifyCount > 0) { // 업뎃 성공 시 : 성공여부를 true + 커밋작업(DML이기에)
			isModifySuccess = true;
			JdbcUtil.commit(con);
		}else {
			JdbcUtil.rollback(con);
		}
		
		
		JdbcUtil.close(con);
		
		
		return isModifySuccess;
	}

	
	
	
}














