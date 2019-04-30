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
#       CREATED: Thu Nov 27 16:16:11 CET 2014
#      REVISION:  ---
#===============================================================================

#set -o nounset                             # Treat unset variables as an error
shopt -s extglob 							# "shopt -u extglob" to turn it off
source ~/Shell/functions.sh


target=${1:-ctang@ccur.univ-reunion.fr:/labos/le2p/ctang/STOCKAGE/Meteosat-7_SWIO_RAD}
# that's the place I could store the data in "STOCKAGE"
sourcce="/Volumes/Mac/Meteosat-7_SWIO_RAD"
# thanks to Prof. Thomas Huld from JRC, for the derived data of radiation from raw Meteasat-7 
# satelate data.
FROM=("B" "G")
# B: for the direct
# G: for global data
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
    for year in 2010 
    do
        for month in  $(printf "%02d " {1..12}; echo)
        do
            for day in $(printf "%02d " {1..31}; echo)
            do
                color -n 1 7 "Synchronize... ";
                color -n 6 5 " $(eval echo $year) ";
                color -n 3 1 " $(eval echo $month) ";
                color -n 2 5 " $(eval echo $day) ";
                rsync -arzhSPH $s $sourcce/$year/${name}_$year$month$day*.gz $target/$year
            done
        done
    done
done

#ls -lh $target

exit
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

