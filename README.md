## 構成
- playbook: WordPress サーバを構築する Ansible playbook。
- controller: Ansible のコントロールノード。playbook を実行する役割。
- testtarget: Ansible によって環境が構築されていくターゲットノード。playbook 作成のための開発環境。playbook が完成すれば、このターゲットノードは不要となり、新たに別のターゲットノードに対して playbook が実行されることになる。

## Ansible コントロールノードの作成
どの環境でも Ansible を実行できるようにするために、コントロールノード専用の VM を構築する。
Windows では Ansible がインストールできないし、Mac では sshpass が気楽にインストールできないためだ。

```bash
cd controller/
vagrant up
```

## Ansible ターゲットノードへの疎通確認
1. コントロールノードへログイン
1. ターゲットノードに対して SSH 公開鍵を登録
1. Ansible を実行し、疎通を確認

今回、ターゲットノードは、target ディレクトリにて `vagrant up` を実行することで作成できる VM を例とする。

```bash
vagrant ssh
cd playbook
ssh-keygen -t rsa
ssh-copy-id -o StrictHostKeyChecking=no -i $HOME/.ssh/id_rsa.pub vagrant@192.168.56.11
ansible-playbook -i hosts test.yml
```

## Ansible ターゲットノードへの playbook 実行
```bash
ansible-playbook -i hosts site.yml
# タグ指定で playbook 実行
ansible-playbook -i hosts site.yml --tags "common,mariadb"
```




vim /etc/nginx/nginx.conf
vim /etc/nginx/conf.d/default.conf
  ドキュメントルートは動的にするべきかも
  WordPress インストール時も含めて
