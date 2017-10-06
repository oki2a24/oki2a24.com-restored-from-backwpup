#!/bin/bash
#
# Usage:
#   install_git.sh
#
# Description:
#   CentOS 7 で Git のインストールを行います。
#
###########################################################################

set -eux

yum install -y git
