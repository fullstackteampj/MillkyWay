package procs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

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
	
	
	public boolean updatePwd(String account, String newPwd, String newSalt) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		Boolean flag = false;
		
		try {
			conn = pool.getConnection();
			sql = "update membertbl set pwd = ?, salt = ? where account = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newPwd);
			pstmt.setString(2, newSalt);
			pstmt.setString(3, account);
			
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
			
			boolean flag = addCartVal(bean.getUserid(),bean.getBookid());
			
			if(flag) {
				// 2.카트테이블에 추가(중복될시 수량증가)
				sql = "update carttbl set quantity = quantity + 1 where "
						+"bookid = ? and userid = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bean.getBookid());
				pstmt.setInt(2, bean.getUserid());
				pstmt.executeUpdate();
				
			}else {
				// 2. 카트테이블에 추가(중복없을 시 새로운 목록 생성)
				sql = "insert into carttbl (bookid,userid,status,added_date)"
						+"values(?,?,?,curdate())";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bean.getBookid());
				pstmt.setInt(2, bean.getUserid());
				pstmt.setString(3, bean.getStatus());
				pstmt.executeUpdate();
			}
			
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
	
	
	public boolean addCartVal(int userid, int bookid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		
		try {
			conn = pool.getConnection();
			
			// 1. 위시테이블에서 아이템 조회
			sql = "select * from carttbl where userid = ? and bookid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setInt(2, bookid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
				flag = true;
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}

		return flag;
	}//boolean addCartVal(int userid, int bookid)
	
	
	
	public boolean checkNaverId(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		
		try {
			conn = pool.getConnection();
			sql = "select * from membertbl where account = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
				flag = true;
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return flag;
	}//checkNaverId(String id)
	
	
	public int getUserIdByNaver(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int userid = 0;
		
		try {
			conn = pool.getConnection();
			sql = "select userid from membertbl where account = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
				userid = rs.getInt("userid");
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return userid;
	}//checkNaverId(String id)
	
	
	public boolean signUpByNaver(String jsonResponse) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		
		// Gson을 사용하여 JSON 데이터 파싱
		Gson gson = new Gson();
		JsonObject jsonObject = gson.fromJson(jsonResponse, JsonObject.class);
		String id = jsonObject.get("response").getAsJsonObject().get("id").getAsString();
        String name = jsonObject.get("response").getAsJsonObject().get("name").getAsString();
        String nickname = jsonObject.get("response").getAsJsonObject().get("nickname").getAsString();
        String gender = jsonObject.get("response").getAsJsonObject().get("gender").getAsString();
        String mobile = jsonObject.get("response").getAsJsonObject().get("mobile").getAsString();
        String email = jsonObject.get("response").getAsJsonObject().get("email").getAsString();
        String profile_image = jsonObject.get("response").getAsJsonObject().get("profile_image").getAsString();
        String birthyear = jsonObject.get("response").getAsJsonObject().get("birthyear").getAsString();
        String birthday = jsonObject.get("response").getAsJsonObject().get("birthday").getAsString();
        
        String birth = birthyear + "-" + birthday;
		
		try {
			conn = pool.getConnection();
			sql = "insert into membertbl (account,name,nickname,gender,phone,email,birth,status,favorite,address)"
					+"values(?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, nickname);
			pstmt.setString(4, gender);
			pstmt.setString(5, mobile);
			pstmt.setString(6, email);
			pstmt.setString(7, birth);
			pstmt.setString(8, "sns");
			pstmt.setString(9, "정보없음");
			pstmt.setString(10, "주소를 입력해 주세요~!");
			
			int j = pstmt.executeUpdate();
			
			if(j>0)
				flag = true;
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return flag;
	}//checkNaverId(String id)
	
}//class ProcsMgr

















