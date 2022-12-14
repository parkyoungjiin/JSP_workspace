package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.cj.protocol.Resultset;

import db.JdbcUtil;
import vo.BoardBean;

// 실제 비즈니스 로직을 수행하는 BoardDAO 클래스 정의
// => 각 Service 클래스 인스턴스에서 BoardDAO 인스턴스에 접근 시 고유 데이터가 불필요하므로
//    BoardDAO 인스턴스는 애플리케이션에서 단 하나만 생성하여 공유해도 된다!
//    따라서, 싱글톤 디자인 패턴을 적용하여 클래스를 정의하면 메모리 낭비를 막을 수 있다!
public class BoardDAO {
	// ------------ 싱글톤 디자인 패턴을 활용한 BoardDAO 인스턴스 생성 작업 -------------
	// 1. 외부에서 인스턴스 생성이 불가능하도록 생성자를 private 접근제한자로 선언
	// 2. 자신의 클래스 내에서 직접 인스턴스를 생성하여 멤버변수에 저장
	//    => 인스턴스 생성없이 클래스가 메모리에 로딩될 때 함께 로딩되도록 static 변수로 선언
	//    => 외부에서 접근하여 함부로 값을 변경할 수 없도록 private 접근제한자로 선언
	// 3. 생성된 인스턴스를 외부로 리턴하는 Getter 메서드 정의
	//    => 인스턴스 생성없이 클래스가 메모리에 로딩될 때 함께 로딩되도록 static 메서드로 선언
	//    => 누구나 접근 가능하도록 public 접근제한자로 선언
	private BoardDAO() {}
	
	private static BoardDAO instance = new BoardDAO();

	public static BoardDAO getInstance() {
		return instance;
	}
	// ----------------------------------------------------------------------------------
	// 데이터베이스 접근에 사용할 Connection 객체를 Service 객체로부터 전달받기 위한
	// Connection 타입 멤버변수 선언 및 Setter 메서드 정의
	private Connection con;

	public void setConnection(Connection con) {
		this.con = con;
	}
	// ----------------------------------------------------------------------------------

	public int insertBoard(BoardBean board) {
		System.out.println("insertBoard 작업");
		int insertCount = 0;
		PreparedStatement pstmt = null, pstmt2 = null ;
		ResultSet rs = null;
		
		try {
			int board_num = 1; // 새 글 번호
			String sql = "SELECT MAX(board_num) FROM board";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { 
				 //true -> 조회결과가 있을 경우 (= 게시물이 하나라도 존재할 경우)
				 //존재하지 않을 경우 rs.next는 false , DB에서는 NULL이 표기된다.
				board_num = rs.getInt(1) + 1;
			}
			System.out.println("새글 번호 :" + board_num);
			
			sql = "INSERT INTO board VALUES(?,?,?,?,?,?,?,?,?,?,?,now())";
			
			pstmt2 = con.prepareStatement(sql);
//			 board_num       | int           | NO   | PRI | NULL    |       |
//			 | board_name      | varchar(20)   | NO   |     | NULL    |       |
//			 | board_pass      | varchar(16)   | NO   |     | NULL    |       |
//			 | board_subject   | varchar(50)   | NO   |     | NULL    |       |
//			 | board_content   | varchar(2000) | NO   |     | NULL    |       |
//			 | board_file      | varchar(200)  | NO   |     | NULL    |       |
//			 | board_real_file | varchar(200)  | NO   |     | NULL    |       |
//			 | board_re_ref    | int           | NO   |     | NULL    |       |
//			 | board_re_lev    | int           | NO   |     | NULL    |       |
//			 | board_re_seq    | int           | NO   |     | NULL    |       |
//			 | board_readcount | int           | YES  |     | 0       |       |
//			 | board_date      | datetime      | YES  |     | NULL    |       |
			pstmt2.setInt(1, board_num);
			pstmt2.setString(2, board.getBoard_name());
			pstmt2.setString(3, board.getBoard_pass());
			pstmt2.setString(4, board.getBoard_subject());
			pstmt2.setString(5, board.getBoard_content());
			pstmt2.setString(6, board.getBoard_file());
			pstmt2.setString(7, board.getBoard_real_file());
			pstmt2.setInt(8, board_num); //참조 글 번호(글쓰기는 글번호와 동일하게 사용)
			pstmt2.setInt(9, 0); //들여쓰기 레벨
			pstmt2.setInt(10, 0); //순서 번호
			pstmt2.setInt(11, 0); //조회 수
			
			insertCount = pstmt2.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(pstmt2);
			
			//Connection 객체는 Service 클래스가 관리하므로 DAO에서 반환 금지.
		}
		
		return insertCount;
	}

