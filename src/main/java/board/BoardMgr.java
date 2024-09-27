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
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<BoardBean> postList = new ArrayList<BoardBean>();
		
		try {
			con = pool.getConnection();
			// status=0인것만 boardid 내림차순으로 현재페이지 기준으로 추출
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
			System.out.println("start = "+start);
			System.out.println("end = "+end);
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
	
	// 인기글 목록추출 (인기글탭)
	public ArrayList<BoardBean> getBestList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<BoardBean> bList = new ArrayList<BoardBean>();
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM boardtbl WHERE status=0 AND best='Y'"
					+ "ORDER BY regdate DESC LIMIT 0, 6;";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setBoardid(rs.getInt("boardid"));
				bean.setTitle(rs.getString("title"));
				bList.add(bean);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return bList;
	}
	
	// 현재 불러온 총 게시글 수 반환
	public int getTotalCount(String keyField, String keyWord, String category, String tab) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
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
			
			if(rs.next()) {
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
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
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
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
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
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
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
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
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
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int boardid = Integer.parseInt(req.getParameter("ref"));
		int userid = Integer.parseInt(req.getParameter("userid"));
		int updateLiked = 0;
		try {
			// 추천 수 증가
			con = pool.getConnection();
			sql = "INSERT INTO likedtbl (ref, userid) VALUES (?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardid);
			pstmt.setInt(2, userid);
			pstmt.executeUpdate();
			
			// 증가된 추천 수 추출
			sql = "select count(likedid) from likedtbl where ref=" + boardid;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				updateLiked = rs.getInt(1);
				
				if(updateLiked >= 15) {
					// 추천수가 15이상이면 인기글부여
					sql = "UPDATE boardtbl SET best = 'Y' WHERE boardid=" + boardid;
					pstmt = con.prepareStatement(sql);
					pstmt.executeUpdate();
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return updateLiked;
	}
	
	// 임시 !! 개발자용: 추천수
	public int upLike(int ref, int uid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int boardid = ref;
		int userid = uid;
		int updateLiked = 0;
		try {
			// 추천 수 증가
			con = pool.getConnection();
			sql = "INSERT INTO likedtbl (ref, userid) VALUES (?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardid);
			pstmt.setInt(2, userid);
			pstmt.executeUpdate();
			
			// 증가된 추천 수 추출
			sql = "select count(likedid) from likedtbl where ref=" + boardid;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				updateLiked = rs.getInt(1);
				
				if(updateLiked >= 15) {
					// 추천수가 15이상이면 인기글부여
					sql = "UPDATE boardtbl SET best = 'Y' WHERE boardid=" + boardid;
					pstmt = con.prepareStatement(sql);
					pstmt.executeUpdate();
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return updateLiked;
	}
	
	// 누적 추천 수 반환
	public int getLikedCount(int boardid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			con = pool.getConnection();
			sql = "select count(likedid) from likedtbl where ref=" + boardid;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return count;
	}
	
	// 추천 중복 체크
	public boolean hasLikeSameId(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		int boardid = Integer.parseInt(req.getParameter("ref"));
		int userid = Integer.parseInt(req.getParameter("userid"));
		boolean result = false;
		
		try {
			con = pool.getConnection();
			sql = "select count(likedid) from likedtbl where ref=? and userid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardid);
			pstmt.setInt(2, userid);			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1) > 0; // count가 0보다 크면 true
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return result;
	}
	
	// 총 댓글 수 반환
	public int getCommentCount(int boardid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			con = pool.getConnection();
			sql = "select count(commentid) from commenttbl where status=0 and boardid=" + boardid;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return count;
	}
	
	// 댓글 목록 반환 -- status=0이거나 9이지만 자식댓글이 있는 댓글만 반환
	public ArrayList<CommentBean> getCommentList(int boardid, int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<CommentBean> clist = new ArrayList<CommentBean>();
				
		try {
			con = pool.getConnection();
			sql = "select * from commenttbl where boardid=" + boardid + " order by ref, pos limit "+start+", "+end+";";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				if(rs.getInt("status") == 0 || hasComReply(rs.getInt("commentid"))) {					
					CommentBean bean = new CommentBean();
					bean.setCommentid(rs.getInt("commentid"));
					bean.setUserid(rs.getInt("userid"));
					bean.setNickname(rs.getString("nickname"));
					bean.setContent(rs.getString("content"));
					bean.setBoardid(rs.getInt("boardid"));
					bean.setPos(rs.getInt("pos"));
					bean.setDepth(rs.getInt("depth"));
					bean.setRef(rs.getInt("ref"));
					bean.setRegdate(rs.getString("regdate"));
					bean.setUpdateDate(rs.getString("update_date"));
					bean.setIp(rs.getString("ip"));
					bean.setStatus(rs.getInt("status"));
					clist.add(bean);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return clist;
	}
	
	// 모든이전댓글페이지에서 삭제되어 미출력된(자식댓글이 없는) 모든 댓글 누적갯수 반환
	public int getTotalPrevDelCount(int boardid, int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalDelCount = 0;
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM commenttbl WHERE boardid = ? AND status=9 LIMIT 0, ?";
			pstmt = con.prepareStatement(sql);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalDelCount;
	}
	
	// (연산 후 start)현재 댓글페이지에서 삭제되어 미출력된(자식댓글이 없는) 댓글 갯수 반환
	public int getDeleteComCount(int boardid, int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int delCount = 0;
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM commenttbl WHERE boardid = ? AND status=9 LIMIT ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardid);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				if(!hasComReply(rs.getInt("commentid"))) {
					delCount++;
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		System.out.println("delCount = " + delCount);
		return delCount;
	}
	
	// 댓글작성자 반환
	public int getCommentUser(int commentId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int userid = 0;
		
		try {
			con = pool.getConnection();
			sql = "SELECT userid FROM commenttbl WHERE commentid = "+commentId;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				userid = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return userid;
	}
	
	// 마지막댓글의 id추출
	public int getLastComId() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int lastId = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT commentid FROM commenttbl ORDER BY commentid DESC LIMIT 1";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				lastId = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return lastId;
	}
	
	// 부모댓글의 parentId 추출
	public int getGrandId(int parentId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int parentPos = 1;
		try {
			con = pool.getConnection();
			sql = "SELECT ref FROM commenttbl WHERE commentid="+parentId;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				parentPos = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return parentPos;
	}
	
	// 댓글의 자식갯수 추출
	public int getCountCommentChild(int pos, int grandId, int parentId, int parentDepth) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int countChild = 0;
		int depth = parentDepth+1;
		System.out.println("----------------------------");
		System.out.println("ref="+grandId);
		System.out.println("pos="+pos);
		System.out.println("depth="+depth);
		System.out.println("parentId="+parentId);
		System.out.println("----------------------------");
		try {
			con = pool.getConnection();
			// sql = "SELECT count(commentid) FROM commenttbl WHERE (ref=?) AND (pos>?) AND ((DEPTH>? AND parentid >=?) OR (DEPTH<=? AND parentid = ?));";
			sql = "SELECT count(commentid) FROM commenttbl WHERE (ref=?) AND (pos>?) AND (DEPTH>?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, grandId);
			pstmt.setInt(2, pos);
			pstmt.setInt(3, depth);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				countChild = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return countChild;
	}
	
	// 댓글 pos값 업데이트
	public void updatePos(int ref, int pos) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "UPDATE commenttbl SET pos = pos+1 WHERE ref=? AND pos >=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, pos);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 조상id가 같고 부모id가 같고 depth가 같은(동일 조상, 동일 부모, 동일 레벨의) 마지막 대댓의 pos
	public int sameLevelPos(int grandId, int depth, int parentId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int lastpos = grandId+1;
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM commenttbl WHERE ref=? AND parentid=? AND depth=? ORDER BY pos DESC LIMIT 1;";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, grandId);
			pstmt.setInt(2, parentId);
			pstmt.setInt(3, depth+1);
			rs = pstmt.executeQuery();
			if(rs.next()) { // 있으면 그거의 pos+1 하고 그값보다 같거나 높은 pos값들은 전부 +1로 업데이트
				int pos = rs.getInt("pos");
				int countChild = getCountCommentChild(pos, grandId, parentId, depth); //같은레벨의 pos, 조상, 부모아이디, 부모깊이
				lastpos = pos+countChild+1;
				System.out.println("조상,부모,뎁스같은거 잇음 그거의 pos+자식갯수+1 하고 그값보다 같거나 높은 pos값들은 전부 +1로 업데이트");
				System.out.println("countChild = "+countChild);
				updatePos(grandId, lastpos);
			} else { // 없으면 직계부모댓글의 pos+1
				con = pool.getConnection();
				sql = "SELECT * FROM commenttbl WHERE commentid="+parentId;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					lastpos = rs.getInt("pos")+1; //2
					System.out.println("조상같고뎁스같은거 없음 직계부모댓글의 pos+1 하고 그값보다 같거나 높은 pos값 업데이트");
					updatePos(grandId, lastpos);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return lastpos;
	}
	
	// 댓글 작성
	public void insertComment(int userid, String nickname, int boardid, String userip, String commentMsg, String regDate) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int ref = getLastComId()+1;
		try {
			con = pool.getConnection();
			sql = "insert into commenttbl (userid, nickname, content, boardid, pos, depth, ref, regdate, ip)"
					+ "values (?, ?, ?, ?, 0, 0, ?, ?, ?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setString(2, nickname);
			pstmt.setString(3, commentMsg);
			pstmt.setInt(4, boardid);
			pstmt.setInt(5, ref);			
			pstmt.setString(6, regDate);
			pstmt.setString(7, userip);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 대댓글(답글) 작성
	public void insertReply(int userid, String nickname, int boardid, String userip, String commentMsg, String regDate, int parentId, int depth, int pos) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int grandId = getGrandId(parentId);
		int newpos = sameLevelPos(grandId, depth, parentId);
		//System.out.println("grandId = " + grandId);
		//System.out.println("pos = " + pos);
		try {
			con = pool.getConnection();
			sql = "insert into commenttbl (userid, nickname, content, boardid, pos, depth, regdate, ip, ref, parentid)"
					+ "values (?, ?, ?, ?, ?, ?, now(), ?, ?, ?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setString(2, nickname);
			pstmt.setString(3, commentMsg);
			pstmt.setInt(4, boardid);
			pstmt.setInt(5, newpos);
			pstmt.setInt(6, depth+=1);
			pstmt.setString(7, userip);
			pstmt.setInt(8, grandId);
			pstmt.setInt(9, parentId);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// 댓글의 대댓글 유무 반환
	public boolean hasComReply(int commentId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "SELECT commentid FROM commenttbl WHERE status = 0 AND parentid="+commentId;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 댓글 삭제
	public void deleteComment(int commentid, String deldate) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "UPDATE commenttbl SET status = 9, delete_date = ? WHERE commentid="+commentid;
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, deldate);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 댓글 수정
	public void editComment(int commentid, String loginNickname, String userip, String commentMsg, String updateDate) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;		
		try {
			con = pool.getConnection();
			sql = "UPDATE commenttbl SET nickname=?, content=?, update_date=?, ip=? WHERE commentid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, loginNickname);
			pstmt.setString(2, commentMsg);
			pstmt.setString(3, updateDate);
			pstmt.setString(4, userip);
			pstmt.setInt(5, commentid);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	/* board03(글수정페이지) 활용메서드 */
	public boolean editBoard(HttpServletRequest req) throws ServletException, IOException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
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
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

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
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
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
