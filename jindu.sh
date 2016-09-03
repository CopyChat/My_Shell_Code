#!/bin/bash - 
#===============================================================================
#
#          FILE: jindu.sh
# 
USAGE="./jindu.sh  "
# 
#   DESCRIPTION:  
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 06/27/2014 08:46:32 MSK
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off
source ~/Shell/functions.sh      			# TANG's shell functions.sh

#=================================================== 
i=0
color -n 6 7 " the process is running:  " 
while [ $i -lt 100 ]
do
  for j in '-' '\\' '|' '/'
  do
    echo -ne "\033[1D$j"
    sleep .1
  done
  ((i++))
done