	public List<BoardBean> selectBoardList(String keyword, int startRow, int listLimit) {
		System.out.println("selectBoardList (조회작업)");
		List<BoardBean> selectList = null;
		
		PreparedStatement pstmt = null;
		
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM board WHERE board_subject LIKE ? ORDER BY board_re_ref DESC, board_re_seq ASC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			
				pstmt.setString(1, "%" + keyword + "%");
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, listLimit);
				rs = pstmt.executeQuery();
			
			selectList = new ArrayList<BoardBean>();
			
			while(rs.next()) {
				BoardBean board = new BoardBean();
				board.setBoard_num(rs.getInt("board_num"));
				board.setBoard_name(rs.getString("board_name"));
				board.setBoard_pass(rs.getString("board_pass"));
				board.setBoard_subject(rs.getString("board_subject"));
				board.setBoard_content(rs.getString("board_content"));
				board.setBoard_file(rs.getString("board_file"));
				board.setBoard_real_file(rs.getString("board_real_file"));
				board.setBoard_re_ref(rs.getInt("board_re_ref"));
				board.setBoard_re_lev(rs.getInt("board_re_lev"));
				board.setBoard_re_seq(rs.getInt("board_re_seq"));
				board.setBoard_date(rs.getTimestamp("board_date"));
				board.setBoard_readcount(rs.getInt("board_readcount"));
				
				selectList.add(board);
				
			}
		} catch (SQLException e) {
			System.out.println("BoardDAO - selectBoardList()");
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			
			//Connection 객체는 Service 클래스가 관리하므로 DAO에서 반환 금지.
		}
		
		
		
		return selectList;
	}//selectBoardList

	public int selectBoardListCount(String keyword) {
		int listCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(*) FROM board WHERE board_subject LIKE ?";

			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, "%" + keyword + "%");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("BoardDAO - selectBoardList()");
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			
			//Connection 객체는 Service 클래스가 관리하므로 DAO에서 반환 금지.
		}
		return listCount;
	}//selectBoardListCount

	//----------------------------상세정보 DAO 작업--------------------------------------
	public BoardBean selectBoard(int board_num) {
		BoardBean board = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM board WHERE board_num = ? ";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			
			rs = pstmt.executeQuery();
			//boardbean에 저장
			//빈은 있을 때 마다 생성. 리스트는 하나.
			
			if(rs.next()) {
				board = new BoardBean();
				board.setBoard_num(rs.getInt("board_num"));
				board.setBoard_name(rs.getString("board_name"));
				board.setBoard_subject(rs.getString("board_subject"));
				board.setBoard_content(rs.getString("board_content"));
				board.setBoard_date(rs.getTimestamp("board_date"));
				board.setBoard_file(rs.getString("board_file"));
				board.setBoard_real_file(rs.getString("board_real_file"));
				board.setBoard_re_ref(rs.getInt("board_re_ref"));
				board.setBoard_re_lev(rs.getInt("board_re_lev"));
				board.setBoard_re_seq(rs.getInt("board_re_seq"));
				board.setBoard_readcount(rs.getInt("board_readcount"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectBoard");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		
		return board;
	}
	//-----------------------------조회수 증가 작업----------------------------
	public int updateReadCount(int board_num) {
		int updateCount = 0;
		PreparedStatement pstmt = null;
		String sql = "UPDATE board SET board_readcount = board_readcount + 1 WHERE board_num = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			updateCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - updateReadCount");
			e.printStackTrace();
		}finally {
			JdbcUtil.close(pstmt);
		}
		
		return updateCount;
	}
//--------------------비밀번호 일치 여부 확인 ----------------------
	
	public boolean isBoardWriter(int board_num, String board_pass) {
		boolean isBoardWriter = false;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			// board 테이블에서 글번호(board)가 일치하는 1개 레코드 조회
			String sql = "SELECT * FROM board "
								+ "WHERE board_num=? "
								+ 		"AND board_pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			pstmt.setString(2, board_pass);
			rs = pstmt.executeQuery();
			
			// 조회 결과가 있을 경우
			if(rs.next()) {
				// isBoardWriter 값을 true 로 변경
				isBoardWriter = true;
			}
			
		} catch (SQLException e) {
			System.out.println("BoardDAO - isBoardWriter()");
			e.printStackTrace();
		} finally {
			// DB 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return isBoardWriter;
	}
	
	
//----------------------------게시물 삭제 작업---------------------------------
	public int BoardDelete(int board_num) {
		int deleteCount = 0;
		
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM board WHERE board_num = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - Delete 작업");
			e.printStackTrace();
		}finally {
			// DB 자원 반환
			JdbcUtil.close(pstmt);
		}
		
		return deleteCount;
	}

