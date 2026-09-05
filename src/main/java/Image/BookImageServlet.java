package Image;

import config.EnvConfig;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BookImageServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        try {
            Class.forName(EnvConfig.optional("DB_DRIVER", "com.mysql.cj.jdbc.Driver"));
            EnvConfig.required("DB_URL");
            EnvConfig.required("DB_USER");
            EnvConfig.required("DB_PASSWORD");
        } catch (ClassNotFoundException | IllegalStateException e) {
            throw new ServletException("Database configuration is unavailable", e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = EnvConfig.required("DB_URL");
        String user = EnvConfig.required("DB_USER");
        String password = EnvConfig.required("DB_PASSWORD");

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement("SELECT photo FROM Booktbl WHERE bookid = ?")) {

            pstmt.setInt(1, Integer.parseInt(request.getParameter("bookid")));

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    byte[] imgData = rs.getBytes("photo");
                    response.setContentType("image/png");
                    try (OutputStream os = response.getOutputStream()) {
                        os.write(imgData);
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
