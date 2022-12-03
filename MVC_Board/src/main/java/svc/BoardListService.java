package svc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import dao.BoardDAO;
import db.JdbcUtil;
import vo.BoardBean;

public class BoardListService {

	public List<BoardBean> getBoardList(String keyword, int startRow, int listLimit) {
		System.out.println("getBoardList 메서드");
		List<BoardBean> boardList = null;
		//공통 작업 -1 . Connection 객체 받기
		Connection con = JdbcUtil.getConnection();
		// 공통 작업 - 2 : DAO 객체 가져오기
		BoardDAO dao = BoardDAO.getInstance();
		// 공통 작업 3 : DAO 객체에 커넥션 전달하기
		dao.setConnection(con);
		
		//DAO 객체의 메서드 호출하여 목록 조회 작업 수행
		boardList = dao.selectBoardList(keyword, startRow, listLimit);
		
		
		// 공통작업 4 : 커넥션 객체 반환하기
		JdbcUtil.close(con);
		
		
		return boardList;
	}

	public int getBoardListCount(String keyword) { // 페이징 리스트 개수
		System.out.println("getBoardListCount 메서드");
		int listCount = 0;
		
		//공통 작업 -1 . Connection 객체 받기
		Connection con = JdbcUtil.getConnection();
		// 공통 작업 - 2 : DAO 객체 가져오기
		BoardDAO dao = BoardDAO.getInstance();
		// 공통 작업 3 : DAO 객체에 커넥션 전달하기
		dao.setConnection(con);
		
		
		listCount = dao.selectBoardListCount(keyword);
		
		JdbcUtil.close(con);
		
		
		return listCount;
	}

		
}
