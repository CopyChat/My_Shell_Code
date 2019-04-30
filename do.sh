#!/bin/bash - 
#======================================================
#
#          FILE: do.sh
# 
USAGE="./do.sh"
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: --- unknown
#         NOTES: ---
#        AUTHOR: |CHAO.TANG| , |chao.tang.1@gmail.com|
    #  ORGANIZATION: 
#       CREATED: 01/23/2019 15:46
#      REVISION: 1.0
#=====================================================
set -o nounset           # Treat unset variables as an error
. ~/Shell/functions.sh   # ctang's functions


# 1.xls2csv:
#for f in $(ls Poss*.xls)
#do
    #./xls2csv.sh -f $f
#done

# 2.merge:

#./merge_csv.sh -f 2011-2016.csv

# 3.add missing data
./add_missing.csv.sh -f 2011-2016.csv

