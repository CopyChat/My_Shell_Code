#!/bin/bash - 
#===============================================================================
#
#          FILE: chose.sh
# 
#         USAGE: ./chose.sh 
# 
#   DESCRIPTION: to pick out lines with all columns from $2 if it's $3 matches the $3 column in $1
# 	EXAMPLE:08/27/2013 14:29:45 CST:Tang: chose.sh id catalog 1 4, or chose.sh id catalog 1 1.
# 	
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 12/04/12 19:19:22 CST
#      REVISION:  ---
#===============================================================================

if [ -z "$1" ]; then
	echo "please input the sourse file"
	exit 1
fi
if [ -z "$2" ]; then
	echo "please input the sourse file"
	exit 1
fi
if [ -z "$3" ]; then
	c=1
	d=1
	#echo "default: use the FIRST column!"
else 
	c=$3
	d=$4
fi


awk 'NR==FNR{a[$'$c']=$'$c'}NR!=FNR{if($'$d'==a[$'$d'])print $0}' $1 $2
exit
