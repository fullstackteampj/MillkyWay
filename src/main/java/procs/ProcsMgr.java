package procs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DBConnection.DBConnectionMgr;

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
	
}//class ProcsMgr

















