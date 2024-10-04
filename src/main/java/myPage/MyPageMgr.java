package myPage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import DBConnection.DBConnectionMgr;
import SHA256.SHASalt;
import SHA256test.SHA256;
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
				bean.setPurchaseid(rs.getInt("purchaseid"));
				bean.setQuantity(rs.getInt("quantity"));
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
				cBean.setPrice(rs.getInt("price"));
				cBean.setQuantity(rs.getInt("quantity"));
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
				mBean.setStatus(rs.getString("status"));
				mBean.setDetailAddress(rs.getString("detailAddress"));	
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
				bean.setQuantity(rs.getInt("quantity"));
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
					+ ", detailAddress = ? where userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, inbean.getNickname());
			pstmt.setString(2, inbean.getGender());
			pstmt.setString(3, inbean.getPhone());
			pstmt.setString(4, inbean.getEmail());
			pstmt.setString(5, inbean.getAddress());
			pstmt.setString(6, inbean.getDetailAddress());
			pstmt.setInt(7, userId);
			
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
	
	public boolean checkPwd(String inpwd, String userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		String salt = null;
		
		try {
			//유저 아이디값으로 salt값 불러오기
			conn = pool.getConnection();
			sql = "select salt from membertbl where userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(userId));
			rs = pstmt.executeQuery();
			
			if(rs.next())
				salt = rs.getString("salt");
			
			// salt값과 입력 비밀번호로 해시화된 비밀번호 생성 및 기존 비밀번호와 비교
			conn = pool.getConnection();
			sql = "select * from membertbl where pwd = ?";
			
			SHASalt sha = new SHASalt();
			String pwd = sha.getEncrypt(inpwd, salt);
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pwd);
			
			rs = pstmt.executeQuery();
			if(rs.next())
				flag = true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt);
		}
		
		return flag;
	}//heckPwd(String inpwd)
	
	
	public void signoutMember(String userId) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			// 회원정보를 삭제
			sql = "update membertbl set "
					+ "pwd = '탈퇴한회원입니다', "
					+ "salt = '탈퇴한회원입니다', "
					+ "question = '탈퇴한회원입니다', "
					+ "answer = '탈퇴한회원입니다', "
					+ "name = '탈퇴한회원입니다', "
					+ "nickname = '탈퇴한회원입니다', "
					+ "zipcode = '탈퇴한회원입니다', "
					+ "usergrade = '탈퇴한회원입니다', "
					+ "address = '탈퇴한회원입니다', "
					+ "detailAddress = '탈퇴한회원입니다', "
					+ "gender = '', "
					+ "status = 'signout', "
					+ "phone = '탈퇴한회원입니다', "
					+ "email = '탈퇴한회원입니다' "
					+ "WHERE userId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(userId));
			
			int j = pstmt.executeUpdate();

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt);
		}
	}// void signoutMember(String userId)
	
	public PurchaseBean getCanPurInfo(String purchaseid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		PurchaseBean bean = new PurchaseBean();
		
		try {
			conn = pool.getConnection();
			sql = "select * from purchasetbl where purchaseid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(purchaseid));
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setStatus(rs.getString("status"));
				bean.setQuantity(rs.getInt("quantity"));
				bean.setPurchase_date(rs.getString("purchase_date"));
				bean.setPurchaseid(rs.getInt("purchaseid"));
			}

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return bean;
	}// getCanPurInfo(String purchaseid)
	
	public BookBean getCanBookInfo(String bookid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BookBean bean = new BookBean();
		
		try {
			conn = pool.getConnection();
			sql = "select * from booktbl where bookid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(bookid));
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setAuthor(rs.getString("author"));
				bean.setTitle(rs.getString("title"));
				bean.setPrice(rs.getInt("price"));
			}

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		
		return bean;
	}// getCanPurInfo(String purchaseid)
	
	
	public boolean movePurToCan(String purchaseid, String cancellation_reason, String status, String price, String quantity) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		int userid = 0;
		int bookid = 0;
		
		try {
			// 취소테이블로 옮겨갈 정보 추출
			conn = pool.getConnection();
			sql = "select * from purchasetbl where purchaseid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(purchaseid));
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				userid = rs.getInt("userid");
				bookid = rs.getInt("bookid");
			}
			
			// 취소 테이블에 새로운 목록 추가
			sql = "insert into canceltbl(userid, bookid, status, cancellation_date, cancellation_reason, price, quantity)"
					+"values(?,?,?,curdate(),?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setInt(2, bookid);
			pstmt.setString(3, status + "대기");
			pstmt.setString(4, cancellation_reason);
			pstmt.setInt(5, Integer.parseInt(price));
			pstmt.setInt(6, Integer.parseInt(quantity));
			
			int j = pstmt.executeUpdate();
			if(j>0) {
				flag = true;
			}
			
			// 기존 구매테이블에서 목록 제거
			sql = "delete from purchasetbl where purchaseid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(purchaseid));

			int k = pstmt.executeUpdate();
			if(k>0) {
				flag = true;
			}

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}

		return flag;
	}//boolean movePurToCan(String purchaseid, String cancellation_reason, String status)
	
	
}//class MyPageMgr





















