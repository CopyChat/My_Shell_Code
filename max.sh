#!/bin/bash - 
#===============================================================================
#
#          FILE: max.sh
# 
#         USAGE: ./max.sh 
# 
#   DESCRIPTION: to chose the line with the max value in column $'$c'   
# 
#       OPTIONS: --- l, if l is given, print the whole lines whose $2 column is the max
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 12/25/12 09:07:59 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

	case "$1" in
		-l) 
			if [ $# -eq 3 ]
			then
				c=$2
				awk 'NR == 1 { max = $'$c'; maxline = $0; next; } $'$c' > max { max=$'$c'; maxline=$0 }; END { print maxline }' $3
			fi

			if [ $# -eq 2 ]
			then
				c=1
				awk 'NR == 1 { max = $'$c'; maxline = $0; next; } $'$c' > max { max=$'$c'; maxline=$0 }; END { print maxline }' $2
			fi ;;

		*)
			if [ $# -eq 2 ] 
			then
				c=$1
				awk 'NR == 1 { max = $'$c'; maxline = $0; next; } $'$c' > max { max=$'$c'; maxline=$0 }; END { print maxline }' $2 | awk '{print $'$c'}'
			else
				c=1
				awk 'NR == 1 { max = $'$c'; maxline = $0; next; } $'$c' > max { max=$'$c'; maxline=$0 }; END { print maxline }' $1 | awk '{print $'$c'}'
			fi ;;
	esac
	shift

exit	

#=================================================== my old code

if [ -z "$2" ]; then
	echo "please input the source file!"
	exit 1
#	input_max=$'$c'
fi

if [ -z "$'$c'" ]; then
	c=1
	#echo "default: use the first column!"
else 
fi

awk '{a[$'$c']=$0"\n"a[$'$c'];if($'$c'>t)t=$'$c'}END{print a[t]}' $2 | head -1
