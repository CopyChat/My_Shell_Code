#!/bin/bash - 
#===============================================================================
#
#          FILE: sync.sh
# 
USAGE=" ./model.sh [ -t] + directory [ + model directory ] "
# 
#   DESCRIPTION: to synchronize RegCM output file to $target
# 
#       OPTIONS: --- -s, to be silent
#  REQUIREMENTS: --- mkdir,
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 03/18/2014 17:16:46 RET
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off
source ~/Shell/functions.sh


#=================================================== 
while getopts ":t" opt; do
	case $opt in 
		t) TEST=1 ;;
		\?) echo $USAGE && exit 1
	esac
done
shift $(($OPTIND - 1))

#=================================================== 
Dir=${1:?"input missing !"}
CDir=$(pwd)
SDir=${2:-/Users/tang/Shell/netCDF/model}

#=================================================== 
mkdir -p $Dir/input $Dir/output
cp $SDir/test_001.in $Dir/$Dir.in
cp $SDir/test_001.pbs $Dir/$Dir.pbs

color 1 3 " ok !!"



exit

rsync -arzhSH $s ctang@titan.univ.run:/worktmp2/RegCM_DATA/Modeling/*/output/*.sts.out.nc $target

for file in $(ls $target)
do
	dir=${file%%.*.nc}
	mkdir -p ${target%/*}/$dir/output
	rm ${target%/*}/$dir/output/$file 2>&-
	ln -s $target/$file  ${target%/*}/$dir/output/$file
done

