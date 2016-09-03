#!/bin/bash - 
#===============================================================================
#
#          FILE: space.sh
# 
#         USAGE: ./space.sh 
# 
#   DESCRIPTION: to make file $1 divided by space between each column 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 01/08/13 12:18:35 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

awk '{for (i=1;i<NF;i++){printf "%s ",$i};print $NF}' $1
