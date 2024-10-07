package routeServlet;


import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import admin.AdminMgr;
import beans.BoardBean;
import beans.BookBean;
import board.BoardMgr;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Base64;

public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	response.setCharacterEncoding("UTF-8");
    	// 요청URL 불러오기
    	String path = request.getPathInfo();
    	
    	// 수정 페이지
    	if("/update".equals(path)) {
    		String[] categories = {"국내도서", "해외도서", "eBook"};
    		
    		if(request.getParameter("bookid") != null) {
    			// 책 정보 반환
        		int bookid = Integer.parseInt(request.getParameter("bookid"));
        		BoardMgr bMgr = new BoardMgr();
        		BookBean book = bMgr.getBook(bookid);
        		
        		// Base64로 인코딩한 이미지 데이터를 추가
        		if (book.getPhoto() != null) {
                    // Base64로 인코딩
                    String encodedPhoto = Base64.getEncoder().encodeToString(book.getPhoto());
                    book.setEncodedPhoto(encodedPhoto);
                }
        		
        		// 데이터를 response 객체에 저장
        		request.setAttribute("book", book);
        		request.setAttribute("bookid", request.getParameter("bookid"));
    		}
    		request.setAttribute("categories", categories);
    	}
    	
    	// 삭제 페이지
    	if("/delete".equals(path)) {
    		String[] categories = {"국내도서", "해외도서", "eBook"};
    		
    		if(request.getParameter("bookid") != null) {
    			// 책 정보 반환
        		int bookid = Integer.parseInt(request.getParameter("bookid"));
        		BoardMgr bMgr = new BoardMgr();
        		BookBean book = bMgr.getBook(bookid);
        		
        		// 데이터를 response 객체에 저장
        		request.setAttribute("book", book);
        		request.setAttribute("target", request.getParameter("bookid"));
    		}
    		request.setAttribute("categories", categories);
    	}
        handleRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	response.setCharacterEncoding("UTF-8");
    	// 요청URL 불러오기
    	String path = request.getPathInfo();
    	
    	// 책 등록 요청
    	if("/insertBook".equals(path)) {
    		AdminMgr aMgr = new AdminMgr();
    		Boolean result = aMgr.insertBook(request);
    		if(result) {
    			response.sendRedirect("/admin/adminSuccess?success=insertsuccess");
    		} else {
    			response.sendRedirect("/admin/adminError?error=insertFail");
    		}
    	}
    	
    	// 책 수정/삭제 페이지 기존정보 비동기처리
    	if("/bookInfoForm".equals(path)) {
    		StringBuilder sb = new StringBuilder();
    		String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
    		
    		// JSON으로 읽은 데이터 파싱
            JsonObject jsonObj = JsonParser.parseString(sb.toString()).getAsJsonObject();
            
            int bookid = jsonObj.get("bookid").getAsInt();
            String event = jsonObj.get("event").getAsString();
    		
            // 필요한 데이터 추가
            BoardMgr bMgr = new BoardMgr();
            BookBean book = bMgr.getBook(bookid);
    		String[] categories = {"국내도서", "해외도서", "eBook"};
    		
    		// Base64로 인코딩한 이미지 데이터를 추가
    		if (book.getPhoto() != null) {
                // Base64로 인코딩
                String encodedPhoto = Base64.getEncoder().encodeToString(book.getPhoto());
                book.setEncodedPhoto(encodedPhoto);
            }
            
            // request 객체로 반환
            request.setAttribute("bookid", bookid);
            request.setAttribute("book", book);
    		request.setAttribute("categories", categories);
    		request.setAttribute("event", event);
            
            // 포워딩
    		String adminFormJsp = "/WEB-INF/jsp/admin/adminForm.jsp";
    		RequestDispatcher dispatcher = request.getRequestDispatcher(adminFormJsp);
    		dispatcher.forward(request, response);
    	}
    	
    	// 책 수정 요청
    	if("/updateBook".equals(path)) {
    		AdminMgr aMgr = new AdminMgr();
    		boolean result = aMgr.updateBook(request);
    		int bookid = (request.getParameter("requestid") != null) ? Integer.parseInt(request.getParameter("requestid")) : Integer.parseInt(request.getParameter("bookid"));
    		if(result) {
    			response.sendRedirect("/admin/adminSuccess?success=updatesuccess&requestid="+bookid);
    		} else {
    			response.sendRedirect("/admin/adminError?error=updateFail");
    		}
    	}
    	
    	if("/deleteBook".equals(path)) {
    		AdminMgr aMgr = new AdminMgr();
    		boolean result = aMgr.deleteBook(request);
    		int requestid = Integer.parseInt(request.getParameter("requestid"));
    		if(result) {
    			response.sendRedirect("/admin/adminSuccess?success=deletesuccess&requestid="+requestid);
    		} else {
    			response.sendRedirect("/admin/adminError?error=deleteFail");
    		}
    	}
    }

    private void handleRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI();  // 전체 요청 URI를 가져옴
        String contextPath = request.getContextPath();  // contextPath를 가져옴
        String relativePath = path.substring(contextPath.length());  // contextPath를 제외한 경로

        // /procs 경로를 처리하기 위한 JSP 경로 생성
        String jspPath = "/WEB-INF/jsp/admin" + relativePath.substring("/admin".length()) + ".jsp";


      //[에러메세지] java.lang.IllegalStateException: 응답이 이미 커밋된 후에는, sendRedirect()를 호출할 수 없습니다.
        // JSP 파일 존재 여부 체크
        if (!Files.exists(Paths.get(getServletContext().getRealPath(jspPath)))) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "JSP 파일을 찾을 수 없습니다.");
            return; // 이 지점에서 메서드를 종료하여 커밋을 방지
        }

        try {
            // JSP로 포워딩
            RequestDispatcher dispatcher = request.getRequestDispatcher(jspPath);
            dispatcher.forward(request, response);
        } catch (ServletException e) {
        	// ServletException 발생 시에도 JSP 파일이 없다고 처리
        	 if (!response.isCommitted()) {
                 response.sendError(HttpServletResponse.SC_NOT_FOUND, "JSP 파일을 찾을 수 없습니다.");
        	 }
        }
    }
}
