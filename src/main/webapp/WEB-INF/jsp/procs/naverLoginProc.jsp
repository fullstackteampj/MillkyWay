<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="pMgr" class="procs.ProcsMgr" />
<jsp:useBean id="lMgr" class="login.LoginMgr" />

<%
String accessToken = (String) session.getAttribute("access_token");
session.removeAttribute("access_token");

if (accessToken == null || accessToken.trim().isEmpty()) {
    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "OAuth 액세스 토큰이 없습니다.");
    return;
}

try {
    URL url = new URL("https://openapi.naver.com/v1/nid/me");
    HttpURLConnection con = (HttpURLConnection) url.openConnection();
    con.setRequestMethod("GET");
    con.setRequestProperty("Authorization", "Bearer " + accessToken);
    con.setRequestProperty("Accept", "application/json");
    con.setConnectTimeout(5000);
    con.setReadTimeout(5000);

    int responseCode = con.getResponseCode();
    if (responseCode != HttpURLConnection.HTTP_OK) {
        response.sendError(HttpServletResponse.SC_BAD_GATEWAY, "사용자 정보를 조회할 수 없습니다.");
        con.disconnect();
        return;
    }

    StringBuilder responseData = new StringBuilder();
    try (BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
        String inputLine;
        while ((inputLine = br.readLine()) != null) {
            responseData.append(inputLine);
        }
    } finally {
        con.disconnect();
    }

    String jsonResponse = responseData.toString();
    Gson gson = new Gson();
    JsonObject jsonObject = gson.fromJson(jsonResponse, JsonObject.class);

    if (jsonObject == null || !jsonObject.has("response")) {
        response.sendError(HttpServletResponse.SC_BAD_GATEWAY, "사용자 정보 응답이 올바르지 않습니다.");
        return;
    }

    JsonObject profile = jsonObject.get("response").getAsJsonObject();
    if (!profile.has("id")) {
        response.sendError(HttpServletResponse.SC_BAD_GATEWAY, "사용자 식별자를 확인할 수 없습니다.");
        return;
    }

    String id = profile.get("id").getAsString();
    boolean existingMember = pMgr.checkNaverId(id);

    if (existingMember) {
        int userId = pMgr.getUserIdByNaver(id);
        lMgr.updateLastLogin(userId);
        session.setAttribute("idKey", userId);
        session.setAttribute("idKeyS", Integer.toString(userId));
    } else {
        boolean signUpSucceeded = pMgr.signUpByNaver(jsonResponse);
        if (!signUpSucceeded) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "회원가입 처리에 실패했습니다.");
            return;
        }

        int userId = pMgr.getUserIdByNaver(id);
        lMgr.updateLastLogin(userId);
        session.setAttribute("idKey", userId);
        session.setAttribute("idKeyS", Integer.toString(userId));
    }

    response.sendRedirect("/");
    return;
} catch (Exception e) {
    application.log("Naver login processing failed", e);
    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "로그인 처리 중 오류가 발생했습니다.");
    return;
}
%>
