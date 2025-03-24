# Install Docker Desktop and integrate with WSL2

## Installation

아래의 링크를 통해 다운받은 후 설치합니다.

- [Install Docker Desktop on Windows](https://docs.docker.com/desktop/setup/install/windows-install/)

## Integrate with WSL2

설치가 완료되었다면 Docker Desktop을 열고 아래와 같이 설정합니다.

- `Settings` -> `General`

    ![alt text](/docs/pics/install-docker-desktop-wsl-integration1.png)

  - 사진과 같이 `Use the WSL 2 based engine`에 체크되어 있어야 합니다.

- `Settings` -> `Resources` -> `WSL Integration`

    ![alt text](/docs/pics/install-docker-desktop-wsl-integration2.png)

  - WSL2의 기본 Disto가 Ubuntu-24.04인 상태 이어야 합니다. Windows PowerShell에서 아래와 같이 확인할 수 있습니다.

    ```powershell
    wsl --status
    # 기본 배포: Ubuntu-24.04    <- 여기와 같이 설정되어 있어야 합니다.
    # 기본 버전: 2
    ```

  - `Enable integration with my default WSL distro` 메뉴에 체크가 되어있으면 됩니다.

끝.
