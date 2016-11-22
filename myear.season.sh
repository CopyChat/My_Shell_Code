#!/bin/bash - 
#===============================================================================
#
#          FILE: myear.season.sh
# 
USAGE="./myear.season.sh  "
# 
#   DESCRIPTION:   put input data to swio2, and in season
# 
#       OPTIONS: ---
#  REQUIREMENTS: --- ifunction.sh, cdo
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 11/22/16 18:23:33 RET
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off
source ~/Shell/functions.sh      			# TANG's shell functions.sh
#=================================================== 
while getopts ":d:y:t" opt; do
    case $opt in
        t) TEST=1 ;;
        y) YEARstart=$OPTARG ;;
        d) Duree=$OPTARG ;;
        \?) echo $USAGE && exit 1
    esac
done
shift $(($OPTIND - 1))

infile=$1;YEARend=$(( $YEARstart + $Duree - 1))
#=================================================== 

cdo selyear,$(eval seq -s "," $YEARstart $YEARend) $infile temp1.temp

cdo selmon,1,2,3,4,11,12 temp1.temp temp2.temp
cdo ymonmean temp2.temp ${infile%.nc}.$YEARstart-$YEARend.ymon.mean.NDJFMA.nc

cdo selmon,5,6,7,8,9,10 temp1.temp temp3.temp
cdo ymonmean temp3.temp ${infile%.nc}.$YEARstart-$YEARend.ymon.mean.MJJASO.nc

color 1 7 "done ======================"
rm temp?.temp
ls -lhrt *.nc




