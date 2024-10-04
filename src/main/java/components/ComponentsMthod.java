package components;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DBConnection.DBConnectionMgr;

public class ComponentsMthod {
	
	private DBConnectionMgr pool;
	
	public ComponentsMthod() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	
	public beans.MemberBean getMypageMember(int id) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		beans.MemberBean mbean = new beans.MemberBean();
		
		try {
			conn = pool.getConnection();
			sql = "select * from membertbl where userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				mbean.setName(rs.getString("name"));
				mbean.setAccount(rs.getString("account"));
				mbean.setGender(rs.getString("gender"));
				mbean.setEmail(rs.getString("email"));
				mbean.setAddress(rs.getString("address"));
				mbean.setUsergrade(rs.getString("usergrade"));
				mbean.setCurpoint(rs.getInt("curpoint"));
				mbean.setExpectpoint(rs.getInt("expectpoint"));
				mbean.setStatus(rs.getString("status"));
			}

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return mbean;
	}//MemberBean getMypageMember(int id)
	
	
	public String getNickName(String userId) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String nickName = null;
		
		try {
			conn = pool.getConnection();
			sql = "select nickName from membertbl where userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(userId));
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				nickName = rs.getString("nickName");
			}

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return nickName;
	}// String getNickName(int userId)
	

}//class componentsMthod
