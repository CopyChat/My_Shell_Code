#!/bin/bash - 
#======================================================
#
#          FILE: rename_space.sh
# 
USAGE="./rename_space.sh"
# 
#   DESCRIPTION: rename file name, replace space to _
# 
#       OPTIONS: ---
#  REQUIREMENTS: --- only one input is allowed
#          BUGS: --- unknown
#         NOTES: ---
#        AUTHOR: |CHAO.TANG| , |chao.tang.1@gmail.com|
    #  ORGANIZATION: 
#       CREATED: 09/06/2019 21:57
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


infile=$(echo $@ | awk 'gsub(/\ /,"\\ ")')
outfile=$(echo $@ | awk 'gsub(/\ /,"_")')

# echo is nessary, if not last cp will not work
echo $infile "-->>" $outfile

eval cp "$infile" $outfile



