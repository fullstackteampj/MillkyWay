package board;

import java.io.IOException;

import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.*;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import DBConnection.DBConnectionMgr;
import SHA256.SHASalt;
import beans.BoardBean;
import beans.BookBean;
import beans.CommentBean;
import beans.MemberBean;

public class BoardMgr {
	private DBConnectionMgr pool;
	
	public BoardMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 로그인 회원 닉네임 추출
	public String getNickname(int loginId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String userNickname = null;
		
		try {
			con = pool.getConnection();
			sql = "SELECT nickname FROM membertbl WHERE userid = "+loginId;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				userNickname = rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return userNickname;
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
					bean.setPhotoName(rs.getString("photo_name"));
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
	
	// 게시글 50개중 많이 다뤄진 책 top10 추출
	public ArrayList<int[]> getBestBookList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<int[]> bestBook = new ArrayList<int[]>();
		
		try {
			con = pool.getConnection();
			sql = "SELECT bookid, count(bookid) FROM "
					+ "(SELECT * FROM boardtbl WHERE status=0 ORDER BY regdate DESC LIMIT 0, 50) currentBoard "
					+ "WHERE bookid IS NOT null "
					+ "GROUP BY bookid ORDER BY count(bookid) DESC LIMIT 0, 10;";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int[] bestInfo = new int[2];
				bestInfo[0] = rs.getInt("bookid");
				bestInfo[1] = rs.getInt("count(bookid)");
				bestBook.add(bestInfo);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bestBook;
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
				if(rs.getBytes("photo") != null) {
					bean.setPhoto(rs.getBytes("photo"));
					bean.setPhotoName(rs.getString("photo_name"));
				}
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
	
	// 연관서적 정보 반환
	public BookBean getBook(int bookid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BookBean bean = new BookBean();
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM booktbl WHERE bookid="+bookid;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bean.setBookid(rs.getInt("bookid"));
				bean.setAuthor(rs.getString("author"));
				bean.setCategory(rs.getString("category"));
				bean.setGenre(rs.getString("genre"));
				bean.setTitle(rs.getString("title"));
				bean.setReview(rs.getString("review"));
				bean.setScore(rs.getInt("score"));
				bean.setContents(rs.getString("contents"));
				bean.setAuthorIntro(rs.getString("authorIntro"));
				bean.setContentsTables(rs.getString("contentsTables"));
				bean.setMiniIntro(rs.getString("miniIntro"));
				bean.setPhoto(rs.getBytes("photo"));
				bean.setPublish_date(rs.getString("publish_date"));
				bean.setIsbn(rs.getString("isbn"));
				bean.setStock_Quantity(rs.getInt("stock_Quantity"));
				bean.setPrice(rs.getInt("price"));
				bean.setPages(rs.getInt("pages"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return bean;
	}
	
	
	// 총 댓글 수 반환 - 삭제댓글 포함
	public int getCommentCount(int boardid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			con = pool.getConnection();
			sql = "select count(commentid) from commenttbl where boardid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardid);
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
	
	// 미삭제 댓글 수 반환
	public int getActiveComCount(int boardid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			con = pool.getConnection();
			sql = "select count(commentid) from commenttbl where boardid=? and status=0";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardid);
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
	
	// 등록순 댓글 목록 반환 -- status=0이거나 9이지만 자식댓글이 있는 댓글만 반환
	public ArrayList<CommentBean> getCommentList(int boardid, int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		ArrayList<CommentBean> clist = new ArrayList<CommentBean>();
				
		try {
			con = pool.getConnection();
			//sql = "select * from commenttbl where boardid=? and ((status=0) or (status=9 and totalChild>0)) order by ref, pos limit ?, ?;";
			sql = "select * from "
					//+ "(select * from commenttbl where boardid = ? and ( (status=0)  or (status=0 and totalChild>0) ) "
					+ "(select * from commenttbl where boardid = ? "
					+ "order by REF desc, pos desc limit ?,?) e "
					+ "order by ref, pos ASC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, boardid);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {					
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
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return clist;
	}
	
	// 최신순 댓글 목록 반환 -- status=0이거나 9이지만 자식댓글이 있는 댓글만 반환
		public ArrayList<CommentBean> getRecentCommentList(int boardid, int start, int end) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			
			ArrayList<CommentBean> clist = new ArrayList<CommentBean>();
					
			try {
				con = pool.getConnection();
				//sql = "select * from commenttbl where boardid=? and ((status=0) or (status=9 and totalChild>0)) order by ref, pos limit ?, ?;";
				sql = "select * from "
						+ "(select * from commenttbl where boardid = ? "
						+ "order by REF desc, pos desc limit ?,?) e "
						+ "order by ref desc, pos ASC";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, boardid);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {					
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
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return clist;
		}
	
	// 댓글정보 반환
	public CommentBean getComment(int commentId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		CommentBean bean = null;
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM commenttbl WHERE commentid = "+commentId;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean = new CommentBean();
				bean.setCommentid(rs.getInt("commentid"));
				bean.setUserid(rs.getInt("userid"));
				bean.setNickname(rs.getString("nickname"));
				bean.setContent(rs.getString("content"));
				bean.setBoardid(rs.getInt("boardid"));
				bean.setPos(rs.getInt("pos"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRef(rs.getInt("ref"));
				bean.setParentid(rs.getInt("parentid"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setUpdateDate(rs.getString("update_date"));
				bean.setDeleteDate(rs.getString("delete_date"));
				bean.setIp(rs.getString("ip"));
				bean.setStatus(rs.getInt("status"));
				bean.setTotalChild(rs.getInt("totalChild"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
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
	
	// 부모댓글의 ref 추출
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
	public int sameLevelPos(int depth, int parentId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int grandId = getGrandId(parentId);
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
				int countChild = getCountCommentChild(pos, parentId, depth); //같은레벨의 pos, 조상, 부모아이디, 부모깊이
				lastpos = pos+countChild+1;
				updatePos(grandId, lastpos);
			} else { // 없으면 직계부모댓글의 pos+1
				con = pool.getConnection();
				sql = "SELECT * FROM commenttbl WHERE commentid="+parentId;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					lastpos = rs.getInt("pos")+1; //2
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
	
	// 동레벨의 바로 다음댓글의 pos
	public int sameLevelNextPos(int depth, int parentId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int grandId = getGrandId(parentId);
		int nextpos = grandId+1;
		try {
			con = pool.getConnection();
			sql = "SELECT pos FROM commenttbl WHERE commentid = (SELECT commentid FROM commenttbl WHERE ref=? AND parentid=? AND depth=? ORDER BY pos LIMIT 1,1);";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, grandId);
			pstmt.setInt(2, parentId);
			pstmt.setInt(3, depth);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				nextpos = rs.getInt("pos");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return nextpos;
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
		int newpos = sameLevelPos(depth, parentId);
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
	
	// 조상댓글의 자손댓글 업데이트
	public void updateGrandChild(int ref, String event) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int commentid = getGrandId(ref);
		
		try {
			con = pool.getConnection();
			if(event.equals("reply")) {
				sql = "UPDATE commenttbl SET totalChild = totalChild+1 WHERE commentid="+commentid;
			} else if(event.equals("delete")) {
				sql = "UPDATE commenttbl SET totalChild = totalChild-1 WHERE commentid="+commentid;
			}
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 임시 : 대댓글의 자손댓글 업데이트
	public void updateChild(int parentid, int pos) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int ref = getGrandId(parentid);
		
		try {
			con = pool.getConnection();
			sql = "select * from commenttbl where ref=? and pos<=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, pos);
			rs = pstmt.executeQuery();
			//System.out.println("=====업데이트 후보 추출=====");
			//System.out.println("ref = "+ref);
			//System.out.println("pos = "+pos);
			
			sql = "UPDATE commenttbl SET totalChild = ? WHERE commentid=?";
			while(rs.next()) {
				int totalChild = getCountCommentChild(rs.getInt("pos"), rs.getInt("commentid"), rs.getInt("depth")-1);
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, totalChild);
				pstmt.setInt(2, rs.getInt("commentid"));
				//System.out.println("=====업데이트 내용 출력=====");
				//System.out.println("업데이트할 댓글id = "+rs.getInt("commentid"));
				//System.out.println("업데이트할 자식수 = "+totalChild);
				System.out.println();
				System.out.println();
				System.out.println();
				
				pstmt.executeUpdate();
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// 댓글의 자식갯수 추출
	public int getCountCommentChild(int pos, int parentId, int parentDepth) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		int countChild = 0;
		int grandId = getGrandId(parentId);
		int depth = parentDepth+1;
		try {
			con = pool.getConnection();
			// sql = "SELECT count(commentid) FROM commenttbl WHERE (ref=?) AND (pos>?) AND ((DEPTH>? AND parentid >=?) OR (DEPTH<=? AND parentid = ?));";
			sql = "SELECT count(commentid) FROM commenttbl WHERE (status=0) AND (ref=?) AND (pos>?) AND (DEPTH>?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, grandId);
			pstmt.setInt(2, pos);
			pstmt.setInt(3, depth);
			rs = pstmt.executeQuery();
			System.out.println("====자손조건====");
			System.out.println("ref가 "+grandId+" 와 같고");
			System.out.println("pos가 "+pos+" 보다 높고");
			System.out.println("depth가 "+depth+" 보다 높은것");
			if(rs.next()) {
				countChild = rs.getInt(1);
				System.out.println("countChild = "+countChild);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return countChild;
	}
	
	// 댓글의 대댓글 유무 반환
	public boolean hasComReply(int commentid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "SELECT commentid FROM commenttbl WHERE status = 0 AND parentid="+commentid;
			//sql = "SELECT totalChild FROM commenttbl WHERE commentid="+commentid;
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
		String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			
			// 새로운 사진이 있으면 업데이트
			if(imagePart != null && imagePart.getSize() > 0) {
				// 새로운 책이 있으면 업데이트
				if(!req.getParameter("postBook").equals("")) {
					sql = "update boardtbl set nickname=?, title=?, content=?, genre=?,"
							+ "tab=?, ip=?, update_date=?, photo=?, photo_name=?, bookid=? where boardid=?";
					pstmt = con.prepareStatement(sql);	
					pstmt.setBlob(8, imageInputStream);
					pstmt.setString(9, fileName);
					pstmt.setInt(10, Integer.parseInt(req.getParameter("postBook")));
					pstmt.setInt(11, Integer.parseInt(req.getParameter("boardid")));
				} else {
					// 새로운 책이 없으면 기존유지
					sql = "update boardtbl set nickname=?, title=?, content=?, genre=?,"
							+ "tab=?, ip=?, update_date=?, photo=?, photo_name=? where boardid=?";
					pstmt = con.prepareStatement(sql);	
					pstmt.setBlob(8, imageInputStream);
					pstmt.setString(9, fileName);
					pstmt.setInt(10, Integer.parseInt(req.getParameter("boardid")));
				}
			} else { // 새로운 사진이 없으면 기존 유지
				// 새로운 책이 있으면 업데이트
				if(!req.getParameter("postBook").equals("")) {
					sql = "update boardtbl set nickname=?, title=?, content=?, genre=?,"
							+ "tab=?, ip=?, update_date=?, bookid=? where boardid=?";
					pstmt = con.prepareStatement(sql);	
					pstmt.setInt(8, Integer.parseInt(req.getParameter("postBook")));
					pstmt.setInt(9, Integer.parseInt(req.getParameter("boardid")));
				} else {
					sql = "update boardtbl set nickname=?, title=?, content=?, genre=?,"
							+ "tab=?, ip=?, update_date=? where boardid=?";
					pstmt = con.prepareStatement(sql);	
					pstmt.setInt(8, Integer.parseInt(req.getParameter("boardid")));
				}
			}
			pstmt.setString(1, req.getParameter("nickname"));
			pstmt.setString(2, req.getParameter("postTit"));
			pstmt.setString(3, req.getParameter("postCont"));
			pstmt.setString(4, req.getParameter("postGenre"));
			pstmt.setString(5, req.getParameter("postTab"));
			pstmt.setString(6, req.getParameter("userip"));
			DateMgr dMgr = new DateMgr();
			pstmt.setString(7, dMgr.getToday());
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
    	String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
    	
		boolean flag = false;
		
		try {
			con = pool.getConnection();

			// 사진유무
			if(imagePart != null && imagePart.getSize() > 0) {
				// 선택한 도서 유무
				if(!req.getParameter("postBook").equals("")) {
					sql = "insert into boardtbl (userid, nickname, title, content, genre, tab, ip, bookid, photo, photo_name)"
							+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(8, Integer.parseInt(req.getParameter("postBook")));
					pstmt.setBlob(9, imageInputStream);
					pstmt.setString(10, fileName);
				} else {
					sql = "insert into boardtbl (userid, nickname, title, content, genre, tab, ip, photo, photo_name)"
							+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?);";
					pstmt = con.prepareStatement(sql);
					pstmt.setBlob(8, imageInputStream);
					pstmt.setString(9, fileName);
				}
			} else {
				// 선택한 도서 유무
				if(!req.getParameter("postBook").equals("")) {
					sql = "insert into boardtbl (userid, nickname, title, content, genre, tab, ip, bookid)"
							+ "values (?, ?, ?, ?, ?, ?, ?, ?);";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(8, Integer.parseInt(req.getParameter("postBook")));
				} else {
					sql = "insert into boardtbl (userid, nickname, title, content, genre, tab, ip)"
							+ "values (?, ?, ?, ?, ?, ?, ?);";
					pstmt = con.prepareStatement(sql);
				}
			}
			 pstmt.setInt(1, Integer.parseInt(req.getParameter("userid")));
			 pstmt.setString(2, req.getParameter("nickname"));
			 pstmt.setString(3, req.getParameter("postTit"));
			 pstmt.setString(4, req.getParameter("postCont"));
			 pstmt.setString(5, req.getParameter("postGenre"));
			 pstmt.setString(6, req.getParameter("postTab"));
			 pstmt.setString(7, req.getParameter("userip"));
			 pstmt.executeUpdate();

			flag = true;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 연관서적 검색 메서드
	public ArrayList<BookBean> getSearchBookList(String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ArrayList<BookBean> blist = new ArrayList<BookBean>();
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM booktbl WHERE (author LIKE '%"+keyword+"%') OR (title LIKE '%"+keyword+"%');";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BookBean bean = new BookBean();
				bean.setBookid(rs.getInt("bookid"));
				bean.setAuthor(rs.getString("author"));
				bean.setCategory(rs.getString("category"));
				bean.setGenre(rs.getString("genre"));
				bean.setTitle(rs.getString("title"));
				bean.setReview(rs.getString("review"));
				bean.setScore(rs.getInt("score"));
				bean.setContents(rs.getString("contents"));
				bean.setAuthorIntro(rs.getString("authorIntro"));
				bean.setContentsTables(rs.getString("contentsTables"));
				bean.setMiniIntro(rs.getString("miniIntro"));
				bean.setPhoto(rs.getBytes("photo"));
				bean.setPublish_date(rs.getString("publish_date"));
				bean.setIsbn(rs.getString("isbn"));
				bean.setStock_Quantity(rs.getInt("stock_Quantity"));
				bean.setPrice(rs.getInt("price"));
				bean.setPages(rs.getInt("pages"));
				blist.add(bean);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return blist;
	}
	
	
	/* board05(글삭제페이지) 활용메서드 */
	public boolean deleteBoard(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		
		int userid = Integer.parseInt(req.getParameter("userid"));
		int boardid = Integer.parseInt(req.getParameter("boardid"));
		
		// 유저의 salt를 추출해 입력받은 pwd를 암호화
		SHASalt saltMgr = new SHASalt();
		String inPwd = req.getParameter("pwd");
		String salt = getLoginSalt(userid);
		String CrPwd = saltMgr.getEncrypt(inPwd, salt);
		
		// 멤버테이블에서 글작성자의 userid와 일치하는 회원의 암호화된 비밀번호를 추출
		try {
			con = pool.getConnection();
			sql = "select pwd from membertbl where userid = " + userid;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 암호화된 글작성자의 비밀번호와 암호화된 입력받은 비밀번호가 같으면
			if(rs.next()) {
				if(CrPwd.equals(rs.getString("pwd"))) {
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
	
	// 로그인한 유저의 salt 추출
	public String getLoginSalt(int userid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String salt = null;
		
		try {
			con = pool.getConnection();
			sql = "select salt from membertbl where userid = " + userid;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				salt = rs.getString("salt");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return salt;
	}
	
	
	/* 임시 : 개발자용 */
	// 추천수증가
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
	
	
}
