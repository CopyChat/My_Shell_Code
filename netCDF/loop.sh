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


####################################################
# deal with the command line
#=================================================== 
if [ $# -lt 1 ]; then
	echo "Useage: loop.sh + command line "
	exit
else
	if [ $# -eq 1 ]; then
		command=$1
		DefaultDir=$(pwd)
		year=$(ls *.????.00.nc | head -1 | awk -F '.' '{print $2}')
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
rm temp.001.nc 2>&-

echo "###################################"
echo "###################################"
echo "###################################"

for file in $(ls *.$year.??.nc)
do
	echo "---------------------- $file"
	
#=================================================== merge

echo $command " ifile ofile"	

	$command $file temp.$file
	ncpdq -O temp.$file $file 
	rm temp.*.nc 2>&-


done
exit

