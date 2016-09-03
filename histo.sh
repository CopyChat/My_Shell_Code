#!/bin/bash - 
#===============================================================================
#
#          FILE: histo.sh
# 
#         USAGE: ./histo.sh 
# 
#   DESCRIPTION: to calculate the histogram of input array $1,
# 				 output is $2
# 
#       OPTIONS: ---
#  REQUIREMENTS: --- transpose, 
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 01/02/13 22:58:19 CST
#      REVISION:  ---
#===============================================================================



if [ -z "$1" ]; then
	echo "please input the column number "
	exit 1
fi

if [ -z "$2" ]; then
	echo "please input the bin points from min to max"
	exit 1
fi
if [ -z "$3" ]; then
	echo "please input the sourse file"
	exit 1
fi
#=================================================== 
step1=($(awk '{print $1}' $2))
bin1=$(wc -l $2 | awk '{print $1-1}')
#echo ${step1[1]} $bin1

#===================================================
sort -n -k $1 $3 > radecc.temp9745320358
l=$(wc -l radecc.temp9745320358 | awk '{print $1}')
#echo $l
#====================================================
i=0
while [ $i -lt $bin1 ]
do
#	echo ${step1[$i]} 
	awk '$'$1'>'${step1[$i]}' && $'$1'< '${step1[$i+1]}'' radecc.temp9745320358 | wc -l 
	((i++))
done 
#=================================================== for a 2D density map:
#touch ra.temp97453203582
#if [ $bin1 -gt 10 ]; then
#	echo xiao
#	cat ra?.temp97453203581 >> ra.temp97453203582
#	cat ra??.temp97453203581 >> ra.temp97453203582
#fi
#if [ $bin1 -lt 10 ]; then
#	echo da
#	cat ra?.temp97453203581 >> ra.temp97453203582
#fi
#cat ra.temp97453203582
#transpose.sh 2dmap.temp9745320358

rm *.temp9745320358 
#*.temp97453203581 *.temp97453203582
