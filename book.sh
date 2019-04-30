#!/bin/bash - 
#===============================================================================
#
#          FILE: book.sh
# 
#         USAGE: ./book.sh 
# 
#   DESCRIPTION: in this file, I write some useful example codes 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 03/07/2014 11:24:40 RET
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

echo ${pwd##/*/}
#===================================================  missing file arguments
if [ ! -e "$1" ] ; then
	echo 'usage: highest filename [-N]'
	exit 1
fi

filename=$1
howmany=${2:--10}

exit
#=================================================== 
path=/home/cam/book/long.file.name
echo " get the file name "
echo ${path##/*/}
echo " get the file extension name "
echo ${path##*.}
echo ${path##*file}
echo " get the path "
echo ${path%/*}/

source ~/Shell/functions.sh
echo "============="
echo "\$@ $@"
echo "\$* $*"
echo "============="
show ewrewq 
echo "============="
IFS=\&999
echo "$*"


echo ${a:=0}
echo ${path:12:20} # cut the $variable by index of charators, the 1st=0
howmany=${3:-10} # set the default value equals to argument 3.
echo $howmany 


if filename=${1:?"filename is missing."} && command=${2:?"no command "}
then
	echo $filename
fi
#sort -nr $filename | head -${howmany:=10}


#=================================================== extglob
# used 'shopt -s extglob' to enable, 'shopt -u extglob' to turn it off
shopt -s extglob
#echo "ls +(kil*|sm*)"0j
#ls !(vt+([0-9]))
#ls @(alice|hatter|hare) #would only match alice, hatter, or hare.
#ls !(alice|hatter|hare) #matches everything except alice, hatter, and hare.
#ls @(kil*|sm*)
#=================================================== 
Start=${1:-1979};End=${2:-1983} 		#  default

if [ $(uname) = "Darwin" ]; then
	y="echo \{$(jot -s "," - $Start $End)\}" # for mac
else
	y="echo \{$(seq -s "," $Start $End)\}" # for linux
fi
 printf "%03d " {0..100}; echo

cd $path; mkdir temp90908 2>&-
dir=$(pwd | tr [A-Z] [a-z] )
dattyp=${dir##/*/}
#=================================================== 

#ln -sf $path/{1979,1980,1981,1982,1983}/* temp90908
eval ln -sf $path/$(eval $y)/* temp90908

cd temp90908
for var in air rhum 
do
	echo "=================" $var
	if [ $(ls $var.????.{00,06,12,18}.nc | wc -l ) -lt 8 ];then
		echo "some file missing"; exit 1
	fi
	cdo -b 64 -r mergetime $var.????.{00,06,12,18}.nc $var.1.temp.nc
	cdo -b 64 -r sellevel,1000 $var.1.temp.nc $var.temp.nc
	if [ $var = "air" ]; then
		ncrename -O -v .t,tas $var.temp.nc 2>&-
	fi
	cdo -b 64 -r ymonmean $var.temp.nc $path/$var.ymonmean.$dattyp.nc
	cdo -b 64 -r timmean $var.temp.nc $path/$var.5ymean.$dattyp.nc
	rm $var.*temp.nc $var.????.{00,06,12,18}.nc
done

rm -rf $path/temp90908

exit 0
#=================================================== 

for ((i=0;i<$SEND_THREAD_NUM;i++));do 
#=================================================== 
shopt -s extglob
#rm !(*196101-2005*)
#ls  $PWD/*
done
