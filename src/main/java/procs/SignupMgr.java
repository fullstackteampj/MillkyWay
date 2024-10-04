package procs;

import DBConnection.DBConnectionMgr;
import beans.MemberBean;
import java.sql.*;

public class SignupMgr {
	private  DBConnectionMgr pool;
	public SignupMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e) {
			System.out.println("Error : connection 에러");
		}
	}
	
	//id 중복 체크
	public boolean checkId(String account) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select account from membertbl where account = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, account);
			flag = pstmt.executeQuery().next();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
		
	}
	
	//별명 중복 체크
	public boolean checkNickname(String nickname) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select nickname from membertbl where nickname = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nickname);
			flag = pstmt.executeQuery().next();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//회원 가입
	public boolean insertMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert membertbl(account, pwd, name, phone, zipcode, address, detailAddress, nickname, question, answer, gender, birth, email, favorite, signup_date, agree, salt)" +
			"values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getAccount());
			pstmt.setString(2, bean.getPwd());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getPhoneNum() + bean.getPhone());
			pstmt.setString(5, bean.getZipcode());
			pstmt.setString(6, bean.getAddress());
			pstmt.setString(7, bean.getDetailAddress());
			pstmt.setString(8, bean.getNickname());
			pstmt.setString(9, bean.getQuestion());
			pstmt.setString(10, bean.getAnswer());
			pstmt.setString(11, bean.getGender());
			pstmt.setString(12, bean.getYear()+bean.getMonth()+bean.getDate());
			pstmt.setString(13, bean.getEmail());
			//도서 취향 저장
			String[] favorites = bean.getFavorite();
			if(favorites != null) {
				char[] fav = { '0', '0', '0', '0', '0', '0', '0' };
				String[] lists = {"소설", "로맨스", "여행", "미스터리", "과학", "만화", "판타지"};
				
				for(int i=0;i<favorites.length; i++) {
					for(int k=0; k<lists.length; k++) {
						if(favorites[i].equals(lists[k])) {
							fav[k] = '1';
						}
					}
				}
				pstmt.setString(14, new String(fav));
				
			}else {
				pstmt.setString(14, "0000000");
			}
			pstmt.setString(15, bean.getAgree());
			pstmt.setString(16, bean.getSalt());
			
			System.out.println("bean.getSalt = "+bean.getSalt());
			System.out.println("bean.getPwd() = "+ bean.getPwd());
			
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

}
