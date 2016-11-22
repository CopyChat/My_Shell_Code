#!/bin/bash - 
#===============================================================================
#
#          FILE: timestamp.sh
# 
USAGE=" ./timestamp.sh  "
# 
#   DESCRIPTION:  
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 09/05/2014 11:45:06 RET
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off
source ~/Shell/functions.sh      			# TANG's shell functions.sh

#=================================================== 

rm timestamp_*
for file in $(ls *mon.mean* )
do
	echo $file...
	cdo showtimestamp $file >> timestamp_$1
done
