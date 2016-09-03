#!/bin/bash - 
#===============================================================================
#
#          FILE: highest.sh
# 
#         USAGE: ./highest.sh 
# 
#   DESCRIPTION: to test in the book 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 03/09/2014 22:29:12 RET
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# 'shopt -u extglob' to turn it off

if [ -n "$(echo $1 | grep '^-[0-9][0-9]*$')" ]; then

    howmany=$1

    shift

elif [ -n "$(echo $1 | grep '^-')" ]; then

    print 'usage: highest [-N] filename'

    exit 1

else

    howmany="-10"

fi

     

filename=$1

sort -nr $filename | head $howmany
