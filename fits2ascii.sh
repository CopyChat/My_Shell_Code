#!/bin/bash - 
#===============================================================================
#
#          FILE: ascii2fits.sh
# 
#         USAGE: ./ascii2fits.sh 
# 
#   DESCRIPTION: convert fits ($1) to ascii (fits) & the header ($3)
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 12/27/12 09:20:47 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


if [ -z "$1" ]; then
	echo "please input the sourse file to be converted "
	exit 1
fi
#if [ -z "$2" ]; then
#	echo "please input the target ascii file"
#	exit 1
#fi


#=================================================== 
#touch ascii2fits1.temp
#echo "#" > ascii2fits2.temp
#transpose.sh $3 >> ascii2fits3.temp
#paste -d " " ascii2fits2.temp ascii2fits3.temp > ascii2fits1.temp
#
#cat $1 >> ascii2fits1.temp

stilts tpipe ifmt=fits $1 ofmt=ascii > ascii2fits1.temp
 # :NOTE:12/27/12 09:55:29 CST:Tang: more header line

#if [ $3 -gt 0 ]; then
# awk '{for(i=1;i<NF;i++) {printf "%s ",$i};print $NF}' ascii2fits1.temp | sed "1d" > $2
#else
 awk '{for(i=1;i<NF;i++) {printf "%s ",$i};print $NF}' ascii2fits1.temp 
#fi 

rm ascii2fits*.temp
