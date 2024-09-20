package board;

import java.io.IOException;

import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import DBConnection.DBConnectionMgr;
import beans.BoardBean;
import beans.CommentBean;

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
			
			
			sql += " order by boardid desc limit " + start + ", " + end;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setBoardid(rs.getInt("boardid"));
				bean.setUserid(rs.getInt("userid"));
				bean.setNickname(rs.getString("nickname"));
				bean.setTitle(rs.getString("title"));
				bean.setContent(rs.getString("content"));
				if(rs.getBlob("photo") != null) {
					Blob photoBlob = rs.getBlob("photo");
					byte[] photo = photoBlob.getBytes(1, (int)photoBlob.length());
					bean.setPhoto(photo);
				}
				bean.setGenre(rs.getString("genre"));
				bean.setTab(rs.getString("tab"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				bean.setLiked(rs.getInt("liked"));
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
		
		BoardBean bean = null;
		
		try {
			con = pool.getConnection();
			sql = "select * from boardtbl where boardid =" +boardid;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				bean = new BoardBean();
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
	
	// 조회수 증가
	public void upCount(int boardid) {
		int count = 0;
		
		try {
			con = pool.getConnection();
			sql = "update boardtbl set count = count+1 where boardid = " + boardid;
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 추천수 증가
	public int upLike(HttpServletRequest req) {
		String boardid = req.getParameter("num");
		int updateLiked = 0;
		try {
			// 추천 수 증가
			con = pool.getConnection();
			sql = "update boardtbl set liked = liked+1 where boardid = " + boardid;
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			
			// 증가된 추천 수 추출
			sql = "select liked from boardtbl where boardid = " + boardid;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				updateLiked = rs.getInt("liked");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		return updateLiked;
	}
	
	// 총 댓글 수 반환
	public int getCommentCount(int boardid) {
		int count = 0;
		
		try {
			con = pool.getConnection();
			sql = "select count(commentid) from commenttbl where ref=" + boardid;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				count = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return count;
	}
	
	// 댓글 반환
	public ArrayList<CommentBean> getCommentList(int boardid) {
		ArrayList<CommentBean> clist = new ArrayList<CommentBean>();
		
		try {
			con = pool.getConnection();
			sql = "select * from commenttbl where ref=" + boardid;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CommentBean bean = new CommentBean();
				bean.setCommentid(rs.getInt("commentid"));
				bean.setUserid(rs.getInt("userid"));
				bean.setNickname(rs.getString("nickname"));
				bean.setContent(rs.getString("content"));
				bean.setRef(rs.getInt("ref"));
				bean.setPos(rs.getInt("pos"));
				bean.setDepth(rs.getInt("depth"));
				bean.setParentCommentid(rs.getInt("parent_commentid"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setUpdateDate(rs.getString("update_date"));
				bean.setIp(rs.getString("ip"));
				bean.setStatus(rs.getInt("status"));
				clist.add(bean);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return clist;
	}
	
	// 댓글 작성
	public void insertComment(HttpServletRequest req) {
		
		try {
			con = pool.getConnection();
			sql = "insert into commenttbl (userid, nickname, content, ref, pos, depth, regdate, ip)"
					+ "values (?, ?, ?, ?, 0, 0, now(), ?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(req.getParameter("userid")));
			pstmt.setString(2, req.getParameter("nickname"));
			pstmt.setString(3, req.getParameter("inputComment"));
			pstmt.setInt(4, Integer.parseInt(req.getParameter("ref")));
			pstmt.setString(5, req.getParameter("userip"));
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	/* board03(글수정페이지) 활용메서드 */
	public boolean editBoard(HttpServletRequest req) throws ServletException, IOException {
		Part imagePart = req.getPart("uploadFile");
    	InputStream imageInputStream = imagePart.getInputStream();
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "update boardtbl set nickname=?, title=?, content=?, photo=?, genre=?,"
					+ "tab=?, ip=?, update_date=? where boardid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, req.getParameter("nickname"));
			pstmt.setString(2, req.getParameter("postTit"));
			pstmt.setString(3, req.getParameter("postCont"));
			pstmt.setBlob(4, imageInputStream);
			pstmt.setString(5, req.getParameter("postGenre"));
			pstmt.setString(6, req.getParameter("postTab"));
			pstmt.setString(7, req.getParameter("userip"));
			DateMgr dMgr = new DateMgr();
			pstmt.setString(8, dMgr.getToday());
			pstmt.setInt(9, Integer.parseInt(req.getParameter("boardid")));
			pstmt.executeUpdate();
			flag = true;
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	/* board04(글작성페이지) 활용메서드 */
	// 글작성 insert
	public boolean insertBoard(HttpServletRequest req) throws ServletException, IOException {

    	Part imagePart = req.getPart("uploadFile");
    	InputStream imageInputStream = imagePart.getInputStream();
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "insert into boardtbl (userid, nickname, title, content, photo, genre, tab, ip)"
					+ "values (?, ?, ?, ?, ?, ?, ?, ?);";
			pstmt = con.prepareStatement(sql);
			// jsp에서 userid받아 보내야함
			 pstmt.setInt(1, Integer.parseInt(req.getParameter("userid")));
			 pstmt.setString(2, req.getParameter("nickname"));
			 pstmt.setString(3, req.getParameter("postTit"));
			 pstmt.setString(4, req.getParameter("postCont"));
			 pstmt.setBlob(5, imageInputStream);
			 pstmt.setString(6, req.getParameter("postGenre"));
			 pstmt.setString(7, req.getParameter("postTab"));
			 pstmt.setString(8, req.getParameter("userip"));
			 pstmt.executeUpdate();

			flag = true;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	
	/* board05(글삭제페이지) 활용메서드 */
	public boolean deleteBoard(HttpServletRequest req) {
		int userid = Integer.parseInt(req.getParameter("userid"));
		int inputPwd = Integer.parseInt(req.getParameter("pwd"));
		int boardid = Integer.parseInt(req.getParameter("boardid"));
		boolean flag = false;
		
		// 멤버테이블에서 글작성자의 userid와 일치하는 회원의 비밀번호를 추출
		try {
			con = pool.getConnection();
			sql = "select pwd from membertbl where userid = " + userid;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 글작성자의 비밀번호와 입력받은 비밀번호가 같으면
			if(rs.next()) {
				if(rs.getInt("pwd") == inputPwd) {
					sql = "update boardtbl set status = 9 where boardid = " + boardid;
					pstmt = con.prepareStatement(sql);
					pstmt.executeUpdate();
					flag = true;
				}				
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return flag;
	}
	
}
