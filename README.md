# rootsio-bedrock-poc

> 해당 프로젝트는 [Bedrock](https://roots.io/bedrock/) + [DDEV](https://ddev.com/)를 사용하여 구성하였습니다.

## Overviews

개발자가 인프라팀이 구축한 개발서버 및 기타 클라우드 자원에 덜 의존하고 로컬머신에서 테스트 및 디버깅이 가능하도록 지원하기 위한 프로젝트 입니다.

또한 VCS를 통해 소스코드가 어떻게 변해왔는지 추적이 가능하고 더이상 유실되는 코드가 없도록 만듭니다.

해당 보일러플레이트는 프로젝트 시작시 필요한 플러그인 및 테마를 Composer를 통해 로컬에서 쉽게 설치할 수 있도록 만들어졌습니다.

## Requirements

1. WSL2 (Ubuntu24.04)
   - [WSL2 설치 가이드](/docs/install-wsl.md)
   - [Ubuntu24.04 설정 가이드](/docs/wsl-ubuntu-setup.md)
2. php >= 8.1
3. [composer >=2.8](https://www.digitalocean.com/community/tutorials/how-to-install-composer-on-ubuntu-22-04-quickstart)
4. [composer auth.json 설정](/docs/composer-auth-json.md)
5. jq >= 1.7

   ```bash
   # 이미 설치 되어있을 것으로 예상하지만
   # 안되어있다면 아래의 명령어로 설치합니다
   sudo apt install jq
   ```

6. Docker (아래의 방법 중 1택)
   - [Docker Desktop 설치](/docs/install-docker-desktop.md)   <- 이게 훨씬 간단함
   - (WSL 내부에서) Docker CE 설치
7. [ddev 설치](/docs/install-ddev.md)

## Getting Started

> WSL 내부에서 수행합니다.

아래의 스크립트를 통해 프로젝트를 동작시킵니다.

```bash
# 플러그인 및 테마를 설치합니다
composer install

# 아래 명령어를 통해  출력되는 프롬프트를 따라
# .env 파일을 완성시킵니다.
composer run-script env:local

# 서버 시작!
ddev start

# 이제 아래의 URL로 접근이 가능합니다
#
# - https://rootsio-bedrock-poc.ddev.site
# - https://rootsio-bedrock-poc.ddev.site/wp/wp-admin
#
# 처음 접근시 WordPress Install 화면이 출력됩니다.
# 사이트에 접속하여 WordPress Install을 진행하고 플러그인 및 테마를 활성화 할 수도 있지만
# 이어서 나오는 명령어를 통해 해당 과정을 빠르게 설정할 수 있습니다.

# WordPress Install
ddev wp core install \
   --url="https://rootsio-bedrock-poc.ddev.site" \
   --title="Bedrock PoC" \
   --admin_user="studio-jt" \
   --admin_email="support@studio-jt.co.kr" \
   --admin_password="P@ssw0rd"

# Activate Wordpress plugins and themes.
ddev wp plugin activate --all --exclude=redis-cache,jt-bad-ux-popup
ddev wp theme activate jt-press
```

내 로컬머신에 실행된 프로젝트 정보를 확인하고 싶다면 아래와 같은 명령어를 입력합니다.

```bash
ddev status
#┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
#│ Project: rootsio-bedrock-poc /projects/rootsio-bedrock-poc https://rootsio-bedrock-poc.ddev.site                              │
#│ Docker platform: docker-desktop                                                                                               │
#│ Router: traefik                                                                                                               │
#├──────────────┬──────┬────────────────────────────────────────────────────────────────────────────────────┬────────────────────┤
#│ SERVICE      │ STAT │ URL/PORT                                                                           │ INFO               │
#├──────────────┼──────┼────────────────────────────────────────────────────────────────────────────────────┼────────────────────┤
#│ web          │ OK   │ https://rootsio-bedrock-poc.ddev.site                                              │ wordpress PHP 8.3  │
#│              │      │ InDocker -> Host:                                                                  │ Server: nginx-fpm  │
#│              │      │  - web:80 -> 127.0.0.1:54760                                                       │ Docroot: 'web'     │
#│              │      │  - web:443 -> 127.0.0.1:54759                                                      │ Perf mode: none    │
#│              │      │  - web:8025 -> 127.0.0.1:54761                                                     │ Node.js: 22        │
#├──────────────┼──────┼────────────────────────────────────────────────────────────────────────────────────┼────────────────────┤
#│ db           │ OK   │ InDocker -> Host:                                                                  │ mariadb:11.4       │
#│              │      │  - db:3306 -> 127.0.0.1:54758                                                      │ User/Pass: 'db/db' │
#│              │      │                                                                                    │ or 'root/root'     │
#├──────────────┼──────┼────────────────────────────────────────────────────────────────────────────────────┼────────────────────┤
#│ Mailpit      │      │ Mailpit: https://rootsio-bedrock-poc.ddev.site:8026                                │                    │
#│              │      │ Launch: ddev mailpit                                                               │                    │
#├──────────────┼──────┼────────────────────────────────────────────────────────────────────────────────────┼────────────────────┤
#│ Project URLs │      │ https://rootsio-bedrock-poc.ddev.site, https://127.0.0.1:54759,                    │                    │
#│              │      │ http://rootsio-bedrock-poc.ddev.site, http://127.0.0.1:54760                       │                    │
#└──────────────┴──────┴────────────────────────────────────────────────────────────────────────────────────┴────────────────────┘
```

## Debug with XDebug

> [DDEV - Step Debugging with Xdebug](https://ddev.readthedocs.io/en/stable/users/debugging-profiling/step-debugging/)

해당 프로젝트에는 XDebug까지 사용 가능하도록 설정되어 있습니다. 아래의 순서에 따라 디버거를 사용할 수 있습니다.

1. `F5`를 눌러 XDebug를 실행합니다.
2. 디버깅 하고자하는 코드에서 아래의 사진과 같이 Break Point를 설정합니다.

   > 사진에서는 jtpress테마의 [index.php#15](/web/app/themes/jt-press/index.php#15)에 설정하였습니다.

   ![alt text](/docs/pics/vscode-debug-1.png)

3. 이제 `https://rootsio-bedrock-poc.ddev.site/`로 접근하면 아래와 같이 Break Point에서 멈춥니다.

   ![alt text](/docs/pics/vscode-debug-2.png)

   > ### 주의
   >
   > 브라우저는 응답이 없을 경우 요청을 지속적으로 보냅니다.
   > 여러번 보내진 요청이 디버깅할때 헤깔리게 만들 수 있으므로 Break Point에서 멈춘 순간 브라우저는 `ESC` 키를 눌러 더이상 요청을 하지 않도록 만듭니다.

4. Debugger에서 제공해주는 정보를 토대로 디버깅한다. VSCode Debugger와 관련된 추가적인 내용은 아래의 링크에서 확인 가능합니다.

   - [Debug code with Visual Studio Code](https://code.visualstudio.com/docs/editor/debugging)

## Project Stop

```Bash
ddev stop

# 완전히 제거하고싶다면 아래와 같이 입력합니다
# ddev delete -O -y 
```

## `ddev wp`

현재 프로젝트에서 WP CLI를 실행합니다.

WP-CLI를 통해 아래와 같은 작업들이 가능합니다.

- search-replace를 통해 DB에 하드코딩된 Domain 변경(멀티사이트도 지원)
- admin-menu-editor 설정 JSON import, export
- MariaDB CLI 접근
- 멀티사이트 활성화
- 워드프레스 유저 컨텐츠 Export
- etc...(`ddev wp --help`)

(작성중)
