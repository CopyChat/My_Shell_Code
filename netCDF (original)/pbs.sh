#!/bin/bash - 
#===============================================================================
#
#          FILE: pbs.sh
# 
USAGE="./pbs.sh [ - options ] + namelist.in [ + pbs name ]"
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
namelist=${1:?"please input namelist.in ! "}
pname=${2:-"regcm"}
pathpbs=~/Shell/netCDF/std.pbs
color 4 $pathpbs




# pbs the model

if [ "$TEST" = "1" ]; then echo "-t for TEST!"; exit 1; fi
#=================================================== 

color -n 3 " set up the pbs file: "; color 1 " $namelist.pbs "


if [ "$CLM" = "1" ];then
	color -n 2 7 " CLM = "; color 7 1 " $CLM "
	cat  $pathpbs | awk '{gsub(/name90908/,"'$pname'");\
		gsub(/regcmMPI_exe/,"regcmMPI_clm45");\
		gsub(/namelist90908/,"'$namelist'");print}' > ./$namelist.pbs
else
	color -n 2 7 " CLM = "; color 7 1 " $CLM "
	cat  $pathpbs | awk '{gsub(/name90908/,"'$pname'");\
		gsub(/regcmMPI_exe/,"regcmMPI");\
		gsub(/namelist90908/,"'$namelist'");print}' > ./$namelist.pbs
fi


color 1 "============================================"
qstat

color 2 "qsub -W depend=afterok:"
