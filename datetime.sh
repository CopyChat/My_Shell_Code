#!/bin/bash - 
#======================================================
#
#          FILE: add_missing.csv.sh
# 
USAGE="./add_missing.csv.sh"
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: --- unknown
#         NOTES: ---
#        AUTHOR: |CHAO.TANG| , |chao.tang.1@gmail.com|
    #  ORGANIZATION: 
#       CREATED: 01/23/2019 11:06
#      REVISION: 1.0
#=====================================================
set -o nounset           # Treat unset variables as an error
. ~/Shell/functions.sh   # ctang's functions
TEST=0
while getopts ":tf:" opt; do
    case $opt in
        t) TEST=1 ;;
        f) file=$OPTARG;;
        \?) echo $USAGE && exit 1
    esac
done

shift $(($OPTIND - 1))

#=================================================== 
startdate=2010-01-01
enddate=2010-01-31
startdate=201101010000
enddate=201101020000

sDateTs=`date -jf "%y%m%d%H%M%S" $startdate "+%s"`
eDateTs=`date -jf "%y%m%d%H%M%S" $enddate "+%s"`

dateTs=$sDateTs
offset=600

while [ "$dateTs" -le "$eDateTs" ]
do
    date -jf "%s" $dateTs +"%d/%m/%y %H:%M:%S"
    dateTs=$(($dateTs+$offset))
done
