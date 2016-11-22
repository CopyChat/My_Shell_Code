#!/bin/bash - 
#===============================================================================
#
#          FILE: remap.sh
# 
USAGE="./remap.sh + ifile (to be changed) + target file "
# 
#   DESCRIPTION:  remap the data accorrding to another netcdf file
# 
#       OPTIONS: ---  
#  REQUIREMENTS: ---  cdo, awk, grads, gradsmap2, gradsbias2,
#          BUGS: ---  no ncpdq command, leave the ofile unpacked
#        USAGES: ---  1,put the requirements in the right places. 
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 02/15/2014 09:52:53 RET
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off
source ~/Shell/functions.sh      			# TANG's shell functions.sh

# define the parameters
####################################################
# deal with the command line
#=================================================== 
if [ $# -lt 2 ]; then
	echo $USAGE
	exit
else
	if [ $# -gt 2 ]; then
		color 7 1 "Come on, too much arguments!"
		exit
	fi
fi
#=================================================== 
rm temp.001.nc 2>&-
stdmap=${2};ifile=${1}
color -n 7 1 "remaping "; color -n 1 7 " $stdmap "
color -n 7 1 " to "; color 1 7 " $ifile ... "
#=================================================== merge
	cdo -b 64 -r genbil,$stdmap $ifile ./weights.nc
	cdo -b 64 -r remap,$stdmap,weights.nc $ifile $ifile.temp
	rm weights.nc 
    ncatted -O -a _FillValue,,o,f,-32767 $ifile.temp
	ncpdq -O $ifile.temp $ifile.remap.nc

	rm $ifile.temp 

