package routeServlet;

import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class LoginServlet extends HttpServlet {
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
        String jspPath = "/WEB-INF/jsp/login" + relativePath.substring("/login".length()) + ".jsp";

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
