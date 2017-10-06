#!/bin/bash
#
# Usage:
#   install_ansible.sh
#
# Description:
#   CentOS 7 で Ansible のインストールを行います。
#   yum-utils インストール。
#   EPEL リポジトリインストール、無効化。
#   Ansible インストール。
#
###########################################################################

set -eux

yum install -y yum-utils
yum install -y epel-release
yum-config-manager --disable epel
yum install -y --enablerepo=epel ansible
