#!/bin/bash - 
#===============================================================================
#
#          FILE: separation.sh
# 
#         USAGE: ./separation.sh 
# 
#   DESCRIPTION: to calculate the separation of two points on the celestial sphere 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 12/28/12 15:20:46 CST
#      REVISION:  ---
#===============================================================================


if [ -z "$1" ]; then
	echo "please input the coordinates of two points on the celestial sphere"
	exit 1
else

#=================================================== check the input
#column=$(wc -l $1 | awk '{print $1}')
#
#if [ $column -lt 4 ]
#	echo "please input the coordinates of TWO points on the celestial sphere"
#	exit 1
#else
awk '{printf "%10.8f %10.8f %10.8f %10.8f \n",$1*3.141592/180,$2*3.141592/180,$3*3.141592/180,$4*3.141592/180}' $1 > separation78786.temp 

awk '{printf "%10.8f\n",3600*180*atan2(sqrt(cos($4)*cos($4)*sin($3-$1)*sin($3-$1)+(cos($2)*sin($4)-sin($2)*cos($4)*cos($3-$1))*(cos($2)*sin($4)-sin($2)*cos($4)*cos($3-$1))),(sin($2)*sin($4)+cos($2)*cos($4)*cos($3-$1)))/3.141592}' separation78786.temp

fi
rm separation78786.temp
