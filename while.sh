#!/bin/bash - 
#===============================================================================
#
#          FILE: while.sh
# 
#         USAGE: ./while.sh 
# 
#   DESCRIPTION: to test the nohup 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 02/25/2014 07:43:03 PM RET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

i=0
while [ $i -lt $1 ]
do
	echo $i
	sleep 1
	((i++))
done

