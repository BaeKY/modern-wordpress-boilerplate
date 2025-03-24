# Ubuntu Setup

> WSL(Ubuntu-24.04) 내부에서 수행해야 합니다.

## 1. OS 패키지 업데이트 및 필요한 패키지 설치

아래 명령어를 통해 업데이트를 진행합니다.

```bash
sudo apt update -y
```

이후 앞으로의 과정에 필요한 패키지들을 설치합니다.

```bash
sudo apt install -y git curl wget jq
```

</br>

## 2. 패스워드 없이 `sudo` 사용하기

아래 명령어를 통해 `sudo`사용시 패스워드를 묻지 않도록 합니다.

터미널에 아래 명령어를 복사 붙여넣기 합니다.

```bash
echo "$(id -un)  ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/$(id -un)
# 이후 Shell 종료 후 다시 들어옵니다.
exit
```

</br>

## 3. Zsh + OhMyZsh

명령어 자동완성을 위해 Zsh + OhMyZsh를 설치합니다.

터미널에 아래의 명령어를 복사 붙여넣기 합니다.

```bash
# zsh 설치
sudo apt install -y zsh

# 내 기본 쉘을 zsh로 변경(change shell)
chsh -s $(which zsh)
```

`zsh`를 설치 후 터미널을 껏다 켭니다.

다시 접속하면 아래와 같은 프롬프트가 출력됩니다.

![alt text](/docs/pics/wsl-ubuntu-setup-zsh-prompt.png)

선택지 중 `(2)`를 선택합니다

OhMyZsh를 설치합니다.

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

잘 안되면 아래의 블로그들을 참조합니다.

- [Tistory - Ubuntu에 Oh My Zsh 설치](https://log4cat.tistory.com/7)
- [WSL 우분투 oh-my-zsh 설치 테마 변경과 Nerd Font 설치](https://iter.kr/wsl-우분투-oh-my-zsh-설치/)

</br>

## 4. 여러 버전의 php 및 extension 관리

아래의 링크에서는 Ubuntu에서 여러 버전의 PHP 및 PHP Extension 설치 및 관리 방법에 대해 소개합니다.

- [How to Install Multiple PHP Versions on Ubuntu 22.04](https://medium.com/techvblogs/how-to-install-multiple-php-versions-on-ubuntu-22-04-3a0474b07385)

[phpbrew](/docs/install-phpbrew.md)보다 위의 방법을 더 권장합니다.

</br>

## (Optional) 5. Github CLI 설치

> [Github - Installing gh on Linux and BSD](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)

Github CLI를 통해 저장소를 내 컴퓨터에 클론하거나 생성하는 등의 행위를 쉽게 할 수 있습니다.
아래 스크립트를 통해 gh(**g**it**h**ub cli)를 설치합니다

```bash
# 전체가 하나의 스크립트입니다. 처음부터 끝까지 잘 복사해서 한번에 집어넣습니다.
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
&& sudo mkdir -p -m 755 /etc/apt/keyrings \
&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
```

잘 설치되었는지 확인합니다

```bash
$ gh --version
gh version 2.49.2 (2024-05-13)
https://github.com/cli/cli/releases/tag/v2.49.2
```

Github CLI를 사용하기 위해서는 로그인이 필요합니다. 아래 명령어를 통해 수행합니다

> Support 계정으로 로그인 안하도록 주의합니다.

```bash
gh auth login
# ? What account do you want to log into?  [Use arrows to move, type to filter]
# > GitHub.com         # <-- 이거 선택
#   GitHub Enterprise Server
# ? What is your preferred protocol for Git operations on this host?  [Use arrows to move, type to filter]
# > HTTPS              # <-- 이거 선택
#   SSH
# ? How would you like to authenticate GitHub CLI?  [Use arrows to move, type to filter]
# > Login with a web browser          # <-- 이거 선택
#   Paste an authentication token

# ! First copy your one-time code: E16D-7FEE        # <- code: 이하를 잘 복사한 뒤 엔터!
# Press Enter to open github.com in your browser...

# WSL 환경에 브라우저 및 GUI 사용 설정이 되어있지 않아 인증 URL이 출력됩니다.
# 해당 URL을 Github 로그인이 되어있는 브라우저를 열고 인증코드를 붙여넣기 하여 완료합니다!
```

gh 설치 및 인증이 완료되었습니다. 이제 원하는 Github 저장소를 아래와 같이 쉽게 Clone 하거나 생성할 수 있습니다.

```bash
# 원하는 디렉토리로 접근
# 필자는 $HOME/prorjects 디렉토리에서 진행하였다.
mkdir -p ~/projects
cd ~/projects

# StudioJT/rootsio-bedrock-poc 저장소 클론
gh repo clone studiojt/rootsio-bedrock-poc

# 저장소 생성
gh repo create studiojt/sample-repo --private

# 저장소 생성 & 현재 위치에서 클론
gh repo clone studiojt/sample-repo --private -c
```

이어서 진행합니다.

</br>
