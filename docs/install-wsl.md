# WSL 설치

## Requirements

- Windows 10 이상
- 하드웨어 레벨의 가상화 지원
- 최소 4GB 이상의 RAM. 8GB 이상 권장
- 최소 5GB 이상의 저장공간

</br>

## Installation

### 1. 하드웨어 레벨의 가상화 확인 및 활성화

1. `ctrl + shift + esc`를 눌러 `작업 관리자`를 엽니다.
2. `성능` 탭에서 아래의 사진과 같이 `가상화: 사용`으로 설정되어있는지 확인합니다.

    ![alt text](/docs/pics/check-cpu-virtualization-enabled.png)

3. 만약 활성화 되어있지 않다면 BIOS로 진입하여 아래의 링크들과 같이 활성화 합니다.(메인보드 제조사 별로 BIOS 화면이 다릅니다. 목록에 내 메인보드 제조사가 없다면 구글링하여 활성화 합니다.)

    - [ASUS - Intel(VMX) 가상화 기술 활성화 방법](https://www.asus.com/kr/support/faq/1043786/)
    - [ACER - How to Enable Virtualization Technology on Acer Products](https://community.acer.com/kb/articles/14750)
    - [DELL - 하드웨어 가상화를 활성화 또는 비활성화하는 방법](https://www.dell.com/support/kbdoc/ko-kr/000195978/dell-시스템에서-하드웨어-가상화를-활성화-또는-비활성화하는-방법)
    - [Gigabyte - Enable Virtualization by Motherboard](https://support.salad.com/article/281-enable-virtualization-by-motherboard-gigabyte)

</br>

### 2. Windows 기능 On/Off

`관리자 권한`으로 Windows PowerShell을 열고 아래의 명령어를 입력합니다.

```powershell
# Linux용 Windows 하위 시스템 활성화
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Virtual machine 플랫폼 활성화
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

</br>

### 3. WSL2 설치

역시 `관리자 권한`으로 Windows PowerShell을 열고 아래의 명령어를 입력합니다.

```powershell
wsl --install
wsl --update

# WSL2를 기본 버전으로 설정
wsl --set-default-version 2
```

이어서 아래와 같이 설치 가능한 Disto 목록을 확인합니다.

```powershell
wsl --list --online
```

`Ubuntu-24.04` 를 설치합니다.

```powershell
wsl --install -d Ubuntu-24.04
```

설치한 `Ubuntu-24.04` Disto가 기본 배포로 지정되어있는지 확인합니다.

```powershell
wsl --status
#기본 배포: Ubuntu-24.04
#기본 버전: 2

# 만약 Ubuntu-24.04가 기본 배포가 아니라면 아래와 같이 설정할 수 있습니다.
wsl -s Ubuntu-24.04
```

</br>

### 4. WSL2 접속 & VSCode 연동

`Win`키를 누르고 `ubuntu`로 검색하면 아래와 같이 출력됩니다.

![alt text](/docs/pics/install-wsl-search-ubuntu.png)

실행하여 아래와 같이 Ubuntu 터미널을 실행할 수 있습니다.

![alt text](/docs/pics/install-wsl-run-ubuntu.png)

처음 접속하면 기본 유저, 패스워드를 지정하는 안내가 나올 수 있습니다.

User, Password 지정 후 아래의 명령어를 통해 VSCode를 엽니다.

```bash
# .(점) 까지 전부 입력
code .
```

WSL2와 VSCode 연동이 완료되었습니다. 이어서 WSL2의 Ubuntu 환경 설정을 아래의 문서를 보고 진행합니다.

- [/docs/wsl-ubuntu-setup.md](/docs/wsl-ubuntu-setup.md)

끝.
