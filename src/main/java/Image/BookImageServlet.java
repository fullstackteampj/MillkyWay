package Image;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class BookImageServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        try {
            // MySQL JDBC 드라이버를 명시적으로 로드
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ServletException("MySQL JDBC Driver not found", e);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = "jdbc:mysql://localhost:3306/MillkyWayDB?useSSL=false";
        String user = "root";
        String password = "1234";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement("SELECT photo FROM Booktbl WHERE bookid = ?")) {

            pstmt.setInt(1, Integer.parseInt(request.getParameter("bookid")));
            ResultSet rs = pstmt.executeQuery();

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
    }
}
