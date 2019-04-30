#!/bin/bash - 
#===============================================================================
#
#          FILE: 5ymean.sh
# 
USAGE=" ./5ymean.sh [ + start ] [ + end ]"
# 
#   DESCRIPTION:  
# 
#       OPTIONS: ---
#  REQUIREMENTS: --- cdo
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 03/11/2014 17:35:20 RET
#      REVISION:  ---
#===============================================================================
#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off

path=/Users/tang/climate/GLOBALDATA/EIN15
#=================================================== 
Start=${1:-1979};End=${2:-1983} 		#  default

if [ $(uname) = "Darwin" ]; then
	y="echo \{$(jot -s "," - $Start $End)\}" # for mac
else
	y="echo \{$(seq -s "," $Start $End)\}" # for linux
fi


cd $path; mkdir temp90908 2>&-
dir=$(pwd | tr [A-Z] [a-z] )
dattyp=${dir##/*/}
#=================================================== 

#ln -sf $path/{1979,1980,1981,1982,1983}/* temp90908
eval ln -sf $path/$(eval $y)/* temp90908

cd temp90908
for var in air rhum 
do
	echo "=================" $var
	if [ $(ls $var.????.{00,06,12,18}.nc | wc -l ) -lt 8 ];then
		echo "some file missing"; exit 1
	fi
	cdo -b 64 -r mergetime $var.????.{00,06,12,18}.nc $var.1.temp.nc
	cdo -b 64 -r sellevel,1000 $var.1.temp.nc $var.temp.nc
	if [ $var = "air" ]; then
		ncrename -O -v .t,tas $var.temp.nc 2>&-
	fi
	cdo -b 64 -r ymonmean $var.temp.nc $path/$var.ymonmean.$dattyp.nc
	cdo -b 64 -r timmean $var.temp.nc $path/$var.5ymean.$dattyp.nc
	rm $var.*temp.nc $var.????.{00,06,12,18}.nc
done

rm -rf $path/temp90908

exit 0
