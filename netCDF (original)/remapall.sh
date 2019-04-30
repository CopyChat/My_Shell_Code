#!/bin/bash - 
#===============================================================================
#
#          FILE: remap.sh
# 
#         USAGE: ./remap.sh + RegCM global data directory 
# 
#   DESCRIPTION:  remap the data accorrding to EIN15 for swio
# 
#       OPTIONS: ---  
#  REQUIREMENTS: ---  cdo, awk, grads, gradsmap2, gradsbias2,
# 					  stdmap.gs, stdbiasmap.gs color.gs,cbarn.gs
# 					  GrADSNcPrepare in RegCM-4.3.5.6/bin
# 					  there is a tar file in ~/backup/pprc.tar
#          BUGS: ---  no ncpdq command, leave the ofile unpacked
#        USAGES: ---  1,put the requirements in the right places. 
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 02/15/2014 09:52:53 RET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# define the parameters
####################################################
stdmap15path=/Users/tang/Shell/netCDF/stdmap.ein15.nc


stdmap15=$(echo $stdmap15path | awk -F '/' '{print $(NF)}')
echo $stdmap15path
echo $stdmap15
####################################################
#
#echo ${oldvarname2[*]}
#echo ${newvarname2[*]}

#
# deal with the command line
#=================================================== 
if [ $# -lt 1 ]; then
	echo "Useage: varname + RegCM global data directory ( such as 1986)"
	exit
else
	if [ $# -eq 1 ]; then
		cd $1
		DefaultDir=$(pwd)
		year=$(pwd | awk -F '/' '{print $NF}')
		echo $year
		rm temp*.nc 2>&-
		#================================= test the directory
		if [ $(ls *.????.??.nc 2>&- | wc -l) -lt 1 ];then
			echo "------------------------"
			echo "SORRY, NO EINXX input file in this directory."
			exit
		else
			if [ $(ls *.????.??.nc 2>&- | wc -l) -gt 20 ];then
				echo " too many files in this directory "
				exit
			fi
		fi
	else
		echo "Come on, too much arguments!"
		exit
	fi
fi
#=================================================== 
#=================================================== 
cd $DefaultDir
cp $stdmap15path ./
ls std*
rm temp.001.nc 2>&-

echo "###################################"
echo "###################################"
echo "###################################"

for file in $(ls *.$year.??.nc)
do
	echo "---------------------- $file"
	
#=================================================== merge

echo " cdo -b 64 -r genbil,$stdmap15 $file weights.nc"
echo"cdo -b 64 -r remap,$stdmap15,weights.nc $file temp.$file"
	
	cdo -b 64 -r genbil,$stdmap15 $file weights.nc
	cdo -b 64 -r remap,$stdmap15,weights.nc $file temp.$file
	rm weights.nc 
	ncpdq -O $file temp.$file 

	mv temp.$file $file
done
rm $stdmap15
exit

