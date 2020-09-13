[![](https://github.com/docker-hub-tm/ansible-tools/workflows/build/badge.svg)](https://github.com/docker-hub-tm/ansible-tools/actions?query=workflow%3Abuild)

最新版のAnsible、Ansible lint、MoleculeをインストールしたDockerイメージをビルドするためのDockerfile

### Dockerイメージレジストリ

[tomonorimatsumura/ansible-tools | Docker Hub](https://hub.docker.com/repository/docker/tomonorimatsumura/ansible-tools)

### Dockerfile

[ansible-community/molecule | GitHub](https://github.com/ansible-community/molecule) にあるDockerfileを参考にしている

### インストールされる主なツール

| ツール名 | インストール方法 | その他 |
|---|---|---|
| Ansible | pip | |
| Ansible Lint | pip | |
| Docker | apk | |
| Docker PyPI | pip | Docker Engine API |
| Git | apk | |
| Molecule | pip | |
| Moleculeドライバー | pip | 利用可能な全てのドライバーをインストール |
| Python3 | apk | Python 3.8がインストールされる |
| Testinfra | pip | |
| Yamllint | apk | |

### イメージのビルド周期

毎日

### イメージのタグ

latestのみ採用

### イメージの利用方法

``` bash
# Ansible roleへ移動
cd path/to/ansible-role

docker run --rm -it \
    -v "$(pwd)":/tmp/$(basename "${PWD}"):ro \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -w /tmp/$(basename "${PWD}") \
    tomonorimatsumura/ansible-tools:latest \
    molecule test
```

### その他

~/.bashrcの設定をすることで通常のコマンドとして利用可能になる

``` bash:~/.bashrc
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

alias molecule='sudo docker run --rm -it \
                -v "$(pwd)":/tmp/$(basename "${PWD}"):ro \
                -v /var/run/docker.sock:/var/run/docker.sock \
                -w /tmp/$(basename "${PWD}") \
                tomonorimatsumura/ansible-tools:latest \
                molecule'

alias ansible='sudo docker run --rm -it \
                -v "$(pwd)":/tmp/$(basename "${PWD}"):ro \
                -v /var/run/docker.sock:/var/run/docker.sock \
                -w /tmp/$(basename "${PWD}") \
                tomonorimatsumura/ansible-tools:latest \
                ansible'

alias ansible-galaxy='sudo docker run --rm -it \
                -v "$(pwd)":/tmp/$(basename "${PWD}"):ro \
                -v /var/run/docker.sock:/var/run/docker.sock \
                -w /tmp/$(basename "${PWD}") \
                tomonorimatsumura/ansible-tools:latest \
                ansible-galaxy'

alias ansible-lint='sudo docker run --rm -it \
                -v "$(pwd)":/tmp/$(basename "${PWD}"):ro \
                -v /var/run/docker.sock:/var/run/docker.sock \
                -w /tmp/$(basename "${PWD}") \
                tomonorimatsumura/ansible-tools:latest \
                ansible-lint'

alias ansible-playbook='sudo docker run --rm -it \
                -v "$(pwd)":/tmp/$(basename "${PWD}"):ro \
                -v /var/run/docker.sock:/var/run/docker.sock \
                -w /tmp/$(basename "${PWD}") \
                tomonorimatsumura/ansible-tools:latest \
                ansible-playbook'
```
