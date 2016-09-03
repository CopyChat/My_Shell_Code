#!/bin/bash - 
#===============================================================================
#
#          FILE: ls.sh
# 
#         USAGE: ./ls.sh 
# 
#   DESCRIPTION: to check the download file in a directory 
# 
#       OPTIONS: --- the time interval of ls 
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 02/27/2014 03:25:15 PM RET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if [ -z "$1" ]; then
	t=10
	echo "default time interval 10s"
else
	t=$1

fi

t=${1:-10}
echo $?


i=0
while [ $i -lt 1000 ]
do
	time=$(echo "" | awk '{print '$t'*'$i'/60}')
	ls -lh *.????.??.nc
	echo "-----------------------------------" $time mins
	sleep $t
	((i++))
done

exit



