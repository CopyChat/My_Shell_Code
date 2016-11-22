#!/bin/bash - 
#===============================================================================
#
#          FILE: sync.sh
# 
USAGE=" ./sync.sh [ -s] [ + target directory ] "
# 
#   DESCRIPTION: to synchronize RegCM output file to $target ( for the 5year sensitivity test on titan)
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




link=0
#=================================================== 
s="--progress"
while getopts ":ls" opt; do
	case $opt in 
		s) s="" ;;
		l) link=1 ;;
		\?) echo $USAGE && exit 1
	esac
done
shift $(($OPTIND - 1))

#=================================================== set the target
target=/Users/tang/climate/Modeling/EIN15
FROM=("RAD" "ATM" "STS" "SRF")
#=================================================== to synchronize ...
	i=1
	for dir in EIN15
	do
#		for rad in $(echo $@) # default: $@ = " RRTM CCM "
		for rad in  RRTM CCM 
		do
			for conv in GE EE GG EG TT 
			do
				for moisture in SUBEX Micro
				do
					for pbl in Holtslag UW
					do
	for name in ${FROM[@]}
	do
		color -n 1 7 "synchronize  model $i ";color 7 1 " $(eval echo $name) "
		if [ "$i" -eq $1 ]; then
				echo "rsync -arzhSPH $s ctang@titan.univ.run:/worktmp2/RegCM_DATA/Modeling/EIN15/${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng/$i.*.MJJASO.nc $target/${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_bats_zeng/"
                rsync -arzhSPH $s ctang@titan.univ.run:/worktmp2/RegCM_DATA/Modeling/EIN15/${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng/$i.*.nc $target/${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_bats_zeng/
                echo "rsync -arzhSPH $s ctang@titan.univ.run:/worktmp2/RegCM_DATA/Modeling/EIN15/${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng/$i.*.NDJFMA.nc $target/${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_bats_zeng/"
                rsync -arzhSPH $s ctang@titan.univ.run:/worktmp2/RegCM_DATA/Modeling/EIN15/${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng/$i.*.nc $target/${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_bats_zeng/
		fi
	done
					((i++))
					done
				done
			done
		done
	done


#=================================================== make links
if [ "$link" = "1" ]; then
	i=1
	for dir in EIN15
	do
#		for rad in $(echo $@) # default: $@ = " RRTM CCM "
		for rad in  RRTM CCM 
		do
			for conv in GE EE GG EG TT 
			do
				for moisture in SUBEX Micro
				do
					for pbl in Holtslag UW
					do
model=/Users/tang/climate/modeling/EIN15

	if [ "$i" -lt 10 ]; then
		ln -sf $target/0${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_bats_zeng/ $model/
	else
		ln -sf $target/${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_bats_zeng/ $model/${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_bats_zeng/
	fi
					((i++))
					done
				done
			done
		done
	done
fi

exit
