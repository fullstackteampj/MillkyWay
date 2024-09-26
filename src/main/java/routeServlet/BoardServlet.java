package routeServlet;


import javax.servlet.ServletException;

import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;

import board.BoardMgr;
import beans.BoardBean;
import beans.CommentBean;

@WebServlet("/board/*")
public class BoardServlet extends HttpServlet {
		
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
    			response.sendRedirect("boardSuccess?event=editPost&category="+category);
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
            
            //필요한 데이터 추가
            BoardMgr bMgr = new BoardMgr();
            BoardBean post = bMgr.getPost(boardid);
            int postuser = post.getUserid();
    		
    		// DB에 댓글 저장
    		bMgr.insertReply(userid, nickname, boardid, ip, content, regdate, parentid, depth, pos);
    		
    		// 댓글창에 필요한 데이터 담기
    		int commentCount = bMgr.getCommentCount(boardid);
    		ArrayList<CommentBean> clist = bMgr.getCommentList(boardid, start, end);
    		
    		// request 객체로 반환
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
            String regdate = jsonObj.get("regdate").getAsString();
            

            int boardid = jsonObj.get("boardid").getAsInt();
            int start = jsonObj.get("start").getAsInt();
            int end = jsonObj.get("end").getAsInt();
            
            //필요한 데이터 추가
            BoardMgr bMgr = new BoardMgr();
            int commentUser = bMgr.getCommentUser(commentid);
            BoardBean post = bMgr.getPost(boardid);
            int postuser = post.getUserid();
    		
    		// userid와 댓글작성자id가 같으면 DB에 댓글 수정
            if(userid == commentUser) {
            	bMgr.editComment(commentid, nickname, ip, content, regdate);
            } else {
            	response.sendRedirect("boardError?error=failCommentEdit");
            }
    		
    		// 댓글창에 필요한 데이터 담기
    		int commentCount = bMgr.getCommentCount(boardid);
    		ArrayList<CommentBean> clist = bMgr.getCommentList(boardid, start, end);
    		
    		// request 객체로 반환
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
    		response.setContentType("application/json");
    		BoardMgr bMgr = new BoardMgr();
    		
    		// 요청데이터를 문자열로 읽기
    		StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
            
            // fetch에서 body로 받은 parameter 데이터 추출
            //int commentId = Integer.parseInt(URLDecoder.decode(sb.toString().split("=")[1], StandardCharsets.UTF_8));
            
            // DB에 댓글 status 업데이트
            //bMgr.deleteComment(commentId);
            
    	}
    	
    }

    private void handleRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI();  // 전체 요청 URI를 가져옴 // /MillkyWay/board/board01
        String contextPath = request.getContextPath();  // contextPath를 가져옴 // /MillkyWay
        String relativePath = path.substring(contextPath.length());  // contextPath를 제외한 경로 // /board/board01

        // /procs 경로를 처리하기 위한 JSP 경로 생성
        String jspPath = "/WEB-INF/jsp/board" + relativePath.substring("/board".length()) + ".jsp"; // /WEB-INF/jsp/board/board01.jsp

        try {
            // JSP로 포워딩
            RequestDispatcher dispatcher = request.getRequestDispatcher(jspPath);
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            // JSP 파일을 찾을 수 없는 경우 에러 처리
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "JSP 파일을 찾을 수 없습니다.");
        }
    }
}
