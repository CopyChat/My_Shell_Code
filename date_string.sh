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

# first, to see if all the missing hours in Moutou,
# are ZERO in the Gilot data

function if_missing_is_ZERO
{
    for f in $(ls *csv)
    do
        puiss=$(awk -F ',' '/05:10:00/{print $3}' $f)
        if [ "$puiss" -eq "0" ]; then 
            echo -n " 00000 "
        else
            color 7 1 $f
        fi
    done
}



# get header from the origional file
#awk 'NR==1' $file > ${file%.csv}.fixed.csv

function get_value_par_time
{

    file=$1

    #set staring and ending datetime depending on the input file
    startdate=20110601000000
    enddate=20130531000000

    # convert date in format to strings:
    sDateTs=`date -jf "%Y%m%d%H%M%S" $startdate "+%s"`
    eDateTs=`date -jf "%Y%m%d%H%M%S" $enddate "+%s"`

    dateTs=$sDateTs
    offset=600

    while [ "$dateTs" -le "$eDateTs" ]
    do
        timestamp=$(date -jf "%s" $dateTs +"%d/%m/%y %H:%M:%S")
        echo $timestamp

        valid_record=$(grep "$timestamp" $file)


        # if this timestamp is well recorded in $file:
        if [ $(echo $valid_record | wc -w) -gt 1 ];then
            echo "good"
            # put this record into new file containing missing data
            echo $valid_record >> ${file%.csv}.fixed.csv
        else
            echo "xxxxxxxxxxxxx"
            echo $timestamp",-9999,-9999,-9999" >> ${file%.csv}.fixed.csv
            # set missing data = -9999
        fi
        dateTs=$(($dateTs+$offset))
    done
}

function merge_all_MOUTOU
{
    outputfile=$1

    head -n 1 MOUTOU_2013-05-31.xls.csv > $outputfile

    for f in MOUTOU*xls.csv
    do
        echo $f
        awk 'NR>1{print $0}' $f >> $outputfile
    done

}
#if_missing_is_ZERO

# set output name:
outputfile=MOUTOU_20110601-20130531.csv

merge_all_MOUTOU $outputfile

get_value_par_time $outputfile


# 
