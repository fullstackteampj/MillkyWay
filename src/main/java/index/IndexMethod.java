package index;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import DBConnection.DBConnectionMgr;
import beans.BookBean;

public class IndexMethod {
	
	private DBConnectionMgr pool;
	
	public IndexMethod() {
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
			sql = "select author,content,boardid from boardtbl order by boardid desc limit 10";
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
			sql = "select author,content,boardid from boardtbl order by liked desc limit 10";
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
	
	
	public BookBean getRanBook(int ranId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BookBean ranBBean  = null;
		
		try {
			conn = pool.getConnection();
			sql = "select title,author from booktbl where bookid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ranId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				ranBBean = new BookBean();
				ranBBean.setTitle(rs.getString("title"));
				ranBBean.setAuthor(rs.getString("author"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn,pstmt,rs);
		}
		
		return ranBBean;
	}//Bookbean getRanBook(int ranId)
	
}//class IndexMethod































