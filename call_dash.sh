#!/bin/bash - 
#===============================================================================
#
#          FILE: call_dash.sh
# 
#         USAGE: ./call_dash.sh 
# 
#   DESCRIPTION: to call dash use the code open dash://{query} 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 12/01/2013 17:48:26 RET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if [ $# -lt 1 ];then
	echo "what do you want to know, sir?"
	exit 1
fi

open dash://$1
