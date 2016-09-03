#!/bin/bash - 
#===============================================================================
#
#          FILE: topcat.sh
# 
#         USAGE: ./topcat.sh 
# 
#   DESCRIPTION: to run topcat in more memory 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 10/23/12 08:09:21 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

topcat -Xmx4096M
