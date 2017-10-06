#!/bin/bash
#
# Usage:
#   init.sh
#
# Description:
#   CentOS 7 で Ansible プレイブックを入手し、実行する環境を整えます。
#
###########################################################################

set -eux

bash install_git.sh
bash install_ansible.sh
