#!/bin/bash - 
#===============================================================================
#
#          FILE: seltimestep.sh
# 
USAGE=" ./seltimestep.sh  "
# 
#   DESCRIPTION:  
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 09/04/2014 21:44:31 RET
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off
source ~/Shell/functions.sh      			# TANG's shell functions.sh

#=================================================== 

echo "cdo seltimestep,2,3,4,5,6,7,8,9,10,11,12,13 ATM.all.2003.nc atm.2003.nc"
cdo seltimestep,2,3,4,5,6,7,8,9,10,11,12,13 ATM.all.2003.nc atm.2003.nc

echo "cdo seltimestep,2,3,4,5,6,7,8,9,10,11,12,13 RAD.all.2003.nc rad.2003.nc"
cdo seltimestep,2,3,4,5,6,7,8,9,10,11,12,13 RAD.all.2003.nc rad.2003.nc

echo "cdo seltimestep,2,3,4,5,6,7,8,9,10,11,12,13 SRF.all.2003.nc srf.2003.nc"
cdo seltimestep,2,3,4,5,6,7,8,9,10,11,12,13 SRF.all.2003.nc srf.2003.nc

echo "cdo seltimestep,2,3,4,5,6,7,8,9,10,11,12,13 STS.all.2003.nc sts.2003.nc"
cdo seltimestep,2,3,4,5,6,7,8,9,10,11,12,13 STS.all.2003.nc sts.2003.nc


#=================================================== 
echo "cdo showtimestamp atm.2003.nc"
cdo showtimestamp atm.2003.nc

echo "cdo showtimestamp rad.2003.nc"
cdo showtimestamp rad.2003.nc

echo "cdo showtimestamp srf.2003.nc"
cdo showtimestamp srf.2003.nc

echo "cdo showtimestamp sts.2003.nc"
cdo showtimestamp sts.2003.nc

#=================================================== 
rm ATM.all.2003.nc; ls
rm RAD.all.2003.nc; ls
rm SRF.all.2003.nc; ls
rm STS.all.2003.nc; ls

#=================================================== 
mv atm.2003.nc ATM.all.2003.nc

mv rad.2003.nc RAD.all.2003.nc

mv srf.2003.nc SRF.all.2003.nc

mv sts.2003.nc STS.all.2003.nc

#=================================================== 
cdo showtimestamp ATM.all.2003.nc
cdo showtimestamp RAD.all.2003.nc
cdo showtimestamp SRF.all.2003.nc
cdo showtimestamp STS.all.2003.nc
