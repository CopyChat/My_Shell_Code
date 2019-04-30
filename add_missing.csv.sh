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
        t) TEST=1;file=2015-2016.csv;;
        f) file=$OPTARG;;
        \?) echo $USAGE && exit 1
    esac
done

shift $(($OPTIND - 1))

#=================================================== 

#file=2015-2016.csv
awk 'NR==1' $file > ${file%.csv}.fixed.csv

function get_value_par_time
{

    startdate=20151030000000
    enddate=20161104000000

    sDateTs=`date -jf "%Y%m%d%H%M%S" $startdate "+%s"`
    eDateTs=`date -jf "%Y%m%d%H%M%S" $enddate "+%s"`

    dateTs=$sDateTs
    offset=600

    while [ "$dateTs" -le "$eDateTs" ]
    do
        timestamp=$(date -jf "%s" $dateTs +"%d/%m/%y %H:%M:%S")
        echo $timestamp

        valid_record=$(grep "$timestamp" $file)


        if [ $(echo $valid_record | wc -w) -gt 1 ];then
            echo "good"
            echo $valid_record >> ${file%.csv}.fixed.csv
        else
            echo "xxxxxxxxxxxxx"
            echo $timestamp",-9999,-9999,-9999" >> ${file%.csv}.fixed.csv
        fi
        dateTs=$(($dateTs+$offset))
    done
}

get_value_par_time 


# 
