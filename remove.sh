#!/bin/bash - 
#===============================================================================
#
#          FILE: remove.sh $1 $2 [$3 $4]
# 
#         USAGE: ./remove.sh 
# 
#   DESCRIPTION: to remove lines with all columns from $2 if it's $3 column matchs $3 in $1
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 12/04/12 19:19:22 CST
#      REVISION:  --- 1.1
#===============================================================================

if [ -z "$1" ]; then
	echo "please input the sourse file"
	exit 1
fi
if [ -z "$2" ]; then
	echo "please input the sourse file"
	exit 1
fi
if [ -z "$3" ]; then
	c=1
	d=1
	#echo "default: use the FIRST column!"
else 
	c=$3
	d=$4
fi

awk 'NR==FNR{a[$'$c']=$'$c'}NR!=FNR{if($'$d'!=a[$'$d'])print $0}' $1 $2 

exit
#===================== my old code
i=1
cp $1 pickout90908.temp

for id in $(awk '{print $'$c'}' $2)
do
#	echo $i $id
	awk '$'$c'!='$id'' pickout90908.temp > pickout89897.temp
	mv pickout89897.temp pickout90908.temp
	((i++))
done
#mv pickout90908.temp $1_pickout
cat pickout90908.temp
rm pickout90908.temp
#wc -l $1_pickout 
