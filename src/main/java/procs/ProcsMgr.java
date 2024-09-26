package procs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DBConnection.DBConnectionMgr;
import beans.CartBean;
import beans.WishBean;

public class ProcsMgr {

	private DBConnectionMgr pool;
	
	public ProcsMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean delMyBoard(int boardId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		Boolean flag = false;
		
		try {
			conn = pool.getConnection();
			sql = "delete from boardtbl where boardid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardId);
			
			int j = pstmt.executeUpdate();
			if(j>0)
				flag = true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt);
		}
		
		return flag;
	}//boolean delMyBoard(int boardId)
	
	
	public boolean delMyCart(int cartId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		Boolean flag = false;
		
		try {
			conn = pool.getConnection();
			sql = "delete from carttbl where cartId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cartId);
			
			int j = pstmt.executeUpdate();
			if(j>0)
				flag = true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt);
		}
		
		return flag;
	}//boolean delMyCart(int cartId)
	
	
	
	public boolean delMyWish(int wishId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		Boolean flag = false;
		
		try {
			conn = pool.getConnection();
			sql = "delete from wishtbl where wishId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, wishId);
			
			int j = pstmt.executeUpdate();
			if(j>0)
				flag = true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt);
		}
		
		return flag;
	}//boolean delMyWish(int wishId)
	
	
	
	public boolean addToCart(int userId, int bookId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		Boolean flag = false;
		
		try {
			conn = pool.getConnection();
			sql = "insert into carttbl (userid, bookid, status, added_date)"
					+ "values(?,?,?,curdate()) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			pstmt.setInt(2, bookId);
			pstmt.setString(3, "active");
			
			int j = pstmt.executeUpdate();
			if(j>0)
				flag = true;
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt);
		}
		
		return flag;
	}//boolean addToCart(int userId, int bookId)
	
	
	public boolean updatePwd(String account, String newPwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		Boolean flag = false;
		
		try {
			conn = pool.getConnection();
			sql = "update membertbl set pwd = ? where account = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newPwd);
			pstmt.setString(2, account);
			
			int j = pstmt.executeUpdate();
			if(j>0)
				flag = true;
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt);
		}
		
		return flag;
	}// boolean updatePwd(String account, String newPwd)
	
	
	public void moveToWish(int cartId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		CartBean bean = new CartBean();
		
		try {
			conn = pool.getConnection();
			
			// 1. 카트에서 아이템 조회
			sql = "select * from carttbl where cartId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cartId);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setBookid(rs.getInt("bookid"));
				bean.setUserid(rs.getInt("userid"));
				bean.setStatus(rs.getString("status"));
			}
			
			// 2. 위시리스트에 추가
			sql = "insert into wishtbl (bookid,userid,status,added_date)"
					+"values(?,?,?,curdate())";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bean.getBookid());
			pstmt.setInt(2, bean.getUserid());
			pstmt.setString(3, bean.getStatus());
			pstmt.executeUpdate();
			
			// 3. 카트에서 아이템 삭제
			sql = "delete From carttbl where cartId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cartId);
			pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
	}//void moveToWish(cartId)
	
	
	public void moveToCart(int wishid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		WishBean bean = new WishBean();
		
		try {
			conn = pool.getConnection();
			
			// 1. 위시테이블에서 아이템 조회
			sql = "select * from wishtbl where wishid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, wishid);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setBookid(rs.getInt("bookid"));
				bean.setUserid(rs.getInt("userid"));
				bean.setStatus(rs.getString("status"));
			}
			
			// 2. 카트테이블에 추가
			sql = "insert into carttbl (bookid,userid,status,added_date)"
					+"values(?,?,?,curdate())";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bean.getBookid());
			pstmt.setInt(2, bean.getUserid());
			pstmt.setString(3, bean.getStatus());
			pstmt.executeUpdate();
			
			// 3. 위시에서 아이템 삭제
			sql = "delete From wishtbl where wishid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, wishid);
			pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
	}//void moveToWish(cartId)
	
}//class ProcsMgr

















