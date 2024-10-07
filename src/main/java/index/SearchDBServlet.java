package index;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import DBConnection.DBConnectionMgr;
import beans.BookBean;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

public class SearchDBServlet extends HttpServlet {
	
	//DB연결
	private DBConnectionMgr pool;
	
	public SearchDBServlet() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	String subject = request.getParameter("subject");
    	String searchCat = request.getParameter("searchCat");
    	
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	String sql = null;
    	
    	Vector<BookBean> searchList = new Vector<BookBean>();
    	
    	try {
    		conn = pool.getConnection();
    		if(searchCat.equals("통합검색")) {
    			sql = "select bookid, title, author, Genre from booktbl where title like ? or author like ? limit 5";
    			pstmt = conn.prepareStatement(sql);
    			pstmt.setString(1, "%" + subject + "%");
    			pstmt.setString(2, "%" + subject + "%");
    		}else {
    			sql = "select bookid, title, author, Genre from booktbl where category = ? and (title like ? or author like ?) limit 5";
    			pstmt = conn.prepareStatement(sql);
    			pstmt.setString(1, searchCat);
    			pstmt.setString(2, "%" + subject + "%");
    			pstmt.setString(3, "%" + subject + "%");
    		}
    		
    		rs = pstmt.executeQuery();
    		
    		while(rs.next()) {
    			BookBean bean = new BookBean();
    			bean.setBookid(rs.getInt("bookid"));
    			bean.setTitle(rs.getString("title"));
    			bean.setAuthor(rs.getString("author"));
    			bean.setGenre(rs.getString("Genre"));
    			searchList.add(bean);
    		}
    		
    		// System.out.println(searchList);
    		
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            Gson gson = new Gson();
            String json = gson.toJson(searchList);
            
            PrintWriter out = response.getWriter();
            out.print(json);
            out.flush();
    		
    	}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
    	
    	
    }//doGet(HttpServletRequest request, HttpServletResponse response)

}
