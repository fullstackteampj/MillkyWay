package bookInfo;
import java.sql.*;
import java.util.Vector;

import DBConnection.DBConnectionMgr;
import beans.BookBean;
import beans.ReviewBean;


public class BookInfoMgr {
	private DBConnectionMgr pool;
	
	public BookInfoMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//id에 따른 책 모든 정보 bean 저장
	public Vector<BookBean> getBook(int bookid){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BookBean> vlist = new Vector<BookBean>();
		try {
			con = pool.getConnection();
			sql = "select * from booktbl where bookid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bookid);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BookBean bean = new BookBean();
				bean.setTitle(rs.getString("title"));
				bean.setAuthor(rs.getString("author"));
				bean.setCategory(rs.getString("category"));
				bean.setGenre(rs.getString("genre"));
				bean.setReview(rs.getString("review"));
				bean.setScore(rs.getInt("score"));
				bean.setAuthorIntro(rs.getString("authorIntro"));
				bean.setContentsTables(rs.getString("contentsTables"));
				bean.setMiniIntro(rs.getString("miniIntro"));
				bean.setPublish_date(rs.getString("publish_date"));
				bean.setIsbn(rs.getString("isbn"));
				bean.setContents(rs.getString("contents"));
				bean.setPrice(rs.getInt("price"));
				bean.setPages(rs.getInt("pages"));
				vlist.add(bean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//한줄평 가져오기
	public Vector<ReviewBean> getReview(int bookid){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewBean> rlist = new Vector<ReviewBean>();
		try {
			con = pool.getConnection();
			sql = "select * from reviewtbl where bookid = ?";
			System.out.println("sql="+sql);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bookid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewBean bean = new ReviewBean();
				bean.setScore(rs.getInt("score"));
				bean.setContent(rs.getString("content"));
				bean.setNickname(rs.getString("nickname"));
				rlist.add(bean);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return rlist;
	}
	
	//도서별 한줄평 총 개수 구하기
	   public int totalReview(int bookid) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = null;
	      int totalReview = 0;
	      try {
	         con = pool.getConnection();
	         sql = "select count(*) from booktbl where bookid = ? ";
	         pstmt= con.prepareStatement(sql);
	         pstmt.setInt(1, bookid);
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	            totalReview = rs.getInt(1);
	         }
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         pool.freeConnection(con, pstmt, rs);;
	      }
	      return totalReview;
	   }
	   
	   //한줄평 입력하기
	   public void insertReview(int score, String content, String nickname) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = null;
	      
	      try {
	         sql = "insert ";
	      }catch(Exception e){
	         e.printStackTrace();
	      }finally {
	         pool.freeConnection(con, pstmt, rs);
	      }
	      
	   }
	
}
