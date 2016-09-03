#!/bin/bash - 
#===============================================================================
#
#          FILE: angle2sep.sh
# 
#         USAGE: ./angle2sep.sh 
# 
#   DESCRIPTION: estimate the separation from the given angle (in ") and redshift
# 				the output separation is in kpc
# 
#       OPTIONS: ---$1 angle in second; $2 redshift
#  REQUIREMENTS: --- z2dis
#          BUGS: ---
#         NOTES: --- # :NOTE:10/31/12 21:40:24 CST:Tang: to change it to luminosity 
# 						distance
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 10/31/12 21:38:27 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

dis=$(z2dis $2 | head -1 | awk '{print $2}')
sep=$( echo "scale=6; $1 * 3.1415925 *1000 * $dis/ (180*3600)" | bc -l )
echo $sep  # :NOTE:11/01/12 13:23:52 CST:Tang: out in kpc

