# MillkyWay · 은하수책방

Java/JSP/Servlet/MySQL 기반 온라인 서점 팀 프로젝트입니다.

## Tomcat context

프로젝트 밖의 Tomcat `Servers/context.xml`에서 필요한 경우 다음과 같이 설정합니다.

```xml
<Context allowCasualMultipartParsing="true" path="/">
    <Resources cachingAllowed="true" cacheMaxSize="100000" />
</Context>
```

## Local configuration

실제 자격증명은 저장소에 커밋하지 않습니다. 애플리케이션 실행 환경(Tomcat/IDE/OS)에 다음 환경변수를 설정합니다.

- `DB_DRIVER` — 선택 사항. 기본값은 `com.mysql.cj.jdbc.Driver`
- `DB_URL`
- `DB_USER`
- `DB_PASSWORD`
- `NAVER_SEARCH_CLIENT_ID`
- `NAVER_SEARCH_CLIENT_SECRET`
- `NAVER_LOGIN_CLIENT_ID`
- `NAVER_LOGIN_CLIENT_SECRET`
- `NAVER_LOGIN_REDIRECT_URI` — 선택 사항. 로컬 기본값은 `http://localhost:8080/login/naverLogin`

`.env.example`은 변수 이름과 예시 형식만 제공합니다. 실제 `.env` 및 로컬 secret 파일은 `.gitignore` 대상입니다.

## Security note

과거 개발 이력에는 외부 API 자격증명과 개발용 DB 접속정보가 커밋된 적이 있습니다. 현재 소스에서는 하드코딩 값을 제거했지만, 이미 공개된 자격증명은 Git 이력에서 조회될 수 있으므로 **반드시 폐기/재발급 또는 비밀번호 변경**해야 합니다.

OAuth 처리에서는 `state` 값을 세션과 검증하고, access token 및 사용자 프로필 데이터를 화면이나 로그에 출력하지 않습니다.
