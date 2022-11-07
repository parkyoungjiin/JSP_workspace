package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DB.JdbcUtil;

public class FileBoardDAO {
	Connection con = null;
	PreparedStatement pstmt = null, pstmt2 = null;
	ResultSet rs = null;
	
	public int insertFileBoard(FileBoardDTO fileBoard) {
		int insertCount = 0;
		con = JdbcUtil.getConnection();
		String sql = "INSERT INTO fileboard VALUES(?,?,?,?,?)";
		
		pstmt = con.prepareStatement(sql);
		
		
		
	}//insertFileBoard 끝
		
}
