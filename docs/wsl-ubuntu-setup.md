# Ubuntu Setup

> WSL(Ubuntu) 내부에서 수행해야 한다.

## 1. OS 패키지 업데이트 및 필요한 패키지 설치

아래 명령어를 통해 업데이트를 진행한다.

```bash
sudo apt update -y
```

업데이트 한 김에 개발하는데 필요한 패키지들도 설치한다.

```bash
sudo apt install -y git curl wget jq
```

</br>

## 2. 패스워드 없이 `sudo` 사용하기

아래 명령어를 통해 `sudo`사용시 패스워드를 묻지 않도록 한다.

터미널에 아래 명령어를 복사 붙여넣기 한다.

```bash
echo "$(id -un)  ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/$(id -un)
# 이후 Shell 껏다 켜기
```

</br>

## 3. Zsh + OhMyZsh

명령어 자동완성을 위해 Zsh + OhMyZsh를 설치한다.

터미널에 아래의 명령어를 복사 붙여넣기 한다.

```bash
# zsh 설치
sudo apt install -y zsh

# 내 기본 쉘을 zsh로 변경(change shell)
chsh -s $(which zsh)
```

`zsh`를 설치 후 터미널을 껏다 켠다.

그리고 뜨는 선택 화면에서 `2`번 선택하면 된다([여기](https://log4cat.tistory.com/7)의 `4. 쉘 설정` 섹션 참고).

OhMyZsh를 설치한다.

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

잘 안되면 아래의 블로그들을 참조한다.

- [Tistory - Ubuntu에 Oh My Zsh 설치](https://log4cat.tistory.com/7)
- [WSL 우분투 oh-my-zsh 설치 테마 변경과 Nerd Font 설치](https://iter.kr/wsl-우분투-oh-my-zsh-설치/)

</br>

## 4. Github CLI 설치

Github CLI를 통해 내 Github에 Repository를 생성하거나, 클론하는 등 여러 작업들을 편하게 진행할 수 있다.

- [Github - Installing gh on Linux and BSD](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)

위 공식 Github에 잘 설명되어있다.

아래 스크립트를 통해 gh(**g**it**h**ub cli)를 설치한다(`&&`로 이어져있고 `\`로 개행처리된 스크립트다. 전체를 복사해서 실행한다).

```bash
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
&& sudo mkdir -p -m 755 /etc/apt/keyrings \
&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
```

잘 설치되었는지 확인한다

```bash
$ gh --version
gh version 2.49.2 (2024-05-13)
https://github.com/cli/cli/releases/tag/v2.49.2
```

Github CLI를 사용하기 위해서는 로그인이 필요하다. 아래 명령어를 통해 수행한다

> Support 계정으로 로그인 안하도록 주의한다.

```bash
$ gh auth login
? What account do you want to log into?  [Use arrows to move, type to filter]
> GitHub.com         # <-- 이거 선택
  GitHub Enterprise Server
? What is your preferred protocol for Git operations on this host?  [Use arrows to move, type to filter]
> HTTPS              # <-- 이거 선택
  SSH
? How would you like to authenticate GitHub CLI?  [Use arrows to move, type to filter]
> Login with a web browser          # <-- 이거 선택
  Paste an authentication token

! First copy your one-time code: E16D-7FEE        # <- code: 이하를 잘 복사한 뒤 엔터!
Press Enter to open github.com in your browser...

# WSL 환경에 브라우저가 설치되어있지 않아 인증 URL을 출력해주는 경우도 있음.
# 해당 URL을 Github 로그인이 되어있는 브라우저를 열고 인증코드를 붙여넣기 하여 완료한다!
```

인증이 완료되었다면 아래 명령어를 통해 [studio-jt/jt-dev](https://github.com/studio-jt/jt-dev.git) Repository를 클론해 보자

```bash
# 원하는 디렉토리로 접근
# 필자는 $HOME/prorjects 디렉토리에서 진행하였다.
mkdir -p ~/projects
cd ~/projects
gh repo clone studio-jt/jt-dev

# VSCode로 클론한 프로젝트를 연다.
code ./jt-dev
```

이어서 진행한다.

</br>

## 5. direnv 설치

> 디렉토리(프로젝트) 별로 환경설정을 다르게 하기 위한 패키지다.
>
> 예를 들면 프로젝트별로 서로 다른 PHP 버전을 사용해야 하는 경우, `direnv`가 이를 도와준다.

설치를 위해 아래 명령어를 터미널에 전체 복사 붙여넣기 한다.

```bash
sudo apt install direnv -y
echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
eval "$(direnv hook zsh)"
```

설치가 완료되었다.

direnv는 어떤 디렉토리에 존재하는 `.envrc` 파일을 통해 동작한다.

만약 `.envrc` 파일이 존재하는 디렉토리에 진입하면 아래와 같이 `.envrc`파일을 로드할지 물어본다.

```bash
# `vi .envrc` 명령을 통해 .envrc 수정 후...
direnv: error <your-directory>/.envrc is blocked. Run `direnv allow` to approve its content
$
```

로드 할거라면 `direnv allow`를 통해 `.envrc`에 존재하는 설정을 불러올 수 있다.

```bash
$ direnv allow
direnv: loading <your-directory>/.envrc
...
```

좀더 상세한 사용법은 아래의 블로그를 참조한다.

- [[44bits] direnv로 디렉토리(프로젝트) 별 개발환경 구축하기](https://www.44bits.io/ko/post/direnv_for_managing_directory_environment)

</br>

## 6. awscli 설치

인프라 담당자가 아니더라도 awscli를 활용할 일이 있을 것이다. 예를들면 아래와 같다.

- github에서 관리되지 않는 .env 또는 secret을 aws-secretsmanager를 통해 불러오기
- s3에서 더미 파일로 사용할 user-contents 다운로드 하기
- etc...

아래 문서를 참고하여 진행한다.

- [awscli/README.md](/awscli/README.md)

</br>

## 7. phpbrew 설치

프로젝트에 phpbrew 설치 스크립트가 포함되어있다([/phpbrew/README.md](/phpbrew/README.md) 참고). 아래와 같이 스크립트를 실행하여 설치한다.

```bash
# Ubuntu 22.04 버전용 설치
./phpbrew/install-ubuntu22.04.sh

# Ubuntu 24.04 버전용 설치
./phpbrew/install-ubuntu24.04.sh
```

이후 php를 설치한다.

> php7.x 버전을 설치하여면 아래의 문서를 참고한다.
>
> - [phpbrew를 이용한 여러 버전의 PHP 설치](/phpbrew/README.md)

```bash
# 7.x 버전을 설치하려면 openssl@1.1.x 버전 의존 문제를 해결해야한다. 위에서 언급한 문서를 참고한다.
phpbrew install 8.3.9

# 꽤 오래걸린다. 에러난것처럼 보여도 잘 진행되고 있는거다.
# 출력된 메시지를 잘 살펴보면 진행상황을 알수있도록 도와주는 스크립트가 출력되어 있다.
# 해당 스크립트를 새로운 터미널에서 실행하여 진행상황을 확인할 수 있다.
```

설치된 php를 사용하려면 아래와 같이 수행한다.

```bash
# 사용중인 php 버전 변경
phpbrew use 8.3.9

# php 버전 변경 + 기본 PHP버전으로 설정
# phpbrew switch 8.3.9
```

[direnv의 wiki](https://github.com/direnv/direnv/wiki/Php)에서 소개한것 처럼 direnv와 함께 사용하면 디렉토리별로 서로다른 php버전을 쉽게 사용할 수 있다.

터미널에 아래의 코드 전체를 그대로 복사 붙여넣기 한다.

```bash
mkdir -p ~/.config/direnv
cat << EOF >> ~/.config/direnv/direnvrc
use_phpbrew() {
  local php_version=\$1

  phpbrew_sh=~/.phpbrew/bashrc
  if [[ -e \$phpbrew_sh ]]; then
    source \$phpbrew_sh
    phpbrew use \$php_version
  fi
}
EOF
```

</br>

## 8. mkcert 설치

내 로컬머신에서 SSL을 쉽게 사용할 수 있도록 도와준다. 아래 가이드를 따라 진행한다.

- [/mkcert/README.md](/mkcert/README.md)

</br>

## 9. Traefik 설치

docker를 이용하여 설치한다. 아래 명령어를 통해 docker가 설치되어있는지 확인한다.

```bash
docker --version
```

나머지는 아래 문서를 참고하여 진행한다.

- [traefik/README.md](/traefik//README.md)
