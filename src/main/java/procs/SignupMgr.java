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
			System.out.print(flag);
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
			sql = "insert membertbl(account, pwd, name, phone, zipcode, address, nickname, question, answer, gender, birth, email, favorite, signup_date, agree)" +
			"values(?,?,?,?,?,?,?,?,?,?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getAccount());
			pstmt.setString(2, bean.getPwd());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getPhone() + bean.getPhoneNum());
			pstmt.setString(5, bean.getZipcode());
			pstmt.setString(6, bean.getAddress());
			pstmt.setString(7, bean.getNickname());
			pstmt.setString(8, bean.getQuestion());
			pstmt.setString(9, bean.getAnswer());
			pstmt.setString(10, bean.getGender());
			pstmt.setString(11, bean.getYear()+bean.getMonth()+bean.getDate());
			pstmt.setString(12, bean.getEmail());
			//도서 취향 저장
			String[] favorite = bean.getFavorite();
			if(favorite != null) {
				char[] fav = { '0', '0', '0', '0', '0', '0', '0' };
				String[] lists = {"소설", "로맨스", "여행", "미스터리", "과학", "만화", "판타지"};
				
				for(int i=0;i<favorite.length; i++) {
					for(int k=0; k<lists.length; k++) {
						if(favorite[i].equals(lists[k])) {
							fav[k] = '1';
						}
					}
				}
				pstmt.setString(13, new String(fav));
				
			}else {
				pstmt.setString(13, "0000000");
			}
			
			//선택 사항 동의여부
			boolean useInfo = false;
			String[] agrees = bean.getAgree();
			for(int a=0; a<agrees.length; a++) {
				if(agrees[a].contains("useInfo")) useInfo = true;
			}
			if(useInfo) {
				pstmt.setString(14, "agree");
			}else {
				pstmt.setString(14, "disagree");
			}
			
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
