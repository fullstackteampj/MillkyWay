<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.Gson"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
  String clientId = "cR6ZYmE3B8jjB8ERbb3U";//애플리케이션 클라이언트 아이디값";
  String clientSecret = "AZJitQmkQW";//애플리케이션 클라이언트 시크릿값";
  String code = request.getParameter("code");
  String state = request.getParameter("state");
  String redirectURI = URLEncoder.encode("http://localhost:8080/procs/loginProc", "UTF-8");
  String apiURL;
  apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
  apiURL += "client_id=" + clientId;
  apiURL += "&client_secret=" + clientSecret;
  apiURL += "&redirect_uri=" + redirectURI;
  apiURL += "&code=" + code;
  apiURL += "&state=" + state;
  String access_token = "";
  String refresh_token = "";
  System.out.println("apiURL="+apiURL);
  try {
    URL url = new URL(apiURL);
    HttpURLConnection con = (HttpURLConnection)url.openConnection();
    con.setRequestMethod("GET");
    int responseCode = con.getResponseCode();
    BufferedReader br;
    System.out.print("responseCode="+responseCode);
    if(responseCode==200) { // 정상 호출
      br = new BufferedReader(new InputStreamReader(con.getInputStream()));
    } else {  // 에러 발생
      br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
    }
    String inputLine;
    StringBuffer res = new StringBuffer();
    while ((inputLine = br.readLine()) != null) {
      res.append(inputLine);
    }
    br.close();
    if (responseCode == 200) {
  	    String jsonResponse = res.toString();
  	    out.println(jsonResponse); // JSON 응답 출력

  	    // Gson을 사용하여 JSON 데이터 파싱
  	    Gson gson = new Gson();
  	    JsonObject jsonObject = gson.fromJson(jsonResponse, JsonObject.class);
  	    access_token = jsonObject.get("access_token").getAsString();
  	    refresh_token = jsonObject.get("refresh_token").getAsString();

  	    // 세션에 토큰 저장
  	    request.getSession().setAttribute("access_token", access_token);
  	    request.getSession().setAttribute("refresh_token", refresh_token);

  	    // 추가적인 처리
  	    out.println("Access Token: " + access_token);
  	    out.println("Refresh Token: " + refresh_token);
  	    
  	    response.sendRedirect("/procs/naverLoginProc");// /procs/naverLoginProc으로 네이버 로그인 토큰값 전달
  	}
  } catch (Exception e) {
    System.out.println(e);
  }
%>

<!DOCTYPE html>
<html lang="en"> 
<head>
  <meta charset="UTF-8">
  <title>naverLogin</title>
</head>
<body>

</body>
</html>