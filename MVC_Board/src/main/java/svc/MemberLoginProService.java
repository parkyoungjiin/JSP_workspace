package svc;

import java.sql.Connection;

import dao.MemberDAO;
import db.JdbcUtil;
import vo.MemberBean;

public class MemberLoginProService {

	public boolean loginMember(MemberBean member) {
		boolean isLoginSuccess = false;
		int selectCount = 0;
		
		
		Connection con = JdbcUtil.getConnection();
		
		MemberDAO dao = MemberDAO.getInstance();
		
		dao.setConnection(con);
		
		selectCount = dao.selectMember(member);
		if(selectCount > 0) {
			//로그인 성공
			isLoginSuccess = true;
			
		}else {//로그인 실패
			isLoginSuccess = false;
		}
		
		JdbcUtil.close(con);
		
		return isLoginSuccess;
	}
	
	
	
}//service 끝
