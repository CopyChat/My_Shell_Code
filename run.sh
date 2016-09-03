#!/bin/bash - 
#===============================================================================
#
#          FILE: run.sh
# 
USAGE="./run.sh [ - options ] + namelist.in "
# 
#   DESCRIPTION:  
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 06/02/2014 11:08:59 MSK
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off
source ~/Shell/functions.sh      			# TANG's shell functions.sh

#=================================================== 
#default:
CLM=0;TEST=0;
#=================================================== 


while getopts ":tc" opt; do
	case $opt in
		t) TEST=1 ;;
		c) CLM=1 ;;
	\?) echo $USAGE && exit 1
esac
done

shift $(($OPTIND - 1))
#=================================================== 
namelist=${1:-?"please input namelist.in ! "}



# run the model

if [ "$TEST" = "1" ]; then echo "-t for TEST!"; exit 1; fi
#=================================================== 

color 7 3 " terrain:  "
terrain $namelist


if [ "$CLM" = "1" ];then
	color 7 3 " clm:  "
	clm2rcm $namelist
	until cp $REGCM_GLOBEDAT/CLM/pft-physiology.c070207 input/; do
		color -n 7 1 "CLM "; color -n 1 7 " unsucessfully "; color 7 1 "generated ... "
	done
	if [ -f ./input/pft-physiology.c070207 ];then
		color -n 7 1 "CLM "; color -n 1 7 " sucessfully "; color 7 1 " generated ... "
	fi

fi


color 7 3 " sst: "
sst $namelist

color 7 3 " icbc: "
icbc $namelist





#mpirun -np 4 regcmMPI_clm $namelist



