package routeServlet;

import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;


public class BuyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response);
    }

    private void handleRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getRequestURI();  // 전체 요청 URI를 가져옴
        String contextPath = request.getContextPath();  // contextPath를 가져옴
        String relativePath = path.substring(contextPath.length());  // contextPath를 제외한 경로

        // /procs 경로를 처리하기 위한 JSP 경로 생성
        String jspPath = "/WEB-INF/jsp/buy" + relativePath.substring("/buy".length()) + ".jsp";

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
