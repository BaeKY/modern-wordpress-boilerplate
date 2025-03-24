# phpbrew를 이용한 여러 버전의 PHP 설치

> WSL 내부에서 수행합니다!

## Installation

프로젝트에 포함된 설치 스크립트를 사용하여 설치합니다.

- [./docs/scripts/install-phpbrew.sh](/docs/scripts/install-phpbrew.sh)

스크립트를 실행합니다.

```bash
./docs/scripts/install-phpbrew.sh
#Using root: /home/<username>/.phpbrew
#Initialization successfully finished!
#<=====================================================>
#Phpbrew environment is initialized, required directories are created under
#
#    /home/<username>/.phpbrew
#
#Paste the following line(s) to the end of your ~/.bashrc and start a
#new shell, phpbrew should be up and fully functional from there:
#
#    source /home/<username>/.phpbrew/bashrc
#
#To enable PHP version info in your shell prompt, please set PHPBREW_SET_PROMPT=1
#in your `~/.bashrc` before you source `~/.phpbrew/bashrc`
#
#    export PHPBREW_SET_PROMPT=1
#
#To enable .phpbrewrc file searching, please export the following variable:
#
#    export PHPBREW_RC_ENABLE=1
#
#
#For further instructions, simply run `phpbrew` to see the help message.
#
#Enjoy phpbrew at $HOME!!
#
#<=====================================================>
#phpbrew 설치 완료.
#아래와 같이 원하는 버전의 PHP를 설치하세요.
#ex) phpbrew install 8.3.9
```

## PHP 설치

아래와 같이 phpbrew를 이용하여 php를 설치합니다.

```bash
# phpbrew install <version>
phpbrew install 8.3.19

# 설치한 PHP 8.3.19를 기본 버전으로 설정
phpbrew switch 8.3.19
```

Ubuntu 22버전 이상에서 php7.x 버전을 설치하려면 openssl 의존성 문제를 해결해야 합니다.

아래 명령어를 통해 openssl 의존성 문제를 해결합니다

```bash
# https://github.com/phpbrew/phpbrew/issues/1263

# 작업용 디렉토리 생성 및 이동
DEPENDENCIES=/tmp/deps
mkdir -p $DEPENDENCIES
cd $DEPENDENCIES

# openssl 1.1.1i 설치
wget https://www.openssl.org/source/openssl-1.1.1i.tar.gz --no-check-certificate
tar xzf $DEPENDENCIES/openssl-1.1.1i.tar.gz
cd openssl-1.1.1i
./Configure --prefix=$DEPENDENCIES/openssl-1.1.1i/bin -fPIC -shared linux-x86_64
make -j 8
make install
```

이후 php7.x를 설치합니다.

```bash
export PKG_CONFIG_PATH=/tmp/deps/openssl-1.1.1i/bin/lib/pkgconfig && phpbrew install 7.4.33
```

끝
