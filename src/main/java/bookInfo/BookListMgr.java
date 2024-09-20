package bookInfo;

import java.sql.*;

import DBConnection.DBConnectionMgr;

public class BookListMgr {
	
	private DBConnectionMgr pool;
	
	public BookListMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	//장르에 따른 총 게시물 수
	public int getTotalCounnt(String keyField) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			
			if(keyField.equals("null") || keyField.equals("")) {
				//조건 없이 전체 레코드
				sql = "select count(bookid) from booktbl";
				pstmt = con.prepareStatement(sql);
			}else {
				//조건 만족 레코드
				//sql = "select count(bookid) from booktbl where"
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
}
