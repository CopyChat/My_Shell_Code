#!/bin/bash - 
#===============================================================================
#
#          FILE: name.sh
# 
#         USAGE: ./name.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 02/13/2014 11:27:17 RET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


NAME=("John" "Mary" "Fred")
SURNAME=("Doe" "Poppins" "Flintstone")

for i in $@
do
	NAME[${#NAME[@]}]=$i
	SURNAME[${#SURNAME[@]}]=$i
done

for ((i=0; i < ${#NAME[@]}; i++))
do

	echo "Howdy #$i: ${NAME[$i]} ${SURNAME[$i]}"
	NAME[$i]=${SURNAME[$i]}
done
