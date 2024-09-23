package bookInfo;

import java.sql.*;
import java.util.Vector;

import DBConnection.DBConnectionMgr;
import beans.BookBean;

public class BookListMgr {
	
	private DBConnectionMgr pool;
	
	public BookListMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}//BookListMgr()
	
	//도서 목록 가져오기
	public Vector<BookBean> getBookList(String category, String genre, int start, int end,  String tap){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BookBean> blist = new Vector<BookBean>();
		try {
			con = pool.getConnection();
			System.out.println(tap);
			
			if(category == null || category.equals("null") || category.equals("")) {
				sql = "select * from booktbl limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			}else if(genre == null || genre.equals("null") || genre.equals("")){
				//장르 선택시 
				sql = "select * from booktbl where category = ?  limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, category);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}else {
				sql = "select * from booktbl where category = ? and genre = ?  limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, category);
				pstmt.setString(2, genre);
				pstmt.setInt(3, start);
				pstmt.setInt(4, end);
			}
			
			if(tap != null && tap.equals("recommend")){//추천 도서 10권
				sql = "select * from booktbl order by score desc limit 0, 10";
				pstmt = con.prepareStatement(sql);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BookBean bean = new BookBean();
				bean.setBookid(rs.getInt("bookid"));
				bean.setAuthor(rs.getString("author"));
				bean.setTitle(rs.getString("title"));
				bean.setPublish_date(rs.getString("publish_date"));
				bean.setContents(rs.getString("contents"));
				bean.setPrice(rs.getInt("price"));
				blist.add(bean);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return blist;
	}

	//조건에 맞는 전체 도서 개수
	public int getTotalCount(String category, String genre) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			
			if(category == null || category.equals("null") || category.equals("")) {
				//아무 조건 없는 경우 -> 모든 도서 
				sql = "select count(bookid) from booktbl";
				pstmt = con.prepareStatement(sql);
			}else if(genre == null || genre.equals("null") || genre.equals("")){
				//카테고리만 지정된 경우
				sql = "select count(bookid) from booktbl where category = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, category);
			}else {
				//카테고리, 장르 모두 지정된 경우
				sql = "select count(bookid) from booktbl where category = ? and genre = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, category);
				pstmt.setString(2, genre);
			}
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
}
