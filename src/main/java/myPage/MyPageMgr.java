package myPage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import DBConnection.DBConnectionMgr;
import beans.BoardBean;
import beans.BookBean;
import beans.CancelBean;
import beans.CartBean;
import beans.MemberBean;
import beans.PurchaseBean;
import beans.WishBean;

public class MyPageMgr {
	
	private DBConnectionMgr pool;
	
	public MyPageMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public Vector<PurchaseBean> getPurList(int id, int start, int end) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PurchaseBean> purList = new Vector<PurchaseBean>();
		
		// "select * from tblBoard order by ref desc, pos limit ? , ?"
		
		try {
			conn = pool.getConnection();
			sql = "select * from purchasetbl where userid = ? order by purchaseid desc limit ? , ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				PurchaseBean bean = new PurchaseBean();
				bean.setBookid(rs.getInt("bookid"));
				bean.setPurchase_date(rs.getString("purchase_date"));
				bean.setStatus(rs.getString("status"));
				purList.add(bean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn,pstmt,rs);
		}

		return purList;
	}//public Vector<PurchaseBean> getPurList(int id)
	
	
	public BookBean getMyBookInfo(int bookid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BookBean bBean = null;
		
		try {
			conn = pool.getConnection();
			sql = "select title,author,price from Booktbl where bookid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bookid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bBean = new BookBean();
				
				bBean.setTitle(rs.getString("title"));
				bBean.setAuthor(rs.getString("author"));
				bBean.setPrice(rs.getInt("price"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn,pstmt,rs);
		}

		return bBean;
	}//Bookbean getMyBookInfo(int bookid)
	
	
	
	public String getUserName(int userId) {
		String userName = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			conn = pool.getConnection();
			sql = "select name from membertbl where userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				userName = rs.getString("name");
			}

			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn,pstmt,rs);
		}
		
		return userName;
	}//getUserName(int userId)
	
	
	
	public Vector<CancelBean> getCanList(int id, int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CancelBean> canList = new Vector<CancelBean>();
		
		try {
			conn = pool.getConnection();
			sql = "select * from canceltbl where userid = ? order by cancelid desc limit ? , ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CancelBean cBean = new CancelBean();
				cBean.setBookid(rs.getInt("bookid"));
				cBean.setCancellation_date(rs.getString("cancellation_date"));
				cBean.setStatus(rs.getString("status"));
				canList.add(cBean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn,pstmt,rs);
		}

		return canList;
	}//public Vector<CancelBean> getCanList(int id)
	
	
	public MemberBean getMemberUpdate(int userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean mBean = null;
		
		try {
			conn = pool.getConnection();
			sql = "select * from membertbl where userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mBean = new MemberBean();
				mBean.setNickname(rs.getString("nickname"));
				mBean.setGender(rs.getString("gender"));
				mBean.setPhone(rs.getString("phone"));
				mBean.setEmail(rs.getString("email"));
				mBean.setAddress(rs.getString("address"));
				mBean.setPwd(rs.getString("pwd"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return mBean;
	}//getMemberUpdate(int userId)
	
	
	public Vector<BoardBean> getMyBoardList(int userId, int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BoardBean> myBoardList = new Vector<BoardBean>();
		
		try {
			conn = pool.getConnection();
			sql = "select * from boardtbl where userid = ? order by boardid desc limit ? , ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setTitle(rs.getString("title"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setContent(rs.getString("content"));
				bean.setBoardid(rs.getInt("boardid"));
				
				myBoardList.add(bean);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return myBoardList;
	}//Vector<BoardBean> getMyBoardList(int userId)
	
	
	
	public Vector<CartBean> getMyCartList(int userId, int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CartBean> myCartList = new Vector<CartBean>();
		
		try {
			conn = pool.getConnection();
			sql = "select * from carttbl where userid = ? order by cartid desc limit ? , ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CartBean bean = new CartBean();
				bean.setBookid(rs.getInt("bookid"));
				bean.setCartid(rs.getInt("cartid"));
				bean.setUserid(rs.getInt("userid"));
				myCartList.add(bean);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}

		return myCartList;
	}//Vector<CartBean> getMyCartList(int userId)
	
	
	
	public Vector<WishBean> getMyWishList(int userId, int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<WishBean> myWishList = new Vector<WishBean>();
		
		try {
			conn = pool.getConnection();
			sql = "select * from wishtbl where userid = ? order by wishid desc limit ? , ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				WishBean bean = new WishBean();
				bean.setBookid(rs.getInt("bookid"));
				bean.setWishid(rs.getInt("wishid"));
				bean.setUserid(rs.getInt("userid"));
				myWishList.add(bean);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}

		return myWishList;
	}//Vector<WishBean> getMyWishList(int userId) 
	
	
	public int getTotalPurCount(int userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalRecord = 0;
		
		try {
			conn = pool.getConnection();
			sql = "select count(*) from purchasetbl where userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			
			rs = pstmt.executeQuery();
			if(rs.next())
				totalRecord = rs.getInt(1);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return totalRecord;
	}//int getTotalPurCount(userId)
	
	
	public int getTotalCanCount(int userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalRecord = 0;
		
		try {
			conn = pool.getConnection();
			sql = "select count(*) from canceltbl where userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			
			rs = pstmt.executeQuery();
			if(rs.next())
				totalRecord = rs.getInt(1);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return totalRecord;
	}//int getTotalCanCount(int userId)
	
	public int getTotalMyBoardCount(int userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalRecord = 0;
		
		try {
			conn = pool.getConnection();
			sql = "select count(*) from boardtbl where userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			
			rs = pstmt.executeQuery();
			if(rs.next())
				totalRecord = rs.getInt(1);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return totalRecord;
	}//int getTotalCanCount(int userId)
	
	public int getTotalMyCartCount(int userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalRecord = 0;
		
		try {
			conn = pool.getConnection();
			sql = "select count(*) from carttbl where userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			
			rs = pstmt.executeQuery();
			if(rs.next())
				totalRecord = rs.getInt(1);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return totalRecord;
	}//int getTotalMyCartCount(int userId)
	
	public int getTotalMyWishCount(int userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalRecord = 0;
		
		try {
			conn = pool.getConnection();
			sql = "select count(*) from wishtbl where userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			
			rs = pstmt.executeQuery();
			if(rs.next())
				totalRecord = rs.getInt(1);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return totalRecord;
	}//int getTotalMyCartCount(int userId)
	
	
	
	public boolean executeMemberUpdate(int userId, MemberBean inbean) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			conn = pool.getConnection();
			sql = "update membertbl set nickname = ?, gender = ?, phone = ?, email = ?, address = ?"
					+ "where userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, inbean.getNickname());
			pstmt.setString(2, inbean.getGender());
			pstmt.setString(3, inbean.getPhone());
			pstmt.setString(4, inbean.getEmail());
			pstmt.setString(5, inbean.getAddress());
			pstmt.setInt(6, userId);
			
			int j = pstmt.executeUpdate();
			if(j>0)
				flag = true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt);
		}
		
		return flag;
	}//boolean executeMemberUpdate(MemberBean inbean)
	
}//class MyPageMgr





















