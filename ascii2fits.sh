#!/bin/bash - 
#===============================================================================
#
#          FILE: ascii2fits.sh
# 
#         USAGE: ./ascii2fits.sh 
# 
#   DESCRIPTION: convert ascii ($1) to fits (fits) & add the header ($3)
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
if [ -z "$2" ]; then
	echo "please input the header of each columns"
	exit 1
fi
#if [ -z "$3" ]; then
#	echo "please input the target fits file"
#fi


#=================================================== 
echo "#" > ascii2fits2.temp
transpose.sh $2 >> ascii2fits3.temp
paste -d " " ascii2fits2.temp ascii2fits3.temp > ascii2fits1.temp

cat $1 >> ascii2fits1.temp

stilts tpipe ifmt=ascii ascii2fits1.temp ofmt=fits 
rm ascii2fits*.temp


