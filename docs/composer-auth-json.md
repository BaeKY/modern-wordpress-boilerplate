# composer auth.json 설정

'ACF Pro'와 같이 WPackagist Repository에 존재하지 않는 플러그인을 위해 설정합니다. ACF Pro의 경우 WPEngine에서 [Installing ACF PRO With Composer](https://www.advancedcustomfields.com/resources/installing-acf-pro-with-composer/)와 같은 가이드를 통해 Composer로 설치할 수 있도록 지원합니다. auth.json 파일에 대한 자세한 정보가 궁금하다면 [여기](https://getcomposer.org/doc/articles/authentication-for-private-packages.md)를 읽어보세요.

아래의 명령어를 통해 auth.json을 전역 설정합니다.

```bash
composer config --global --editor --auth

# 위 명령어를 통해 auth.json을 수정하기 힘들다면
# 아래의 명령어를 통해 출력된 경로에서 auth.json을 찾아
# 직접 수정해도 됩니다.
#
# $ composer config --global home
```

이제 출력되는 에디터에 아래와 같이 입력합니다.

```jsonc
{
  "bitbucket-oauth": {},
  "github-oauth": {
    "github.com": "<GITHUB TOKEN>"
  },
  "gitlab-oauth": {},
  "gitlab-token": {},
  "http-basic": {
    "connect.advancedcustomfields.com": {
      "username": "<ACF-Pro License Key>",
      "password": "https://studio-jt.co.kr"
    }
  },
  "bearer": {}
}
```
