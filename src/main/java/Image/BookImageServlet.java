package Image;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import DBConnection.DBConnectionMgr;


public class BookImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
        Connection conn = null;

        try {
            conn = dbMgr.getConnection(); // 커넥션 가져오기
            PreparedStatement pstmt = conn.prepareStatement("SELECT photo FROM Booktbl WHERE bookid = ?");
            pstmt.setInt(1, Integer.parseInt(request.getParameter("bookid")));
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    byte[] imgData = rs.getBytes("photo");

                    response.setContentType("image/png"); // 이미지의 MIME 타입을 설정
                    try (OutputStream os = response.getOutputStream()) {
                        os.write(imgData);
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            if (conn != null) {
                dbMgr.freeConnection(conn); // 사용 후 커넥션 반납
            }
        }
    }
}
