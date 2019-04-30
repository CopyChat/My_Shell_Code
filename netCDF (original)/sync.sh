#!/bin/bash - 
#===============================================================================
#
#          FILE: sync.sh
# 
USAGE=" ./sync.sh [ -s] [ + target directory ] "
# 
#   DESCRIPTION: to synchronize RegCM output file to $target
# 
#       OPTIONS: --- -s, to be silent
#  REQUIREMENTS: --- rsync
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


target=${1:-/Users/tang/climate/Modeling/.from_titan}
FROM=("rad" "sts")
#=================================================== 
s="--progress"
while getopts ":s" opt; do
	case $opt in 
		s) s="" ;;
		\?) echo $USAGE && exit 1
	esac
done
shift $(($OPTIND - 1))

#=================================================== to synchronize file from titan
for name in ${FROM[@]}
do
	color -n 1 7 "synchronize ";color 7 1 " $(eval echo $name) "
	rsync -arzhSPH $s ctang@titan.univ.run:/worktmp2/RegCM_DATA/Modeling/*/output/*.$name.out.nc $target
done

#ls -lh $target

#=================================================== make links
for file in $(ls $target)
do
	dir=${file%%.*.nc}
	mkdir -p ${target%/*}/$dir/output
#	color 1 7 "$(eval echo $dir)"
	rm ${target%/*}/$dir/output/$file 2>&-
	ln -s $target/$file  ${target%/*}/$dir/output/$file
#ls ${target%/*}/$dir/output/ | grep rad
done


