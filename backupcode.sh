#!/bin/bash - 
#===============================================================================
#
#          FILE: backcode.sh
# 
USAGE="./backupcode.sh  "
# 
#   DESCRIPTION:  
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 03/14/16 22:42:15 MUT
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off
source ~/Shell/functions.sh      			# TANG's shell functions.sh


dir_backup=$HOME/backup
#=================================================== 
while getopts ":td:" opt; do
    case $opt in
        t) TEST=1 ;;
        d) dir_backup=$OPTARG ;;
        \?) echo $USAGE && exit 1
    esac
done

shift $(($OPTIND - 1))
#=================================================== 

file=${1:?please give the name of file. Merci}

color -n 1 7 "backup to dir: " ; color 7 1 " $dir_backup "

tag=$(date | awk '{for(i=1;i<NF;i++) printf "%s_",$i;print $NF}')

cp -v $file $dir_backup/${file%.*}.$tag.${file##*.}
