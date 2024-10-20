package routeServlet;


import javax.servlet.ServletException;

import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Base64;

import board.BoardMgr;
import beans.BoardBean;
import beans.BoardFilterBean;
import beans.BookBean;
import beans.CommentBean;
import beans.boardPagingBean;


public class BoardServlet extends HttpServlet {
		
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	request.setCharacterEncoding("UTF-8");
    	response.setCharacterEncoding("UTF-8");
    	
    	// 요청URL 불러오기
    	String path = request.getPathInfo();
    	
    	// 메인페이지
    	if("/board01".equals(path)) {
    		HttpSession session = request.getSession();
	    	Integer loginId = null;
	    	
	    	if(session != null && session.getAttribute("idKey") != null) {
	    		loginId = (Integer)session.getAttribute("idKey");
	    	}
	    	
	    	int totalRecord=0;		// 전체 레코드수
	    	int numPerPage=10;		// 페이지당 레코드 수 
	    	int pagePerBlock=10;	// 블럭당 페이지수 
	    	int totalPage=0;		// 전체 페이지 수
	    	int totalBlock=0;		// 전체 패이지 블럭수 
	    	int nowPage=1;			// 현재 페이지
	    	int nowBlock=1;			// 현재 페이지블럭
	    	int start=0;			//디비의 select 시작번호
	    	int end=10;				//시작번호로 부터 가져올 select 갯수
	    	int listSize=0;			// DB로부터 추출해 list에 저장한 게시글의 수
	    	
	    	// 글목록 필터링
	    	String keyWord= request.getParameter("keyWord") != null ? request.getParameter("keyWord") : "";
	    	String keyField = request.getParameter("keyWord") != null ? request.getParameter("keyField") : "";
	    	String category = request.getParameter("category") != null ? request.getParameter("category") : "전체";
	    	String tab = request.getParameter("tab") != null ? request.getParameter("tab") : "전체";
	    	
	    	// 현재페이지가 바뀔때마다 초기화
	    	if(request.getParameter("nowPage") != null) {
	    		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	    	}
	    	
	    	// 페이지이동 시 게시글을 DB에서 추출할 때 기준이 되는 값을 초기화
	    	start = (nowPage * numPerPage)-numPerPage; 
	    	end = numPerPage;
	    	
	    	// 페이징, 글목록출력 등에 활용될 변수 초기화 (총게시글수, 총페이지수, 현재블럭, 총블럭수)
	    	BoardMgr bMgr = new BoardMgr();
	    	totalRecord = bMgr.getTotalCount(keyField, keyWord, category, tab);
	    	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);	//전체페이지수
	    	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);		//현재블럭 계산
	    	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);	//전체블럭계산
	    	int pageStart = (nowBlock-1)*pagePerBlock+1;					//현재 블럭에서의 시작번호 (현재블럭과 블럭당페이지수로 계산)
	    	int pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1; //현재 블럭에서의 끝번호 ()
	    	
	    	
	    	// 카테고리, 탭 리스트
	    	ArrayList<String> cList = bMgr.getCategoryList();
	    	ArrayList<String> tList = bMgr.getTabList();
	    	
	    	// 글 정보 추출
	    	ArrayList<BoardBean> postList = bMgr.getPostList(keyField, keyWord, category, tab, start, end);
	        listSize = postList.size();
	        
	        // Base64로 인코딩한 이미지 데이터를 추가
	        for (BoardBean post : postList) {
	            if (post.getPhoto() != null) {
	                // Base64로 인코딩
	                String encodedPhoto = Base64.getEncoder().encodeToString(post.getPhoto());
	                post.setEncodedPhoto(encodedPhoto);
	            }
	        }
	        
	        // 인기글 목록 추출 
        	ArrayList<BoardBean> bestList = bMgr.getBestList();
        	
        	// 최근글 중 많이 언급되는 책 목록 추출 
        	ArrayList<int[]> bestBookList = bMgr.getBestBookList();
        	
        	// 쿠키 추출
        	String readPosts = null;
        	Cookie[] cookies = request.getCookies();
        	if(cookies != null) {
        		for(Cookie cookie : cookies) {
        			if(cookie.getName().equals("readPosts")) {
        				readPosts = URLDecoder.decode(cookie.getValue());
        				break;
        			}
        		}
        	}
			
	    	// 결과를 request에 저장
	    	boardPagingBean paging = new boardPagingBean(totalRecord, numPerPage, pagePerBlock,
	    			totalPage, totalBlock, nowPage, nowBlock, start, end, listSize, pageStart, pageEnd);
	    	BoardFilterBean filter = new BoardFilterBean(keyWord, keyField, category, tab);
	    	
	    	request.setAttribute("loginId", loginId);
	    	request.setAttribute("paging", paging);
	    	request.setAttribute("filter", filter);
	    	request.setAttribute("cList", cList);
	    	request.setAttribute("tList", tList);
	    	request.setAttribute("postList", postList);
	    	request.setAttribute("bestList", bestList);
	    	request.setAttribute("bestBookList", bestBookList);
	    	request.setAttribute("readPosts", readPosts);
    	}
    	
    	// 글읽기 페이지
    	if("/board02".equals(path)) {

    		int num = Integer.parseInt(request.getParameter("num"));
    		String numS = request.getParameter("num");
    		BoardMgr bMgr = new BoardMgr();
    		
    		// 조회수 증가
    		bMgr.upCount(num);
    		
    		Integer loginId = null;
    		String loginNickname = null;
    		
    		// 로그인 상태면 필요한 데이터 추출(id, nickname)
    		HttpSession session = request.getSession();
    		if(session != null && session.getAttribute("idKey") != null) {
    			loginId = (Integer)session.getAttribute("idKey");
    			loginNickname = bMgr.getNickname(loginId);
    		}
    		
    		// 글정보추출
    		BoardBean post = bMgr.getPost(num);
    		
    		// 책이 있으면 책정보 추출
    		int bookid = post.getBookid();
    		BookBean book = null;
    		if(post.getBookid() != 0) {
    			book = bMgr.getBook(bookid);
    		}
    		
    		// 첨부이미지 = Base64로 인코딩한 이미지 데이터를 추가
    		if (post.getPhoto() != null) {
                // Base64로 인코딩
                String encodedPhoto = Base64.getEncoder().encodeToString(post.getPhoto());
                post.setEncodedPhoto(encodedPhoto);
            }
    		
    		// 도서표지 = Base64로 인코딩한 이미지 데이터를 추가
    		if (book != null && book.getPhoto() != null) {
                // Base64로 인코딩
                String encodedPhoto = Base64.getEncoder().encodeToString(book.getPhoto());
                book.setEncodedPhoto(encodedPhoto);
            }

    		// 추천 수 추출
    		int liked = (bMgr.getLikedCount(num) > 0) ? bMgr.getLikedCount(num) : 0;
    		
    		// 댓글 수 추출
    		int activeComCount = bMgr.getActiveComCount(num);
    		int commenCount = bMgr.getCommentCount(num);
    		
    		// 댓글 페이징
    		int totalRecord=0; //전체레코드수
    		int numPerPage=10; // 페이지당 레코드 수 
    		int pagePerBlock=5; //블럭당 페이지수 
    		int totalPage=0; //전체 페이지 수
    		int totalBlock=0;  //전체 블럭수
    		int nowPage=1; // 현재페이지
    		int nowBlock=1;  //현재블럭
    		int start=0; //디비의 select 시작번호
    		int end=numPerPage; //시작번호로 부터 가져올 select 갯수
    		int listSize=0; // DB로부터 추출해 list에 저장한 댓글 수
    		
    		
    		// 페이지이동 시 게시글을 DB에서 추출할 때 기준이 되는 값을 초기화
    		start = (nowPage-1)*numPerPage;
    		end = numPerPage;
    		
    		// 페이징, 글목록출력 등에 활용될 변수 초기화 (총게시글수, 총페이지수, 현재블럭, 총블럭수)
    		totalRecord = bMgr.getCommentCount(num);
    		totalPage = (int)Math.ceil((double)totalRecord / numPerPage);  //전체페이지수
    		nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock); //현재블럭 계산
    		totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);  //전체블럭계산

    		// 페이지네이션 변수 초기화
    		// 현재 블럭에서의 시작번호 (현재블럭과 블럭당페이지수로 계산)
    		int pageStart = (nowBlock-1)*pagePerBlock+1;
    	    // 현재 블럭에서의 끝번호 ()
    		int pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1;
    	    
    		
    		String category="";

    		// 카테고리를 고르면 변수 초기화
    		if(request.getParameter("category") != null || request.getParameter("category") != "") {
    			category = request.getParameter("category");
    		}
    		
    		// 댓글 추출
    		ArrayList<CommentBean> clist = bMgr.getCommentList(num, start, end);
			listSize = clist.size();
	        
			// 아이피 추출
	        String userip = request.getRemoteAddr();

    		// 쿠키저장
    		// 기존 쿠키 유무를 확인하고 누적
    		// 쿠키 추출
    	  	String readPosts = null;
    	  	Cookie[] cookies = request.getCookies();
    	  	if(cookies != null) {
    	  		for(Cookie cookie : cookies) {
    	  			if(cookie.getName().equals("readPosts")) {
    	  				readPosts = URLDecoder.decode(cookie.getValue(), "UTF-8"); // URL 디코딩 (읽을때는 다시 원래의 문자열로 복원)
    	  				break;
    	  			}
    	  		}
    	  	}
    	  	
    	  	// 확인 후 누적
    	  	if(readPosts == null) {
    	  		readPosts = numS;
    	  	} else if(!readPosts.contains(numS)) {
    	  		readPosts += ", " + numS;
    	  	}
    	  			
    		Cookie cookie = new Cookie("readPosts", URLEncoder.encode(readPosts)); //쿠키에 저장하기 전에 문자열을 인코딩(특수문자를 안전하게 저장가능)
    		cookie.setMaxAge(60 * 60 * 24 * 30); 	// 만료는 30일
    		cookie.setPath("/"); 					//모든 경로에서 접근가능
    		response.addCookie(cookie);
    		
    		// 결과를 request에 저장
	    	boardPagingBean paging = new boardPagingBean(totalRecord, numPerPage, pagePerBlock,
	    			totalPage, totalBlock, nowPage, nowBlock, start, end, listSize, pageStart, pageEnd);
	    	
	    	request.setAttribute("paging", paging);
	    	request.setAttribute("num", num);
	    	request.setAttribute("numS", numS);
	    	request.setAttribute("loginId", loginId);
	    	request.setAttribute("loginNickname", loginNickname);
	    	request.setAttribute("post", post);
	    	request.setAttribute("category", category);
	    	request.setAttribute("activeComCount", activeComCount);
	    	request.setAttribute("commenCount", commenCount);
	    	request.setAttribute("book", book);
	    	request.setAttribute("liked", liked);
	    	request.setAttribute("clist", clist);
	    	request.setAttribute("userip", userip);
    	}
    	

    	// 글수정 페이지
    	if("/board03".equals(path)) {
    		
    	}

    	
        handleRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    		throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	response.setCharacterEncoding("UTF-8");
    	
    	// 요청URL 불러오기
    	String path = request.getPathInfo();
    	
    	// 글 작성 요청
    	if("/boardPost".equals(path)) {
    		BoardMgr bMgr = new BoardMgr();
    		boolean insertOk = bMgr.insertBoard(request);
    		String category = URLEncoder.encode(request.getParameter("category"),"UTF-8");
    		if(insertOk) {
    			response.sendRedirect("board01?category="+category);
    		} else {
    			response.sendRedirect("boardError?error=failPost");
    		}
    	}
    	
    	// 글 삭제 요청
    	if("/boardDelete".equals(path)) {
    		BoardMgr bMgr = new BoardMgr();
    		boolean deleteOk = bMgr.deleteBoard(request);
    		String category = URLEncoder.encode(request.getParameter("category"),"UTF-8");
    		String boardid = request.getParameter("boardid");
    		if(deleteOk) {
    			response.sendRedirect("boardSuccess?event=delPost&category="+category);    			
    		} else {
    			response.sendRedirect("boardError?error=failDelete&num="+boardid);
    		}
    	}
    	
    	// 글 수정 요청
    	if("/boardEdit".equals(path)) {
    		BoardMgr bMgr = new BoardMgr();
    		boolean editOk = bMgr.editBoard(request);
    		String category = URLEncoder.encode(request.getParameter("category"),"UTF-8");
    		String boardid = request.getParameter("boardid");
    		if(editOk) {
    			response.sendRedirect("boardSuccess?event=editPost&category="+category+"&num="+boardid);
    		} else {
    			response.sendRedirect("boardError?error=failEdit&num="+boardid);
    		}
    	}
    	
    	// 글 추천 중복체크 후 추천수 증가 / 인기글 여부 업데이트
    	if("/uplike".equals(path)) {
    		BoardMgr bMgr = new BoardMgr();
    		boolean hasLiked = bMgr.hasLikeSameId(request); // 중복여부 검사
    		
    		if(hasLiked) { // 중복이면 메세지 출력
    			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
    		} else { // 중복이 아니면 추천수 증가
    			int updateLiked = bMgr.upLike(request);
    			response.setContentType("application/json");
    			response.getWriter().write("{\"liked\": " + updateLiked + "}");
    		}
    	}
    	
    	// 글작성 시 도서검색 요청
    	if("/postBookSearch".equals(path)) {
    		StringBuilder sb = new StringBuilder();
    		String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
    		
    		// JSON으로 읽은 데이터 파싱
            JsonObject jsonObj = JsonParser.parseString(sb.toString()).getAsJsonObject();
            
            
            String searchVal = jsonObj.get("searchVal").getAsString();
            
    		// 반환에 필요한 데이터 담기
    		BoardMgr bMgr = new BoardMgr();
    		ArrayList<BookBean> bList = bMgr.getSearchBookList(searchVal);
    		
    		// request 객체로 반환
    		request.setAttribute("bList", bList);
    		
    		// 포워딩
    		String commentBoxJsp = "/WEB-INF/jsp/board/boardBookSearch.jsp";
    		RequestDispatcher dispatcher = request.getRequestDispatcher(commentBoxJsp);
    		dispatcher.forward(request, response);
    	}
    	
    	// 댓글 정렬 옵션 요청 - 최신순
    	if("/recentSort".equals(path)) {
    		StringBuilder sb = new StringBuilder();
    		String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
    		
    		// JSON으로 읽은 데이터 파싱
            JsonObject jsonObj = JsonParser.parseString(sb.toString()).getAsJsonObject();
            
            int boardid = jsonObj.get("boardid").getAsInt();
            int nowPage = jsonObj.get("nowPage").getAsInt();
            int numPerPage = jsonObj.get("numPerPage").getAsInt();
            int start = jsonObj.get("start").getAsInt();
            int end = jsonObj.get("end").getAsInt();
            

            //필요한 데이터 추가
            BoardMgr bMgr = new BoardMgr();
            BoardBean post = bMgr.getPost(boardid);
            int postuser = post.getUserid();
    		
    		// 댓글창에 필요한 데이터 담기
    		int commentCount = bMgr.getCommentCount(boardid);
    		ArrayList<CommentBean> clist = bMgr.getRecentCommentList(boardid, start, end);
    		
    		// request 객체로 반환
    		request.setAttribute("nowPage", nowPage);
    		request.setAttribute("postuser", postuser);
    		request.setAttribute("commentCount", commentCount);
    		request.setAttribute("clist", clist);
    		request.setAttribute("boardid", boardid);

    		// 포워딩
    		String commentBoxJsp = "/WEB-INF/jsp/board/commentBox.jsp";
    		RequestDispatcher dispatcher = request.getRequestDispatcher(commentBoxJsp);
    		dispatcher.forward(request, response);
    	}
    	
    	// 댓글 정렬 옵션 요청 - 등록순
    	if("/regSort".equals(path)) {
    		StringBuilder sb = new StringBuilder();
    		String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
    		
    		// JSON으로 읽은 데이터 파싱
            JsonObject jsonObj = JsonParser.parseString(sb.toString()).getAsJsonObject();
            
            int boardid = jsonObj.get("boardid").getAsInt();
            int nowPage = jsonObj.get("nowPage").getAsInt();
            int numPerPage = jsonObj.get("numPerPage").getAsInt();
            int start = jsonObj.get("start").getAsInt();
            int end = jsonObj.get("end").getAsInt();
            

            //필요한 데이터 추가
            BoardMgr bMgr = new BoardMgr();
            BoardBean post = bMgr.getPost(boardid);
            int postuser = post.getUserid();
    		
    		// 댓글창에 필요한 데이터 담기
    		int commentCount = bMgr.getCommentCount(boardid);
    		ArrayList<CommentBean> clist = bMgr.getCommentList(boardid, start, end);
    		
    		// request 객체로 반환
    		request.setAttribute("nowPage", nowPage);
    		request.setAttribute("postuser", postuser);
    		request.setAttribute("commentCount", commentCount);
    		request.setAttribute("clist", clist);
    		request.setAttribute("boardid", boardid);

    		// 포워딩
    		String commentBoxJsp = "/WEB-INF/jsp/board/commentBox.jsp";
    		RequestDispatcher dispatcher = request.getRequestDispatcher(commentBoxJsp);
    		dispatcher.forward(request, response);
    	}
    	
    	// 댓글 작성 요청
    	if("/boardComment".equals(path)) {
    		StringBuilder sb = new StringBuilder();
    		String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
    		
    		// JSON으로 읽은 데이터 파싱
            JsonObject jsonObj = JsonParser.parseString(sb.toString()).getAsJsonObject();
            
            
            int userid = jsonObj.get("userid").getAsInt();
            String nickname = jsonObj.get("nickname").getAsString();
            int boardid = jsonObj.get("boardid").getAsInt();
            String ip = jsonObj.get("userip").getAsString();
            String content = jsonObj.get("commentMsg").getAsString();
            String regdate = jsonObj.get("regdate").getAsString();
            int nowPage = jsonObj.get("nowPage").getAsInt();
            int start = jsonObj.get("start").getAsInt();
            int end = jsonObj.get("end").getAsInt();
            
            //필요한 데이터 추가
            BoardMgr bMgr = new BoardMgr();
            BoardBean post = bMgr.getPost(boardid);
            int postuser = post.getUserid();
    		
    		// DB에 댓글 저장
    		bMgr.insertComment(userid, nickname, boardid, ip, content, regdate);
    		
    		// 댓글창에 필요한 데이터 담기
    		int commentCount = bMgr.getCommentCount(boardid);
    		ArrayList<CommentBean> clist = bMgr.getCommentList(boardid, start, end);
    		
    		// request 객체로 반환
    		request.setAttribute("nowPage", nowPage);
    		request.setAttribute("postuser", postuser);
    		request.setAttribute("commentCount", commentCount);
    		request.setAttribute("clist", clist);
    		request.setAttribute("boardid", boardid);
    		
    		// 포워딩
    		String commentBoxJsp = "/WEB-INF/jsp/board/commentBox.jsp";
    		RequestDispatcher dispatcher = request.getRequestDispatcher(commentBoxJsp);
    		dispatcher.forward(request, response);
    	}
    	
    	
    	// 대댓글(답글) 작성 요청
    	if("/boardCommentReply".equals(path)) {
    		StringBuilder sb = new StringBuilder();
    		String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
    		
    		// JSON으로 읽은 데이터 파싱
            JsonObject jsonObj = JsonParser.parseString(sb.toString()).getAsJsonObject();
            
            int userid = jsonObj.get("userid").getAsInt();
            String nickname = jsonObj.get("nickname").getAsString();
            int boardid = jsonObj.get("boardid").getAsInt();
            String ip = jsonObj.get("userip").getAsString();
            String content = jsonObj.get("commentMsg").getAsString();
            String regdate = jsonObj.get("regdate").getAsString();
            int parentid = jsonObj.get("parentid").getAsInt();
            int depth = jsonObj.get("depth").getAsInt();
            int pos = jsonObj.get("pos").getAsInt();
            int start = jsonObj.get("start").getAsInt();
            int end = jsonObj.get("end").getAsInt();
            int pageStart = jsonObj.get("pageStart").getAsInt();
            int pageEnd = jsonObj.get("pageEnd").getAsInt();
            int nowBlock = jsonObj.get("nowBlock").getAsInt();
            int nowPage = jsonObj.get("nowPage").getAsInt();
            
            //필요한 데이터 추가
            BoardMgr bMgr = new BoardMgr();
            BoardBean post = bMgr.getPost(boardid);
            int postuser = post.getUserid();
    		
    		// DB에 댓글 저장 후 조상댓글 업데이트
    		bMgr.insertReply(userid, nickname, boardid, ip, content, regdate, parentid, depth, pos);
        	//bMgr.updateGrandChild(parentid, "reply");
    		bMgr.updateChild(parentid, pos);
    		
    		// 댓글창에 필요한 데이터 담기
    		int commentCount = bMgr.getCommentCount(boardid);
    		ArrayList<CommentBean> clist = bMgr.getCommentList(boardid, start, end);
    		
    		// request 객체로 반환
            request.setAttribute("nowPage", nowPage);
            request.setAttribute("nowBlock", nowBlock);
            request.setAttribute("pageStart", pageStart);
            request.setAttribute("pageEnd", pageEnd);
    		request.setAttribute("postuser", postuser);
    		request.setAttribute("commentCount", commentCount);
    		request.setAttribute("clist", clist);
    		request.setAttribute("boardid", boardid);
    		
    		// 포워딩
    		String commentBoxJsp = "/WEB-INF/jsp/board/commentBox.jsp";
    		RequestDispatcher dispatcher = request.getRequestDispatcher(commentBoxJsp);
    		dispatcher.forward(request, response);
    	}
    	
    	// 댓글 수정 요청
    	if("/boardCommentEdit".equals(path)) {
    		StringBuilder sb = new StringBuilder();
    		String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
    		
    		// JSON으로 읽은 데이터 파싱
            JsonObject jsonObj = JsonParser.parseString(sb.toString()).getAsJsonObject();
            
            int commentid = jsonObj.get("commentid").getAsInt();
            int userid = jsonObj.get("userid").getAsInt();
            String nickname = jsonObj.get("nickname").getAsString();
            String ip = jsonObj.get("userip").getAsString();
            String content = jsonObj.get("commentMsg").getAsString();
            String updatedate = jsonObj.get("updatedate").getAsString();

            int boardid = jsonObj.get("boardid").getAsInt();
            int start = jsonObj.get("start").getAsInt();
            int end = jsonObj.get("end").getAsInt();
            int pageStart = jsonObj.get("pageStart").getAsInt();
            int pageEnd = jsonObj.get("pageEnd").getAsInt();
            int nowBlock = jsonObj.get("nowBlock").getAsInt();
            int nowPage = jsonObj.get("nowPage").getAsInt();
            
            //필요한 데이터 추가
            BoardMgr bMgr = new BoardMgr();
            CommentBean comment = bMgr.getComment(commentid);
            int commentUser = comment.getUserid();
            BoardBean post = bMgr.getPost(boardid);
            int postuser = post.getUserid();
    		
    		// userid와 댓글작성자id가 같으면 DB에 댓글 수정
            if(userid == commentUser) {
            	bMgr.editComment(commentid, nickname, ip, content, updatedate);
            } else {
            	response.sendRedirect("boardError?error=failCommentEdit");
            }
    		
    		// 댓글창에 필요한 데이터 담기
    		int commentCount = bMgr.getCommentCount(boardid);
    		ArrayList<CommentBean> clist = bMgr.getCommentList(boardid, start, end);
    		
    		// request 객체로 반환
            request.setAttribute("nowPage", nowPage);
            request.setAttribute("nowBlock", nowBlock);
            request.setAttribute("pageStart", pageStart);
            request.setAttribute("pageEnd", pageEnd);
    		request.setAttribute("postuser", postuser);
    		request.setAttribute("commentCount", commentCount);
    		request.setAttribute("clist", clist);
    		request.setAttribute("boardid", boardid);
    		
    		// 포워딩
    		String commentBoxJsp = "/WEB-INF/jsp/board/commentBox.jsp";
    		RequestDispatcher dispatcher = request.getRequestDispatcher(commentBoxJsp);
    		dispatcher.forward(request, response);
    	}
    	
    	// 댓글 삭제 요청
    	if("/boardCommentDel".equals(path)) {
    		StringBuilder sb = new StringBuilder();
    		String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
    		
    		// JSON으로 읽은 데이터 파싱
            JsonObject jsonObj = JsonParser.parseString(sb.toString()).getAsJsonObject();
            
            int commentid = jsonObj.get("commentid").getAsInt();
            int userid = jsonObj.get("userid").getAsInt();
            String deldate = jsonObj.get("deldate").getAsString();
            int pos = jsonObj.get("pos").getAsInt();
            
            int boardid = jsonObj.get("boardid").getAsInt();
            int start = jsonObj.get("start").getAsInt();
            int end = jsonObj.get("end").getAsInt();
            int pageStart = jsonObj.get("pageStart").getAsInt();
            int pageEnd = jsonObj.get("pageEnd").getAsInt();
            int nowBlock = jsonObj.get("nowBlock").getAsInt();
            int nowPage = jsonObj.get("nowPage").getAsInt();
            
            //필요한 데이터 추가
            BoardMgr bMgr = new BoardMgr();
            CommentBean comment = bMgr.getComment(commentid);
            int commentUser = comment.getUserid();
            BoardBean post = bMgr.getPost(boardid);
            int postuser = post.getUserid();
    		
    		// userid와 댓글작성자id가 같으면 DB에 댓글 삭제 (status값 업데이트) 후 조상댓글 업데이트
            if(userid == commentUser) {
            	bMgr.deleteComment(commentid, deldate);
        		bMgr.updateChild(commentid, pos);
            } else {
            	response.sendRedirect("boardError?error=failCommentDel");
            }
    		
    		// 댓글창에 필요한 데이터 담기
    		int commentCount = bMgr.getCommentCount(boardid);
    		ArrayList<CommentBean> clist = bMgr.getCommentList(boardid, start, end);
    		
    		// request 객체로 반환
            request.setAttribute("nowPage", nowPage);
            request.setAttribute("nowBlock", nowBlock);
            request.setAttribute("pageStart", pageStart);
            request.setAttribute("pageEnd", pageEnd);
    		request.setAttribute("postuser", postuser);
    		request.setAttribute("commentCount", commentCount);
    		request.setAttribute("clist", clist);
    		request.setAttribute("boardid", boardid);
    		
    		// 포워딩
    		String commentBoxJsp = "/WEB-INF/jsp/board/commentBox.jsp";
    		RequestDispatcher dispatcher = request.getRequestDispatcher(commentBoxJsp);
    		dispatcher.forward(request, response);
    	}
    	
    	// 댓글 페이징 요청
    	if("/commentPaging".equals(path)) {
    		StringBuilder sb = new StringBuilder();
    		String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
    		
    		// JSON으로 읽은 데이터 파싱
            JsonObject jsonObj = JsonParser.parseString(sb.toString()).getAsJsonObject();
            
            int boardid = jsonObj.get("boardid").getAsInt();
            int start = jsonObj.get("start").getAsInt();
            int end = jsonObj.get("end").getAsInt();
            int pageStart = jsonObj.get("pageStart").getAsInt();
            int pageEnd = jsonObj.get("pageEnd").getAsInt();
            int nowBlock = jsonObj.get("nowBlock").getAsInt();
            int nowPage = jsonObj.get("nowPage").getAsInt();

    		// 댓글창에 필요한 데이터 담기
            BoardMgr bMgr = new BoardMgr();
            int commentCount = bMgr.getCommentCount(boardid);
    		ArrayList<CommentBean> clist = bMgr.getCommentList(boardid, start, end);
    		
            BoardBean post = bMgr.getPost(boardid);
            int postuser = post.getUserid();
    		
    		// request 객체로 반환
            request.setAttribute("nowPage", nowPage);
            request.setAttribute("nowBlock", nowBlock);
            request.setAttribute("pageStart", pageStart);
            request.setAttribute("pageEnd", pageEnd);
    		request.setAttribute("postuser", postuser);
    		request.setAttribute("commentCount", commentCount);
    		request.setAttribute("clist", clist);
    		request.setAttribute("boardid", boardid);
    		
    		// 포워딩
    		String commentBoxJsp = "/WEB-INF/jsp/board/commentBox.jsp";
    		RequestDispatcher dispatcher = request.getRequestDispatcher(commentBoxJsp);
    		dispatcher.forward(request, response);
    	}
    	
    	// 댓글페이징 다음블럭으로 요청
    	if("/commentGoBlock".equals(path)) {
    		StringBuilder sb = new StringBuilder();
    		String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
    		
    		// JSON으로 읽은 데이터 파싱
            JsonObject jsonObj = JsonParser.parseString(sb.toString()).getAsJsonObject();
            
            int boardid = jsonObj.get("boardid").getAsInt();
            int start = jsonObj.get("start").getAsInt();
            int end = jsonObj.get("end").getAsInt();
            int pageStart = jsonObj.get("pageStart").getAsInt();
            int pageEnd = jsonObj.get("pageEnd").getAsInt();
            int nowBlock = jsonObj.get("nowBlock").getAsInt();
            int nowPage = jsonObj.get("nowPage").getAsInt();

    		// 댓글창에 필요한 데이터 담기
            BoardMgr bMgr = new BoardMgr();
            int commentCount = bMgr.getCommentCount(boardid);
    		ArrayList<CommentBean> clist = bMgr.getCommentList(boardid, start, end);
    		
            BoardBean post = bMgr.getPost(boardid);
            int postuser = post.getUserid();
    		
    		// request 객체로 반환
            request.setAttribute("nowPage", nowPage);
            request.setAttribute("nowBlock", nowBlock);
            request.setAttribute("pageStart", pageStart);
            request.setAttribute("pageEnd", pageEnd);
    		request.setAttribute("postuser", postuser);
    		request.setAttribute("commentCount", commentCount);
    		request.setAttribute("clist", clist);
    		request.setAttribute("boardid", boardid);
    		
    		// 포워딩
    		String commentBoxJsp = "/WEB-INF/jsp/board/commentBox.jsp";
    		RequestDispatcher dispatcher = request.getRequestDispatcher(commentBoxJsp);
    		dispatcher.forward(request, response);
    	}
    }

    private void handleRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI();  // 전체 요청 URI를 가져옴 // /MillkyWay/board/board01
        String contextPath = request.getContextPath();  // contextPath를 가져옴 // /MillkyWay
        String relativePath = path.substring(contextPath.length());  // contextPath를 제외한 경로 // /board/board01

        // /procs 경로를 처리하기 위한 JSP 경로 생성
        String jspPath = "/WEB-INF/jsp/board" + relativePath.substring("/board".length()) + ".jsp"; // /WEB-INF/jsp/board/board01.jsp
        String errorPath = "/WEB-INF/jsp/board/boardError404.jsp";

        try {
            // JSP로 포워딩
            RequestDispatcher dispatcher = request.getRequestDispatcher(jspPath);
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            // JSP 파일을 찾을 수 없는 경우 에러 처리
            RequestDispatcher dispatcher = request.getRequestDispatcher(errorPath);
            dispatcher.forward(request, response);
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "JSP 파일을 찾을 수 없습니다.");
        }
    }
}
