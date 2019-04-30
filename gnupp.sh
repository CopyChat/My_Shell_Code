#!/bin/bash - 
#===============================================================================
#
#          FILE: gnupp.sh
# 
USAGE= "gnupp.sh [ line1 ] [ line2 ] inputfile "
# 
#   DESCRIPTION:  to plot data in two lines of ONE file.
# 
#       OPTIONS: --- t, for TEST
#                --- f, give format of output
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 10/21/15 15:16:00 SCT
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off
source ~/Shell/functions.sh      			# TANG's shell functions.sh
#=================================================== 

TEST=0
#--------------------------------------------------- 
while getopts ":tf:" opt; do
    case $opt in
        t) TEST=1 ;;
    \?) echo $USAGE && exit 1
esac
done

shift $(($OPTIND - 1))
#=================================================== 
set -o nounset                              # Treat unset variables as an error

if [ $# -lt 1 ]; then
	echo "Useage: smm darafile line1 line2 OR smm xxx.sm"
	exit
fi
if [ $# -eq 2 ]; then
	echo "Useage: smm darafile line1 line2 OR smm xxx.sm"
	exit
fi

if [ $# -eq 1 ]; then
echo "--------------------------------------"
sm -m $1 
a=$(echo $1 | sed -e "s/.sm/.eps/g") 
# change .sm to .pdf and give this value to a
ps2pdf $a
b=$(echo $a  | sed -e "s/.eps/.pdf/g") 
# change .sm to .pdf and give this value to a
killall AdobeAcrobat
echo $b
open $b
#echo ${#1} # get length of $1
else
	head -15  ~/Shell/standard.sm | awk '{gsub(/standard90908/,"smm90908temp");gsub(/line1/,"'$2'");gsub(/line2/,"'$3'");gsub(/data89897/,"'$1'");print}' > smm90908temp.sm
	sm -m smm90908temp.sm
	ps2pdf smm90908temp.eps
	killall AdobeAcrobat
	echo smm90908temp.pdf
	open smm90908temp.pdf

	rm smm90908temp.sm smm90908temp.eps
fi
