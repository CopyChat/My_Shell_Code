#!/bin/bash - 
#===============================================================================
#
#          FILE: chose.sh
# 
#         USAGE: ./chose.sh 
# 
#   DESCRIPTION: to replace $1 in $2 
# 
#       OPTIONS: ---
#  REQUIREMENTS: --- remove.sh (awk script)
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

#if [ -z "$3" ]; then
#	c=1
#	#echo "default: use the FIRST column!"
#else 
#	c=$3
#fi
#awk 'NR==FNR{a[$'$c']=$0;b[$'$c']=$'$c'}NR!=FNR{if($'$c'!=b[$'$c']){print $0}else{print a[$'$c']}}' $1 $2 
##=================================================== my old code
remove.sh $1 $2 > replace90908.temp
cat $1 >> replace90908.temp
sort -n -k 1 replace90908.temp 
rm replace90908.temp
