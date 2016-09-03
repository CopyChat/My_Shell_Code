#!/bin/bash - 
#===============================================================================
#
#          FILE: min.sh
# 
#         USAGE: ./min.sh 
# 
#   DESCRIPTION: to calculate the min value of column $2 in file $3
# 
#       OPTIONS: --- l, if is given, print the whole line with this min
#  REQUIREMENTS: ---
#          BUGS: --- # :TODO:03/20/13 09:55:39 CST:Tang: accept more than 1 parameters
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 01/03/13 17:30:52 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


if [ $# -lt 1 ];then
	echo "please input a file"
	exit 1
fi


	case "$1" in
		-l) 
			if [ $# -eq 3 ]
			then
				c=$2
				awk 'NR == 1 { min = $'$c'; minline = $0; next; } $'$c' < min { min=$'$c'; minline=$0 }; END { print minline }' $3
			else
				c=1
				awk 'NR == 1 { min = $'$c'; minline = $0; next; } $'$c' < min { min=$'$c'; minline=$0 }; END { print minline }' $2
			fi ;;
		*)
			if [ $# -eq 2 ] 
			then
				c=$1
				awk 'NR == 1 { min = $'$c'; minline = $0; next; } $'$c' < min { min=$'$c'; minline=$0 }; END { print minline }' $2 | awk '{print $'$c'}'
			else
				c=1
				awk 'NR == 1 { min = $'$c'; minline = $0; next; } $'$c' < min { min=$'$c'; minline=$0 }; END { print minline }' $1 | awk '{print $'$c'}'
			fi ;;
	esac
	shift

exit	

#=================================================== 
