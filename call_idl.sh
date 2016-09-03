#!/bin/bash - 
#===============================================================================
#
#          FILE: call_idl.sh
# 
#         USAGE: ./call_idl.sh 
# 
#   DESCRIPTION: to test the getenv, when calling idl from shell 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 01/06/13 10:34:15 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

export input="input.dat"
idl < mean1.pro

