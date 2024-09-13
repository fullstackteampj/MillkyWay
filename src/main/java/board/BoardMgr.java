package board;

import java.sql.*;
import java.util.ArrayList;
import DBConnection.DBConnectionMgr;

public class BoardMgr {
	private DBConnectionMgr pool;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
	public BoardMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/* board01(메인페이지) 활용메서드 */
	// 게시글 목록 추출
	public ArrayList<BoardBean> getPostList(String keyField, String keyWord, String category, String tab, int start, int end) {
		ArrayList<BoardBean> postList = new ArrayList<BoardBean>();
		
		try {
			con = pool.getConnection();
			sql = "select * from boardtbl where status=0";

			// 검색어값이 존재할경우
			if(!(keyWord == null || keyWord.equals(""))) {
				// 제목+내용 검색이면
				if(keyField.equals("multiple")) {
					sql += " and (title like '%" + keyWord + "%' or content like '%" + keyWord + "%')";
					
				} else { // 그 외(제목만, 내용만, 작성자) 검색이면
					sql += " and " + keyField + " like '%" + keyWord + "%'";
				}
			}
			
			// 카테고리값이 존재하면서 "전체"가 아닌 경우
			if((!(category == null || category.equals(""))) && (!category.equals("전체"))) {
				sql += " and genre= '" + category + "'";
			}
			
			// 탭값이 존재할경우
			if(!(tab == null || tab.equals(""))) {
				// "전체"와 "인기"가 아닐경우
				if(!tab.equals("전체") && !tab.equals("인기")) {
					sql += " and tab= '" + tab + "'";
					
				} else if(tab.equals("인기")) { // "인기"일경우
					sql += " and best='Y'";
				}
			}
			
			
			sql += " order by regdate desc limit " + start + ", " + end;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setBoardid(rs.getInt("boardid"));
				bean.setUserid(rs.getInt("userid"));
				bean.setNickname(rs.getString("nickname"));
				bean.setTitle(rs.getString("title"));
				bean.setContent(rs.getString("content"));
				bean.setPhoto(rs.getBytes("photo"));
				bean.setGenre(rs.getString("genre"));
				bean.setTab(rs.getString("tab"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				bean.setLiked(rs.getInt("liked"));
				bean.setCommentCount(rs.getInt("comment_count"));
				bean.setBest(rs.getString("best"));
				bean.setBookid(rs.getInt("bookid"));
				bean.setIp(rs.getString("ip"));
				bean.setUpdateDate(rs.getString("update_Date"));
				bean.setStatus(rs.getInt("status"));
				postList.add(bean);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return postList;
	}
	
	
	// 현재 불러온 총 게시글 수 반환
	public int getTotalCount(String keyField, String keyWord, String category, String tab) {
		
		int totalCount=0;
		
		try {
			con = pool.getConnection();
			sql = "select count(boardid) from boardtbl where status=0";

			// 검색어값이 존재할경우
			if(!(keyWord == null || keyWord.equals(""))) {
				// 제목+내용 검색이면
				if(keyField.equals("multiple")) {
					sql += " and (title like '%" + keyWord + "%' or content like '%" + keyWord + "%')";
					
				} else { // 그 외(제목만, 내용만, 작성자) 검색이면
					sql += " and " + keyField + " like '%" + keyWord + "%'";
				}
			}
			
			// 카테고리값이 존재하면서 "전체"가 아닌 경우
			if((!(category == null || category.equals(""))) && (!category.equals("전체"))) {
				sql += " and genre= '" + category + "'";
			}
			
			// 탭값이 존재할경우
			if(!(tab == null || tab.equals(""))) {
				// "전체"와 "인기"가 아닐경우
				if(!tab.equals("전체") && !tab.equals("인기")) {
					sql += " and tab= '" + tab + "'";
					
				} else if(tab.equals("인기")) { // "인기"일경우
					sql += " and best='Y'";
				}
			}
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				totalCount = rs.getInt(1);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
				
		return totalCount;
	}
	
	// 카테고리 목록 반환
	public ArrayList<String> getCategoryList() {
		
		ArrayList<String> cList = new ArrayList<String>();
		
		try {
			con = pool.getConnection();
			sql = "select category from categoryForAdmintbl";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				cList.add(rs.getString("category"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return cList;
	}
	
	// 탭 목록 반환
	public ArrayList<String> getTabList() {
		
		ArrayList<String> tList = new ArrayList<String>();
		
		try {
			con = pool.getConnection();
			sql = "select tab from tabForAdmintbl";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				tList.add(rs.getString("tab"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return tList;
	}
	

	/* board02(글읽기페이지) 활용메서드 */
	// 글에대한 데이터 bean 반환
	public BoardBean getPost(int boardid) {
		
		BoardBean bean = new BoardBean();
		
		try {
			con = pool.getConnection();
			sql = "select * from boardtbl where boardid =" +boardid;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				bean.setBoardid(rs.getInt("boardid"));
				bean.setUserid(rs.getInt("userid"));
				bean.setNickname(rs.getString("nickname"));
				bean.setTitle(rs.getString("title"));
				bean.setContent(rs.getString("content"));
				bean.setPhoto(rs.getBytes("photo"));
				bean.setGenre(rs.getString("genre"));
				bean.setTab(rs.getString("tab"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				bean.setLiked(rs.getInt("liked"));
				bean.setCommentCount(rs.getInt("comment_count"));
				bean.setBest(rs.getString("best"));
				bean.setBookid(rs.getInt("bookid"));
				bean.setIp(rs.getString("ip"));
				bean.setUpdateDate(rs.getString("update_date"));
				bean.setStatus(rs.getInt("status"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return bean;
	}
}
