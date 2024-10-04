package book;
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

	//id에 따른 도서 모든 정보 bean 저장

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
	
	//도서 리뷰 가져오기
	public Vector<ReviewBean> getReview(int bookid){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewBean> rlist = new Vector<ReviewBean>();
		try {
			con = pool.getConnection();
			sql = "select * from reviewtbl where bookid = ? order by reviewid desc";
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
	
	//전체 리뷰 개수 가져오기
	   public int totalReview(int bookid) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = null;
	      int totalReview = 0;
	      try {
	         con = pool.getConnection();
	         sql = "select count(*) from reviewtbl where bookid = ? ";
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
	   

	   //userid -> nickname 가져오기
	   public String getNickname(int userid) {
		   Connection con = null;
		   PreparedStatement pstmt = null;
		   ResultSet rs = null;
		   String sql = null;
		   String nickname = null;
		   try {
			   con = pool.getConnection();
			   sql = "select nickname from membertbl where userid = ?";
			   pstmt = con.prepareStatement(sql);
			   pstmt.setInt(1, userid);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   nickname = rs.getString(1);
			   }
		   }catch(Exception e) {
			   e.printStackTrace();
		   }finally {
			   pool.freeConnection(con, pstmt, rs);
		   }
		   return nickname;
	   }
	   
	   //한줄평 등록
	   public boolean insertReview(ReviewBean bean) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      String sql = null;
	      boolean flag = false;
	      
	      try {
	    	  con = pool.getConnection();
	    	  sql = "insert reviewtbl (userid, bookid, score, content, nickname)"
	        		 + "values(?,?,?,?,?)";
	    	  pstmt = con.prepareStatement(sql);
	    	  pstmt.setInt(1, bean.getUserid());
	    	  pstmt.setInt(2, bean.getBookid());
	    	  pstmt.setInt(3, bean.getScore());
	    	  pstmt.setString(4, bean.getContent());
	    	  pstmt.setString(5, bean.getNickname());
	    	  
	    	  if(pstmt.executeUpdate() == 1) {
					flag = true;
				}
	      }catch(Exception e){
	         e.printStackTrace();
	      }finally {
	         pool.freeConnection(con, pstmt);
	      }
	      return flag;
	   }
	   
	   //한줄평 등록시 해당 도서의 별점 구하기
	   public int avgScore(int bookid) {
		   Connection con = null;
		   PreparedStatement pstmt = null;
		   ResultSet rs = null;
		   String sql = null;
		   int avg = 0;
		   try {
			   con = pool.getConnection();
			   sql = "select avg(score) from reviewtbl where bookid = ?";
			   pstmt = con.prepareStatement(sql);
			   pstmt.setInt(1, bookid);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   avg = rs.getInt(1);
			   }
		   }catch(Exception e){
			   e.printStackTrace();
		   }finally {
			   pool.freeConnection(con, pstmt, rs);
		   }
		   return avg;
	   }
	   
	   //새로 구한 별점으로 다시 booktbl 수정하기
	   public void updateScore(int newScore, int bookid) {
		   Connection con = null;
		   PreparedStatement pstmt = null;
		   ResultSet rs = null;
		   String sql = null;
		   try {
			   con = pool.getConnection();
			   sql = "update booktbl set score = ? where bookid = ?";
			   pstmt = con.prepareStatement(sql);
			   pstmt.setInt(1, newScore);
			   pstmt.setInt(2, bookid);
			   if(pstmt.executeUpdate() == 1) {
				   System.out.println("booktbl의 score 수정 완료!");
			   }
		   }catch(Exception e) {
			   e.printStackTrace();
		   }finally {
			   pool.freeConnection(con, pstmt, rs);
		   }
	   }
	   
	   
	   
	
}
