#!/bin/bash - 
#===============================================================================
#
#          FILE: lnall.sh
# 
#         USAGE: ./lnall.sh 
# 
#   DESCRIPTION: to create links to path_B from all the files in current directory 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: --- # :NOTE:10/21/12 20:08:14 CST:Tang: from Path_A
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 10/21/12 20:05:54 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
FILELIST=`ls ../`
for FILENAME in $FILELIST
do
	ln -s pwd"/"$FILENAME $FILENAME"_link"
done


