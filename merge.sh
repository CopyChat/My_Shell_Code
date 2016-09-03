#!/bin/bash - 
#===============================================================================
#
#          FILE: merge.sh
# 
#         USAGE: ./merge.sh 
# 
#   DESCRIPTION: to merge two file 
# 	
# 
#       OPTIONS: ---
#  REQUIREMENTS: --- the input files contarin the same number of lines
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 12/04/12 19:19:22 CST
#      REVISION:  ---
#===============================================================================

if [ -z "$2" ]; then
	echo "useage: merge.sh ifile1 ifile2"
	exit 1
fi

awk 'NR==FNR{a[NR]=$0}NR!=FNR{print a[FNR],$0}' $1 $2
exit
