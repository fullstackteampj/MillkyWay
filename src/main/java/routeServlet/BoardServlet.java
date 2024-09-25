package routeServlet;


import javax.servlet.ServletException;

import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import board.BoardMgr;
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
    		response.setContentType("application/json");
    		BoardMgr bMgr = new BoardMgr();
    		
    		// 요청데이터를 문자열로 읽기
    		StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
            
            // URL디코딩으로 fetch문에서 body로 받은 parameter를 추출
            String[] params = sb.toString().split("&");
            int userid = Integer.parseInt(URLDecoder.decode(params[0].split("=")[1], StandardCharsets.UTF_8));
            String nickname = URLDecoder.decode(params[1].split("=")[1], StandardCharsets.UTF_8);
            int ref = Integer.parseInt(URLDecoder.decode(params[2].split("=")[1], StandardCharsets.UTF_8));
            String userip = URLDecoder.decode(params[3].split("=")[1], StandardCharsets.UTF_8);
            String commentMsg = URLDecoder.decode(params[4].split("=")[1], StandardCharsets.UTF_8);
            String regDate = URLDecoder.decode(params[5].split("=")[1], StandardCharsets.UTF_8);
            
            // DB에 댓글저장
            bMgr.insertComment(userid, nickname, ref, userip, commentMsg, regDate);
            
            // 응답
            PrintWriter out = response.getWriter();
            out.write("{\"commentMsg\":\"" + commentMsg + "\"}");
            out.flush();
    	}
    	
    	// 대댓글(답글) 작성 요청
    	if("/boardCommentReply".equals(path)) {
    		response.setContentType("application/json");
    		BoardMgr bMgr = new BoardMgr();
    		
    		// 요청데이터를 문자열로 읽기
    		StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
            
            // URL디코딩으로 fetch문에서 body로 받은 parameter를 추출
            String[] params = sb.toString().split("&");
            int userid = Integer.parseInt(URLDecoder.decode(params[0].split("=")[1], StandardCharsets.UTF_8));
            String nickname = URLDecoder.decode(params[1].split("=")[1], StandardCharsets.UTF_8);
            int ref = Integer.parseInt(URLDecoder.decode(params[2].split("=")[1], StandardCharsets.UTF_8));
            String userip = URLDecoder.decode(params[3].split("=")[1], StandardCharsets.UTF_8);
            String commentMsg = URLDecoder.decode(params[4].split("=")[1], StandardCharsets.UTF_8);
            String regDate = URLDecoder.decode(params[5].split("=")[1], StandardCharsets.UTF_8);
            int parenttId = Integer.parseInt(URLDecoder.decode(params[6].split("=")[1], StandardCharsets.UTF_8));
            int depth = Integer.parseInt(URLDecoder.decode(params[7].split("=")[1], StandardCharsets.UTF_8));
            int pos = Integer.parseInt(URLDecoder.decode(params[8].split("=")[1], StandardCharsets.UTF_8));
            
            // DB에 댓글저장
            // bMgr.updatePos();
            bMgr.insertReply(userid, nickname, ref, userip, commentMsg, regDate, parenttId, depth, pos);
            
            // 응답
            PrintWriter out = response.getWriter();
            out.write("{\"commentMsg\":\"" + commentMsg + "\"}");
            out.flush();
    	}
    	
    	// 댓글 수정 요청
    	
    	
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
            int commentId = Integer.parseInt(URLDecoder.decode(sb.toString().split("=")[1], StandardCharsets.UTF_8));
            
            // DB에 댓글 status 업데이트
            bMgr.deleteComment(commentId);
            
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
