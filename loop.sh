#!/bin/bash - 
#======================================================
#
#          FILE: loop.sh
# 
USAGE="./loop.sh"
# 
#   DESCRIPTION: run commander in every $1 seconds
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: --- unknown
#         NOTES: ---
#        AUTHOR: |CHAO.TANG| , |chao.tang.1@gmail.com|
    #  ORGANIZATION: 
#       CREATED: 06/06/19 16:11
#      REVISION: 1.0
#=====================================================
set -o nounset           # Treat unset variables as an error
. ~/Shell/functions.sh   # ctang's functions

while getopts ":tf:" opt; do
    case $opt in
        t) TEST=1 ;;
        f) file=$OPTARG;;
        \?) echo $USAGE && exit 1
    esac
done
shift $(($OPTIND - 1))
#=================================================== 
sleep=$1

while :
do
    ~/software/Python-3.7.3/python clt_MeteoFrance.py -t >> clt.log 2>&1
done


