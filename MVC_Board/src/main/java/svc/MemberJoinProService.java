package svc;

import java.sql.Connection;

import dao.MemberDAO;
import db.JdbcUtil;
import vo.MemberBean;

public class MemberJoinProService {

	public boolean JoinMember(MemberBean member) {
		System.out.println("회원가입 Service");
		
		boolean isJoinSuccess = false;
		int insertCount = 0;
		Connection con = JdbcUtil.getConnection();
		
		MemberDAO dao = MemberDAO.getInstance();
		
		dao.setConnection(con);
		
		
		insertCount = dao.insertMember(member);
		if(insertCount > 0) { // DB 등록 성공 시
			JdbcUtil.commit(con);
			isJoinSuccess = true;
		}else {
			JdbcUtil.rollback(con);
		}
		
		JdbcUtil.close(con);
		
		
		
		return isJoinSuccess;
	}

}
