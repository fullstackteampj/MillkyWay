package index;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import DBConnection.DBConnectionMgr;
import beans.BookBean;

public class IndexMgr {
	
	private DBConnectionMgr pool;
	
	public IndexMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	

	public Vector<beans.BoardBean> getLastBoardList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<beans.BoardBean> latestList = new Vector<beans.BoardBean>();
		
		try {
			conn = pool.getConnection();
			sql = "select nickname,content,boardid from boardtbl order by boardid desc limit 10";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				beans.BoardBean bean = new beans.BoardBean();
				bean.setNickname(rs.getString("nickname"));
				bean.setContent(rs.getString("content"));
				bean.setBoardid(rs.getInt("boardid"));
				latestList.add(bean);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn,pstmt,rs);
		}
		
		return latestList;
		
	}//Vector<BoardBean> getLastBoardList()
	
	
	public Vector<beans.BoardBean> getBestBoardList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<beans.BoardBean> bestList = new Vector<beans.BoardBean>();
		
		try {
			conn = pool.getConnection();
			sql = "select nickname,content,boardid from boardtbl where best = 'Y' order by regdate limit 10";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				beans.BoardBean bean = new beans.BoardBean();
				bean.setNickname(rs.getString("nickname"));
				bean.setContent(rs.getString("content"));
				bean.setBoardid(rs.getInt("boardid"));
				bestList.add(bean);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn,pstmt,rs);
		}
		
		return bestList;
		
	}//Vector<BoardBean> getBestBoardList()
	

	public BookBean getRanBook(int ranId, String category) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BookBean ranBBean  = null;
		
		try {
			conn = pool.getConnection();
			sql = "select title,author,bookid from booktbl where category = ? limit 1 offset ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category);
			pstmt.setInt(2, ranId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				ranBBean = new BookBean();
				ranBBean.setTitle(rs.getString("title"));
				ranBBean.setAuthor(rs.getString("author"));
				ranBBean.setBookid(rs.getInt("bookid"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn,pstmt,rs);
		}
		
		return ranBBean;
	}//Bookbean getRanBook(int ranId)
	
	
	public int getCatCount(String category) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int ranCount = 0;
		
		try {
			conn = pool.getConnection();
			sql = "select count(*) from booktbl where category = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				ranCount = rs.getInt(1);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return ranCount;
	}//getCatCount(String category)
	
	
}//class IndexMethod































