#!/bin/bash - 
#===============================================================================
#
#          FILE: mkalias.sh
# 
USAGE="./mkalias.sh alais constent "
# 
#   DESCRIPTION:  to set/unset a alias of the input directory
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 04/09/2014 21:37:29 RET
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off
source ~/Shell/functions.sh      			# TANG's shell functions.sh

#=================================================== 

while getopts ":t" opt; do
	case $opt in
		t) TEST=1 ;;
	\?) color 1 7 $(eval echo $USAGE) && exit 1
esac
done

shift $(($OPTIND - 1))


#=================================================== 

case $# in
	2) 
		if [ -n $(grep '^alias '$1'\=' ~/.bashrc) ]; then 
			echo "alias $1=\"$2\"" >> ~/.bashrc 
			color 3 "alias $1=\"$2\""
		else
			color -n 1 7 " $1 exits already as an alias, " ; color 7 1 " try again !"
		fi
		;;
	\?) color 1 7 $(eval echo $USAGE) && exit 1
esac


