package login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DBConnection.DBConnectionMgr;
import beans.MemberBean;

public class LoginMgr {
	//클래스에서 사용할 DB커넥션 생성
	private DBConnectionMgr pool;
	
	public LoginMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public MemberBean getLoginInfo(String account) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		
		try {
			conn = pool.getConnection();
			sql = "select userid, pwd from membertbl where account = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, account);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setPwd(rs.getString("pwd"));
				bean.setUserid(rs.getInt("userid"));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return bean;
	}//MemberBean getLoginInfo(String account)
	
	
	public MemberBean getQuestionInfo(String account) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		
		try {
			conn = pool.getConnection();
			sql = "select question, answer from membertbl where account = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, account);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setQuestion(rs.getString("question"));
				bean.setAnswer(rs.getString("answer"));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return bean;
	}//MemberBean getQuestionInfo(String account)
	
}//class LoginMgr


















