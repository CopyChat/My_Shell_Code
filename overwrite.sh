#!/bin/bash - 
#===============================================================================
#
#          FILE: overwrite.sh
# 
USAGE=" ./overwrite.sh [+ opts ] + bash shell command options + ifile "
# 
#   DESCRIPTION: to overwrite without comfirm 
# 
#       OPTIONS: ---  -f  overwrite the files without prompting for confirmation
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 03/18/2014 10:04:57 RET
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off
#=================================================== 
ask=0
while getopts ":f" opt; do
	case $opt in 
		 f) ask=1 ;;
		\?) echo $USAGE && exit 1
	esac
done

shift $(($OPTIND - 1))
#=================================================== 
command=${1:?"command missing"} 
ifile=${2:?"ifile missing"}
exten=${ifile##*.}

if [ $ask = "1" ]; then 
	echo "One variable name would be changed, Continue? (Yes/n)?"
	read answer
	if [ $answer = "Yes" ]; then : else exit 1; fi
fi


#=================================================== functions
echo "$command $ifile"
$command overwrite.90908.temp.$exten
declare -r status=$?

if [ $status != 0 ]; then
	echo "Something wrong with this command"
else
	mv overwrite.90908.temp.$exten $ifile
fi
exit 0

