#!/bin/bash - 
#===============================================================================
#
#          FILE: mask.sh
# 
USAGE=" ./mask.sh netCDF [ -o ] ifile [ + ofile ]"
# 
#   DESCRIPTION:  
# 
#       OPTIONS: --- -o for ocean
#       		 --- -l for land, default
#  REQUIREMENTS: --- cdo, awk
#          BUGS: ---
#         NOTES: --- mask only contain "0" & "2".
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 03/17/2014 11:47:36 RET
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off

#=================================================== 
ocean=0; mask=land
#--------------------------------------------------- 
while getopts ":lo" opt; do
	case $opt in 
		l) land=1 ;;
		o) ocean=1; mask=ocean ;;
		\?) echo $USAGE && exit 1
	esac
done

shift $(($OPTIND - 1))
#--------------------------------------------------- 
ifile=${1:-test_001_STS.1982120100.nc}
ofile=${2:-$(echo $mask.${ifile%.*nc})}
echo output: $ofile.nc


rm exprf.temp exprf.temp.nc 2>&-
if [ $ocean -eq 0 ];then
	cdo -s showvar $ifile | awk '{for(i=1;i<=NF;i++) print $i,"=",$i,"* mask / 2 ;"}' > exprf.temp
else
	cdo -s showvar $ifile | awk '{for(i=1;i<=NF;i++) print $i,"=","( mask -2 ) * ( - 0.5 ) *",$i";"}' > exprf.temp
fi

#cat exprf.temp

cdo -b 64 exprf,exprf.temp $ifile exprf.temp.nc
cdo -b 64 setctomiss,0 exprf.temp.nc $ofile.nc

rm exprf.temp exprf.temp.nc 2>&-
exit 1

