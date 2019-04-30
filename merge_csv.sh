#!/bin/bash - 
#======================================================
#
#          FILE: merge_csv.sh
# 
USAGE="./merge_csv.sh"
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: --- unknown
#         NOTES: ---
#        AUTHOR: |CHAO.TANG| , |chao.tang.1@gmail.com|
    #  ORGANIZATION: 
#       CREATED: 01/23/2019 11:01
#      REVISION: 1.0
#=====================================================
set -o nounset           # Treat unset variables as an error
. ~/Shell/functions.sh   # ctang's functions

TEST=0
while getopts ":tf:" opt; do
    case $opt in
        t) TEST=1; outfile=testing.out.csv;;
        f) outfile=$OPTARG;;
        \?) echo $USAGE && exit 1
    esac
done
shift $(($OPTIND - 1))

#=================================================== 

# get header

echo "Date,Temp_C,Irradiation_Wm2,Puis_W" > $outfile

for f in $(ls Poss*xls.csv)
do
    awk 'NR>1' $f >> $outfile
done

