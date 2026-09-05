<%@page import="config.EnvConfig"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String code = request.getParameter("code");
String state = request.getParameter("state");
String expectedState = (String) session.getAttribute("state");

if (code == null || state == null || expectedState == null || !expectedState.equals(state)) {
    session.removeAttribute("state");
    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 OAuth 요청입니다.");
    return;
}
session.removeAttribute("state");

final String clientId;
final String clientSecret;
final String redirectUriValue;
try {
    clientId = EnvConfig.required("NAVER_LOGIN_CLIENT_ID");
    clientSecret = EnvConfig.required("NAVER_LOGIN_CLIENT_SECRET");
    redirectUriValue = EnvConfig.optional(
        "NAVER_LOGIN_REDIRECT_URI",
        "http://localhost:8080/login/naverLogin"
    );
} catch (IllegalStateException e) {
    response.sendError(HttpServletResponse.SC_SERVICE_UNAVAILABLE, "OAuth 설정을 사용할 수 없습니다.");
    return;
}

String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
apiURL += "&client_id=" + URLEncoder.encode(clientId, "UTF-8");
apiURL += "&client_secret=" + URLEncoder.encode(clientSecret, "UTF-8");
apiURL += "&redirect_uri=" + URLEncoder.encode(redirectUriValue, "UTF-8");
apiURL += "&code=" + URLEncoder.encode(code, "UTF-8");
apiURL += "&state=" + URLEncoder.encode(state, "UTF-8");

try {
    URL url = new URL(apiURL);
    HttpURLConnection con = (HttpURLConnection) url.openConnection();
    con.setRequestMethod("GET");
    con.setConnectTimeout(5000);
    con.setReadTimeout(5000);

    int responseCode = con.getResponseCode();
    if (responseCode != HttpURLConnection.HTTP_OK) {
        response.sendError(HttpServletResponse.SC_BAD_GATEWAY, "OAuth 공급자 응답을 처리할 수 없습니다.");
        con.disconnect();
        return;
    }

    StringBuilder res = new StringBuilder();
    try (BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
        String inputLine;
        while ((inputLine = br.readLine()) != null) {
            res.append(inputLine);
        }
    } finally {
        con.disconnect();
    }

    Gson gson = new Gson();
    JsonObject jsonObject = gson.fromJson(res.toString(), JsonObject.class);
    if (jsonObject == null || !jsonObject.has("access_token")) {
        response.sendError(HttpServletResponse.SC_BAD_GATEWAY, "OAuth 토큰을 확인할 수 없습니다.");
        return;
    }

    String accessToken = jsonObject.get("access_token").getAsString();
    session.setAttribute("access_token", accessToken);
    response.sendRedirect("/procs/naverLoginProc");
    return;
} catch (Exception e) {
    application.log("Naver OAuth callback failed", e);
    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "OAuth 로그인 처리 중 오류가 발생했습니다.");
    return;
}
%>