//---------------------게시물 수정 작업-------------------------------
	public int updateBoard(BoardBean board) {
		int updateCount = 0;
		PreparedStatement pstmt = null;
		
		String sql = "UPDATE board "
				+ "SET "
					+ "board_subject = ?,"
					+ "board_content = ? ";
		
		//단, 파일명(board_file)이 널이 아닐 경우에만 파일명도 수정
		//즉, 파일명을 수정하는 SET 절을 문장에 추가 결합.
			if(board.getBoard_file() != null) {
				sql += ", board_file = ?"
						+ " ,board_real_file = ?";
			}
		
		sql 	+= "WHERE "
					+ "board_num = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getBoard_subject());
			pstmt.setString(2, board.getBoard_content());
			
			//단, 파일명이 null이 아닌 경우에만 파일명 파라미터를 교체
			if(board.getBoard_file() != null) {
				pstmt.setString(3, board.getBoard_file() );
				pstmt.setString(4, board.getBoard_real_file() );
				pstmt.setInt(5, board.getBoard_num());
			}else { // null이 아닐 때 글번호 파라미터 번호는 5번, 아니면 3번
				pstmt.setInt(3, board.getBoard_num());
				
			}
			updateCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - updateBoard");
			e.printStackTrace();
		}finally {
			// DB 자원 반환
			JdbcUtil.close(pstmt);
		}
		
		
		
		
		return updateCount;
	}
//----------------답글 등록 작업-----------------------
	public int insertReplyBoard(BoardBean board) {
		int insertCount = 0;
		PreparedStatement pstmt = null, pstmt2 = null ;
		ResultSet rs = null;
		
		try {
			int board_num = 1; // 새 글 번호
			String sql = "SELECT MAX(board_num) FROM board";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { 
				 //true -> 조회결과가 있을 경우 (= 게시물이 하나라도 존재할 경우)
				 //존재하지 않을 경우 rs.next는 false , DB에서는 NULL이 표기된다.
				board_num = rs.getInt(1) + 1;
			}
//			System.out.println("새글 번호 :" + board_num);
			
			int ref = board.getBoard_re_ref();
			int lev = board.getBoard_re_lev();
			int seq = board.getBoard_re_seq();
			
			// UPDATE 구문 ( 답글파트 ) 
			// 1. 원본 글 = 참조 글 번호
			// 2. 원본 글 순서번호(seq)보다 큰 레코드들 
			// 순서 번호(seq)를 + 1씩 증가
			sql = "UPDATE board SET board_re_seq = board_re_seq + 1 "
					+ "WHERE board_re_ref = ? AND board_re_seq > ? ";
			
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, ref);
			pstmt2.setInt(2, seq);
			pstmt2.executeUpdate();
			
			JdbcUtil.close(pstmt2);
			
			//lev, seq  + 1 작업
			lev++;
			seq++;
			
			//답글 삽입작업
			// => 글쓰기와 다르게 ref, lev, seq 값은 새로 설정된 값으로 변경
			sql = "INSERT INTO board VALUES(?,?,?,?,?,?,?,?,?,?,?,now())";
			
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, board_num);
			pstmt2.setString(2, board.getBoard_name());
			pstmt2.setString(3, board.getBoard_pass());
			pstmt2.setString(4, board.getBoard_subject());
			pstmt2.setString(5, board.getBoard_content());
			pstmt2.setString(6, board.getBoard_file());
			pstmt2.setString(7, board.getBoard_real_file());
			pstmt2.setInt(8, ref); //참조 글 번호(글쓰기는 글번호와 동일하게 사용)
			pstmt2.setInt(9, lev); //들여쓰기 레벨
			pstmt2.setInt(10, seq); //순서 번호
			pstmt2.setInt(11, 0); //조회 수
		
			insertCount = pstmt2.executeUpdate();

		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - insertReplyBoard");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(pstmt2);
			
			//Connection 객체는 Service 클래스가 관리하므로 DAO에서 반환 금지.
		}
		
		return insertCount;
	}
	
	
	
	
	
	
	
}












