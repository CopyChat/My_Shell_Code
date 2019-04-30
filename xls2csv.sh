#!/bin/bash - #======================================================
#
#          FILE: xls2csv.sh
# 
USAGE="./xls2csv.sh"
# 
#   DESCRIPTION:convert xls to csv (not standard xls, but
#               works only for files from Poss_48_SODI
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: --- unknown
#         NOTES:Since vars in the files from Poss_48* are in different
#               columns, so deal with is by each column. 
#               for other xls files, just change the awk selecting code
#        AUTHOR: |CHAO.TANG| , |chao.tang.1@gmail.com|
#  ORGANIZATION: 
#       CREATED: 01/22/2019 14:56
#      REVISION: 1.0
#=====================================================
set -o nounset           # Treat unset variables as an error
#. ~/Shell/functions.sh   # ctang's functions

TEST=0
#--------------------------------------------------- 
while getopts ":tf:" opt; do
    case $opt in
        t) TEST=1; file=testing.xls;;
        f) file=$OPTARG;;
    \?) echo $USAGE && exit 1
    esac
done
shift $(($OPTIND - 1))
#=================================================== 

#echo $file
#exit
#================================================== 
# num of files
#echo "num of files=", $(eval ls *xls | wc -l)

#=================================================== 

#check this file by eye:
#awk '/String/{print $0}' $file | wc
#awk '/String/{print $0}' $file | tail -n 10


function each_column
{
#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  each_column
#   DESCRIPTION:  save each column to a var-named file
#-------------------------------------------------------------------------------

    col=$1
    Name=$(awk -F "\">" '/String/{print $'$col'}' $file | \
        awk -F "<\/" '{print $1}' | head -n 1)

    if [ "$Name" == "Date" ];then
        awk -F "\">" '/String/{print $'$col'}' $file | awk -F "<\/" '{print $1}' | awk NF > $file.Date ;fi

    if [[ "$Name" == *"Irradiat"* ]];then
        awk -F "\">" '/String/{print $'$col'}' $file | awk -F "<\/" '{print $1}' | awk NF > $file.Irradiation ;fi

    if [[ "$Name" == *"Temp"* ]];then
        awk -F "\">" '/String/{print $'$col'}' $file | awk -F "<\/" '{print $1}' | awk NF > $file.Temp;fi

    if [[ "$Name" == *"Puissance"* ]];then
        awk -F "\">" '/String/{print $'$col'}' $file | awk -F "<\/" '{print $1}' | awk NF > $file.Puissance;fi
        #01/23/2019 09:41 'awk NF' for remove blank lines
}

for column in 2 3 4 5 
#01/23/2019 09:36 the num of col is depending on the format of $file
do
    each_column $column
done

#remove blank lines:
#sed -i '/^$/d' $file.Date
#sed -i '/^$/d' $file.Irradiation
#sed -i '/^$/d' $file.Temp
#sed -i '/^$/d' $file.Puissance

#Merge:
paste -d "," $file.Date $file.Temp $file.Irradiation $file.Puissance > $file.csv
#paste -d "," $file.Date $file.Temp $file.Irradiation $file.Puissance | head -n 10


#Check:
line=$(wc -l $file.csv | awk '{print $1}')
if [ $line -ne 145 ]; then
    echo $file $line
fi

#print all the headers
#awk 'NR<=1' $file.csv


#Cleanup
rm Poss*xls.Date 
rm Poss*xls.Temp
rm Poss*xls.Irradiation
rm Poss*xls.Puissance
