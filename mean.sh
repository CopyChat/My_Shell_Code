#!/bin/bash - 
#===============================================================================
#
#          FILE: mean.sh
# 
#         USAGE: ./mean.sh 
# 
#   DESCRIPTION: to calculate the mean of the $1 column 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 01/03/13 20:04:56 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if [ $# -lt 1 ];then
	echo "please input a file"
	exit 1
fi

			if [ $# -eq 2 ]
			then
				c=$1
				awk '{sum+=$'$c'} END {printf "%f\n", sum/NR}' $2
			else	
				c=1
				awk '{sum+=$'$c'} END {printf "%f\n", sum/NR}' $1
			fi
exit	
