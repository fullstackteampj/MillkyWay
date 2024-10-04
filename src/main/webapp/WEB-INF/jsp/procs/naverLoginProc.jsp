<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="pMgr"  class="procs.ProcsMgr" />
<jsp:useBean id="lMgr" class="login.LoginMgr" />
    
<%
    // 세션에서 access_token 가져오기
    String access_token = (String) session.getAttribute("access_token");
    
    if (access_token != null) {
        try {
            // 사용자 프로필 정보를 요청할 URL
            String apiURL = "https://openapi.naver.com/v1/nid/me";
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            
            // 요청 헤더에 Authorization 추가
            con.setRequestProperty("Authorization", "Bearer " + access_token);
            con.setRequestProperty("User-Agent", "Mozilla/5.0");
            con.setRequestProperty("Accept", "*/*");
            
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if (responseCode == 200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else { // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            String inputLine;
            StringBuffer responseData = new StringBuffer(); // 변수명 변경
            while ((inputLine = br.readLine()) != null) {
                responseData.append(inputLine);
            }
            br.close();

            // JSON 응답 출력
            String jsonResponse = responseData.toString(); // 변수명에 맞춰 변경
            // out.println("응답 내용: " + jsonResponse);

            // Gson을 사용하여 JSON 데이터 파싱
            Gson gson = new Gson();
            JsonObject jsonObject = gson.fromJson(jsonResponse, JsonObject.class);
            String name = jsonObject.get("response").getAsJsonObject().get("name").getAsString();
            String email = jsonObject.get("response").getAsJsonObject().get("email").getAsString();
            String nickname = jsonObject.get("response").getAsJsonObject().get("nickname").getAsString();
            String mobile = jsonObject.get("response").getAsJsonObject().get("mobile").getAsString();
            String gender = jsonObject.get("response").getAsJsonObject().get("gender").getAsString();
            String id = jsonObject.get("response").getAsJsonObject().get("id").getAsString();
            String profile_image = jsonObject.get("response").getAsJsonObject().get("profile_image").getAsString();
            String birthyear = jsonObject.get("response").getAsJsonObject().get("birthyear").getAsString();
            String birthday = jsonObject.get("response").getAsJsonObject().get("birthday").getAsString();

            // 사용자 정보 출력 확인
            out.println("<br>사용자 이름: " + name);
            out.println("<br>사용자 이메일: " + email);
            out.println("<br>사용자 닉네임: " + nickname);
            out.println("<br>사용자 닉네임: " + mobile);
            out.println("<br>사용자 성별: " + gender);
            out.println("<br>사용자 아이디: " + id);
            out.println("<br>사용자 프로필사진: " + profile_image);
            out.println("<br>사용자 생년: " + birthyear);
            out.println("<br>사용자 월일: " + birthday);
            
			/*
			사용자 이름: 김정훈
			사용자 이메일: jamdolyung90@naver.com
			사용자 닉네임: 김정훈
			사용자 닉네임: 010-7387-7487
			사용자 성별: M
			사용자 아이디: DCGFH71HRtC1lEq5fzfzKBYJKhlcMmhuglUrV8AzNkA
			사용자 프로필사진: https://ssl.pstatic.net/static/pwe/address/img_profile.png
			사용자 생년: 1987
			사용자 월일: 01-07
			*/

            
            // id값을 이용하여 기존에 네이버 로그인으로 가입한 회원인지 확인
            boolean flag = pMgr.checkNaverId(id);
            
			System.out.print(flag);
            
            if(flag){
            // id값확인 후 기존에 가입되어있는 회원일 경우 멤버테이블 userid값을 이용해서 로그인 세션 생성
            	int userId = pMgr.getUserIdByNaver(id);
            	String userIdS = Integer.toString(userId);
            	lMgr.updateLastLogin(userId); // 마지막로그인 날짜 업데이트
            	
        		session.setAttribute("idKey", userId);
        		session.setAttribute("idKeyS", userIdS);
            }else{
            // id값확인 후 기존에 로그인되어있지 않은 회원일 경우 리턴받은 기본정보를 활용해서 멤버테이블에 추가 및 로그인 세션 생성
            	boolean signFlag = pMgr.signUpByNaver(jsonResponse);
            
            	if(signFlag) {
                	int userId = pMgr.getUserIdByNaver(id);
                	String userIdS = Integer.toString(userId);
                	lMgr.updateLastLogin(userId); // 마지막로그인 날짜 업데이트
                	
            		session.setAttribute("idKey", userId);
            		session.setAttribute("idKeyS", userIdS);
            	}else{
            		out.println("에러 발생: 회원가입 실패");
            	}
            }
            
            // 로그인 처리 후 메인페이지로 리다이렉트
            response.sendRedirect("/");
            
        } catch (Exception e) {
            out.println("에러 발생: " + e.getMessage());
        }
    } else {
        out.println("액세스 토큰이 없습니다.");
    }
%> 
<script>
	alert('<%=access_token%>');
</script>
<!DOCTYPE html>
<html lang="en"> 
<head>
  <meta charset="UTF-8">
  <title>naverLoginProc</title>
</head>
<body>

</body>
</html>
