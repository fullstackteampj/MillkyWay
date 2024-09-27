package book;

import java.sql.*;
import java.util.Vector;

import DBConnection.DBConnectionMgr;
import beans.BookBean;

public class BookListMgr {
	
	private DBConnectionMgr pool;
	
	public int recomCount = 12;
	public int bestCount = 30;
	public int saleCount = 7;
	
	public BookListMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}//BookListMgr()
	
	//도서 목록 nav 가져오기
	public Vector<BookBean> getBookList(String category, String genre, int start, int end,  String tap){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BookBean> blist = new Vector<BookBean>();
		
		System.out.println("3. end" + end);
		
		try {
			con = pool.getConnection();
			if(tap == null || tap.equals("null")) {
				//tap 값이 비어있는 경우
				if(category == null || category.equals("null")) {
					sql = "select * from booktbl limit ?, ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, end);
				}else if(genre == null || genre.equals("null")){
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
			}else{
				//tap 값이 비어있지 않은 경우
				switch(tap) {
				case "도서 모두보기":
					sql = "select * from booktbl limit ?, ?";
					break;
					
				case "베스트셀러":
					sql = "select * from (select * from booktbl order by score desc, stock_Quantity asc limit " + bestCount +") as results limit ?, ?";
					break;
					
				case "정가 인하": 
					sql = "select * from (select * from booktbl order by stock_Quantity desc limit " + saleCount + ") as results limit ?, ?";
					break;
					
				case "추천 도서":
					sql = "select * from (select * from booktbl order by score desc limit " + recomCount + ") as results limit ?, ?";
					break;
				}//switch
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				
				System.out.println("4. start" + start);
				System.out.println("4. end" + end);
			}
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BookBean bean = new BookBean();
				bean.setBookid(rs.getInt("bookid"));
				bean.setAuthor(rs.getString("author"));
				bean.setTitle(rs.getString("title"));
				bean.setScore(rs.getInt("score"));
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
	
	//도서 목록 nav 선택시 총 도서 수 구하기
	public int getTotalCount(String category, String genre) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			
			if(category == null || category.equals("null")) {
				//아무 조건 없는 경우 -> 모든 도서 
				sql = "select count(*) from booktbl";
				pstmt = con.prepareStatement(sql);
				
			}else if(genre == null || genre.equals("null")){
				//카테고리만 지정된 경우
				sql = "select count(*) from booktbl where category = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, category);
			}else {
				//카테고리, 장르 모두 지정된 경우
				sql = "select count(*) from booktbl where category = ? and genre = ?";
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
	
	//tap nav 선택시 총 도서 수 구하기
	public int getTotalTap (String tap) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			//tap nav 활성화 상태
			switch(tap) {
				case "도서 모두보기":
					sql = "select count(*) from booktbl";
					break;
					
				case "베스트셀러":
					sql = "select count(*) from (select * from booktbl order by score desc, stock_Quantity asc limit " + bestCount + ") as results";
					break;
					
				case "정가 인하": 
					sql = "select count(*) from (select * from booktbl order by stock_Quantity desc limit " + saleCount + ") as results";
					break;
					
				case "추천 도서":
					sql = "select count(*) from (select * from booktbl order by score desc limit " + recomCount + ") as results";	
			}
		
			pstmt = con.prepareStatement(sql);
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
