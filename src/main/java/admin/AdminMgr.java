package admin;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import DBConnection.DBConnectionMgr;
import beans.BookBean;

public class AdminMgr {
	private DBConnectionMgr pool;

	public AdminMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
			
			// 표지사진 photo, photoText?, 도서제목 title, 도서작가 author 
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/* insert페이지 활용메서드 */
	// 도서 등록
	public boolean insertBook(HttpServletRequest request) throws ServletException, IOException {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		Part imagePart = request.getPart("photo");
    	InputStream imageInputStream = imagePart.getInputStream();
    	//String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
    	
		
		try {
			con = pool.getConnection();
			sql = "INSERT INTO booktbl (photo, title, author, category, genre, review, publish_date, isbn, stock_Quantity, price, pages, contents, authorIntro, contentsTables, miniIntro)"
					+ "values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setBlob(1, imageInputStream);
			pstmt.setString(2, request.getParameter("title"));
			pstmt.setString(3, request.getParameter("author"));
			pstmt.setString(4, request.getParameter("category"));
			pstmt.setString(5, request.getParameter("genre"));
			pstmt.setString(6, request.getParameter("review"));
			pstmt.setString(7, request.getParameter("publish_date"));
			pstmt.setString(8, request.getParameter("isbn"));
			pstmt.setInt(9, Integer.parseInt(request.getParameter("stock_Quantity")));
			pstmt.setInt(10, Integer.parseInt(request.getParameter("price")));
			pstmt.setInt(11, Integer.parseInt(request.getParameter("pages")));
			pstmt.setString(12, request.getParameter("contents"));
			pstmt.setString(13, request.getParameter("authorIntro"));
			pstmt.setString(14, request.getParameter("contentsTables"));
			pstmt.setString(15, request.getParameter("miniIntro"));
			flag = pstmt.executeUpdate() > 0;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 마지막 bookid를 가진 책 반환
	public int lastBookid() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		int lastBookid = 0;
		
		try {
			con = pool.getConnection();
			sql = "SELECT bookid FROM booktbl ORDER BY bookid DESC LIMIT 1;";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				lastBookid = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return lastBookid;
	}
	
	/* update페이지 활용메서드 */
	// 도서 수정
	public boolean updateBook(HttpServletRequest request) throws ServletException, IOException {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;

		Part imagePart = request.getPart("photo");
    	InputStream imageInputStream = imagePart.getInputStream();
    	//String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
    	
    	System.out.println("request.getParameter(\"bookid\") = " + request.getParameter("bookid"));
    	int bookid = (request.getParameter("requestid") != null) ? Integer.parseInt(request.getParameter("requestid")) : Integer.parseInt(request.getParameter("bookid"));
    	
		try {
			con = pool.getConnection();
			// 새로운 사진이 있으면 업데이트
			if(imagePart != null && imagePart.getSize() > 0) {
				sql = "UPDATE booktbl SET "
					+ "title=?, author=?, category=?, genre=?, review=?, "
					+ "publish_date=?, isbn=?, stock_Quantity=?, price=?, pages=?, "
					+ "contents=?, authorIntro=?, contentsTables=?, miniIntro=?, photo=? "
					+ "WHERE bookid = ?;";
				pstmt = con.prepareStatement(sql);
				pstmt.setBlob(15, imageInputStream);
				pstmt.setInt(16, bookid);
			} else {
			// 없으면 기존유지
				sql = "UPDATE booktbl SET "
					+ "title=?, author=?, category=?, genre=?, review=?, "
					+ "publish_date=?, isbn=?, stock_Quantity=?, price=?, pages=?, "
					+ "contents=?, authorIntro=?, contentsTables=?, miniIntro=? "
					+ "WHERE bookid = ?;";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(15, bookid);
			}
			
			pstmt.setString(1, request.getParameter("title"));
			pstmt.setString(2, request.getParameter("author"));
			pstmt.setString(3, request.getParameter("category"));
			pstmt.setString(4, request.getParameter("genre"));
			pstmt.setString(5, request.getParameter("review"));
			pstmt.setString(6, request.getParameter("publish_date"));
			pstmt.setString(7, request.getParameter("isbn"));
			pstmt.setInt(8, Integer.parseInt(request.getParameter("stock_Quantity")));
			pstmt.setInt(9, Integer.parseInt(request.getParameter("price")));
			pstmt.setInt(10, Integer.parseInt(request.getParameter("pages")));
			pstmt.setString(11, request.getParameter("contents"));
			pstmt.setString(12, request.getParameter("authorIntro"));
			pstmt.setString(13, request.getParameter("contentsTables"));
			pstmt.setString(14, request.getParameter("miniIntro"));
			flag = pstmt.executeUpdate() > 0;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	/* delete페이지 활용메서드 */
	// 도서 삭제
	public boolean deleteBook(HttpServletRequest request) throws ServletException, IOException {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM booktbl WHERE bookid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(request.getParameter("requestid")));
			flag = pstmt.executeUpdate() > 0;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
}
