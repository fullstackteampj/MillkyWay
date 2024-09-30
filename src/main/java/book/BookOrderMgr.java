package book;

import java.sql.*;
import java.util.Vector;

import DBConnection.DBConnectionMgr;
import beans.MemberBean;

public class BookOrderMgr {
	private DBConnectionMgr pool;
	
	public BookOrderMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}//OrderMgr()
	
	//userid값을 통해 결제에 필요한 회원 정보 가져오기
	public Vector<MemberBean> getMember(int userid){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBean> mlist = new Vector<MemberBean>();
		
		try {
			con = pool.getConnection();
			sql = "select * from membertbl where userid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberBean bean = new MemberBean();
				bean.setName(rs.getString("name"));
				bean.setPhoneNum(rs.getString("phone"));
				bean.setZipcode(rs.getString("zipcode"));
				bean.setAddress(rs.getString("address"));
				bean.setDetailAddress(rs.getString("detailaddress"));
				bean.setCurpoint(rs.getInt("curpoint"));
				mlist.add(bean);
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return mlist;
		
	}
	
	//장바구니 클릭시 carttbl에 입력하기
	public boolean insertCart (int userid, int bookid, int quantity) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		System.out.println("2. userid = " + userid);
		
		try {
			con = pool.getConnection();
			sql = "insert into carttbl (userid, bookid, quantity, status, added_Date) values(?, ?, ?, ?, now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setInt(2, bookid);
			pstmt.setInt(3, quantity);
			pstmt.setString(4, "활성");
			
			if(pstmt.executeUpdate() == 1) {
				flag = true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
	}
	
	//관심목록 클릭시 wishtbl에 입력하기
	public boolean insertWish (int userid, int bookid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "insert into wishtbl (userid, bookid, status, added_date) values(?, ?, ?, now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setInt(2, bookid);
			pstmt.setString(3, "활성");
	
			if(pstmt.executeUpdate() == 1) {
				flag = true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
	}
	
	//장바구니 넣기 전 테이블에 있는지 확인
	public boolean checkCart (int userid, int bookid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from carttbl where userid= ? and bookid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setInt(2, bookid);
			flag = pstmt.executeQuery().next();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
	}
	
	//장바구니에 이미 있을 경우 수량 +1 
	public boolean plusQCart (int bookid, int userid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update carttbl set (quantity = quantity + 1) where userid = ? and bookid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setInt(2, bookid);
			flag = pstmt.executeQuery().next();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
	}
	
	//관심목록 넣기 전 테이블에 있는지 확인
	public boolean checkWish (int bookid, int userid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "select * from wishtbl where userid = ? and bookid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setInt(2, bookid);
			
			flag = pstmt.executeQuery().next();
				
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
	}
	
}
