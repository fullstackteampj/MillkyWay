package book;

import java.sql.*;
import java.util.Vector;

import DBConnection.DBConnectionMgr;
import beans.MemberBean;

public class BookOrderMgr {
	private DBConnectionMgr pool;
	
	public BookOrderMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}//OrderMgr()
	
	//userid값을 통해 결제에 필요한 회원 정보 가져오기
	public Vector<MemberBean> getMember(int userid){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBean> mlist = new Vector<MemberBean>();
		
		try {
			con = pool.getConnection();
			sql = "select * from membertbl where userid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberBean bean = new MemberBean();
				bean.setName(rs.getString("name"));
				bean.setPhoneNum(rs.getString("phone"));
				bean.setZipcode(rs.getString("zipcode"));
				bean.setAddress(rs.getString("address"));
				bean.setDetailAddress(rs.getString("detailaddress"));
				bean.setCurpoint(rs.getInt("curpoint"));
				mlist.add(bean);
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return mlist;
		
	}
	
	//장바구니 클릭시 carttbl에 입력하기
	public boolean insertCart (int userid, int bookid, int quantity) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "insert into carttbl (userid, bookid, quantity, status, added_Date) values(?, ?, ?, ?, now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setInt(2, bookid);
			pstmt.setInt(3, quantity);
			pstmt.setString(4, "active");
			
			if(pstmt.executeUpdate() == 1) {
				flag = true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
	}
	
	//관심목록 클릭시 wishtbl에 입력하기
	public boolean insertWish (int userid, int bookid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "insert into wishtbl (userid, bookid, status, added_date) values(?, ?, ?, now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setInt(2, bookid);
			pstmt.setString(3, "active");
	
			if(pstmt.executeUpdate() == 1) flag = true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
	}
	
	//장바구니 넣기 전 테이블에 있는지 확인
	public boolean checkCart (int userid, int bookid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from carttbl where userid= ? and bookid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setInt(2, bookid);
			flag = pstmt.executeQuery().next();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
	}
	
	//장바구니에 이미 있을 경우 수량 +1 
	public boolean plusQCart (int userid, int bookid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update carttbl set (quantity = quantity + 1) where userid = ? and bookid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setInt(2, bookid);
			flag = pstmt.executeQuery().next();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
	}
	
	//관심목록 넣기 전 테이블에 있는지 확인
	public boolean checkWish (int userid, int bookid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "select * from wishtbl where userid = ? and bookid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setInt(2, bookid);
			flag = pstmt.executeQuery().next();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		
		return flag;
	}
	
	//구매테이블 추가
	public boolean insertPurchase(int userid, String[] bookids, String[] eachNum, String payMethod, int totalPrice) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    boolean flag = false;
	    Integer bundleId = null; //Integer변환시 null 가능
	    
	    try {
	        con = pool.getConnection();
	        
	        // 1. 묶음추가 (배열 길이가 1 이상일 때 - 여러권 구매)
	        if (bookids.length > 1) {
	            String bundleSql = "insert into purchase_bundle (userid, total_price, purchase_date) VALUES (?, ?, now())";
	            pstmt = con.prepareStatement(bundleSql, Statement.RETURN_GENERATED_KEYS);
	            pstmt.setInt(1, userid);
	            pstmt.setInt(2, totalPrice);
	            pstmt.executeUpdate();
	            
	            // 2. 생성된 bundleId 가져오기
	            ResultSet rs = pstmt.getGeneratedKeys();
	            if (rs.next()) {
	                bundleId = rs.getInt(1);
	            }
	        }
	        
	        // 3. 각 구매 추가
	        if(bookids.length > 1) {//여러권 구매일 경우 - bundleid 추가
	        	sql = "insert into purchasetbl (userid, bookid, quantity, pay_method, purchase_date, bundleid) "
	        			+ "values (?, ?, ?, ?, now(), ?)";
	        	
	        	for (int i = 0; i < bookids.length; i++) {
	        		pstmt = con.prepareStatement(sql);
	        		pstmt.setInt(1, userid);
	        		pstmt.setInt(2, Integer.parseInt(bookids[i]));
	        		pstmt.setInt(3, Integer.parseInt(eachNum[i]));
	        		pstmt.setString(4, payMethod);
	        		pstmt.setInt(5, bundleId);
	        		
	        		if (pstmt.executeUpdate() == 1) 
	        			flag = true;
	        		
	        	}//for
	        }else{//단권 구매일 경우 - bundleid null
	        	sql = "insert into purchasetbl (userid, bookid, quantity, pay_method, purchase_date) "
	        			+ "values (?, ?, ?, ?, now())";
	        	
	        	for (int i = 0; i < bookids.length; i++) {
	        		pstmt = con.prepareStatement(sql);
	        		pstmt.setInt(1, userid);
	        		pstmt.setInt(2, Integer.parseInt(bookids[i]));
	        		pstmt.setInt(3, Integer.parseInt(eachNum[i]));
	        		pstmt.setString(4, payMethod);
	        		
	        		if (pstmt.executeUpdate() == 1) 
	        			flag = true;
	        	}//for
	        }//else
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	    
	    return flag;
	}

	
	//포인트 사용시 membertbl 수정
	public boolean updateMemberPoint(int userid, int usePoint, int savePoint){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update membertbl set (curpoint = curpoint - ?), (expectpoint = expectpoint + ?) where userid = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, usePoint);
			pstmt.setInt(2, savePoint); //누적합계로 처리했는데 관리자 페이지에서 포인트관리 어떻게 할지 보고 수정 필요?!
			pstmt.setInt(3, userid);
			if(pstmt.executeUpdate() == 1) flag = true;
			
		}catch(Exception e) {
			e.printStackTrace();	
		}finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	};
	
	//포인트관리 테이블 추가
	public boolean insertPointManage(int userid, int point, String division) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "insert into pointmanagementtbl (userid, point, division, update_date) values(?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setInt(2, point);
			pstmt.setString(3, division);
			
			if(pstmt.executeUpdate() == 1) flag = true;
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
}
