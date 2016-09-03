#!/bin/bash - 
#===============================================================================
#
#          FILE: nc.sh
# 
#         USAGE: ./nc.sh 
# 
#   DESCRIPTION: to deal with the downloaded nc data 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 02/07/2014 18:09:31 RET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

year=1983


for var in air hgt rhum uwnd vwnd
do
	for time in 00 06 12 18
	do
		echo $var'.'$year'.'$time'*'.nc
		cdo -b 64 mergetime $var'.'$year'.'$time'*'.nc $var'_'$year'.'$time.nc
		ncpdq $var'_'$year'.'$time.nc $var'.'$year'.'$time.nc
		rm $var'_'$year'.'$time.nc 
		echo DONE
	done
done
alert WORK DONE ^_^
