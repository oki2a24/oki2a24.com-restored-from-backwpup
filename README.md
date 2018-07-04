## はじめに
- Nginx、PHP-FPM、PHP、MariaDB を 1 つのサーバに構築します。
- サーバの構築には、ansible ユーザを必要とします。このユーザは sudo 権限をもつ必要があります。
- [BackWPup – WordPress Backup Plugin | WordPress.org](https://ja.wordpress.org/plugins/backwpup/) を使って作成したデータベースのバックアップ、ファイルのバックアップから WordPress を復元します。

参考
- <a href="https://developer.wordpress.org/cli/commands/db/create/" target="_blank">wp db create | WordPress Developer Resources</a>
- <a href="https://developer.wordpress.org/cli/commands/db/import/" target="_blank">wp db import | WordPress Developer Resources</a>
- <a href="https://docs.ansible.com/ansible/latest/modules/unarchive_module.html" target="_blank">unarchive - Unpacks an archive after (optionally) copying it from the local machine. — Ansible Documentation</a>

## 準備
- `playbook/group_vars/all` の各項目の値を編集してください。
- `playbook/wordpress/files/` に BackWPup で作成したバックアップファイルを置いてください。

## Ansible コントロールノードの作成
どの環境でも Ansible を実行できるようにするために、コントロールノード専用の VM を構築する。
Windows では Ansible がインストールできないし、Mac では sshpass が気楽にインストールできないためだ。

```bash
cd controller/
vagrant up
```

## Ansible ターゲットノードの準備
ユーザ名: ansible, パスワード: ansible というユーザを追加してください。このユーザは sudo コマンドが実行できるようにしてください。

例えば次のようになります。

```bash
useradd ansible
passwd ansible << EOF
ansible
ansible
EOF
gpasswd -a ansible wheel
```

## Ansible ターゲットノードへの疎通確認
1. コントロールノードへログイン
1. ターゲットノードに対して SSH 公開鍵を登録
1. Ansible を実行し、疎通を確認

今回、ターゲットノードは、testtarget ディレクトリにて `vagrant up` を実行することで作成できる VM を例とする。この VM には、ユーザ名: ansible, パスワード: ansible というユーザが予め追加されている。

```bash
vagrant ssh
cd playbook
ssh-keygen -t rsa
ssh-copy-id -o StrictHostKeyChecking=no -i $HOME/.ssh/id_rsa.pub ansible@192.168.56.11
ansible-playbook -i hosts test.yml --ask-become-pass
# SUDO password: ansible
```

## Ansible ターゲットノードへの playbook 実行
```bash
ansible-playbook -i hosts site.yml --ask-become-pass
# タグ指定で playbook 実行
ansible-playbook -i hosts site.yml --ask-become-pass --tags "common,mariadb,nginx,php,php-fpm"
ansible-playbook -i hosts site.yml --ask-become-pass --tags wordpress
```
