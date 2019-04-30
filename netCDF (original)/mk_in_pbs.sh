#!/bin/bash - 
#===============================================================================
#
#          FILE: mk_in_pbs.sh
# 
         USAGE="./mk_in_pbs.sh - opts "
# 
#   DESCRIPTION:  
# 
#       OPTIONS: --- 	p) pbs=1 ;;      			# whether generate the pbs job
#						s) submit=1 ;; 				# whether submit the job
#						s) monmean=1 ;; 			# whether do the monthly mean
#						d) mk_dir=1 ;; 				# whether make output dir
#						t) Test=1 ;;
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 07/04/2014 03:13:33 PM RET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
source ~/Shell/functions.sh

#========================================================== 
	pbs=0;submit=0;monmean=0;Test=0;mk_dir=0;Clear=0;delete=0;sync=0
#========================================================== 
while getopts ":tdpcS" opt; do
	case $opt in 
		p) pbs=1 ;;      			# whether generate the pbs job
		s) submit=1 ;; 				# whether submit the job
		S) sync=1 ;; 				# synchronize the result to local
		m) monmean=1 ;; 			# whether do the monthly mean
		d) mk_dir=1 ;; 				# whether make output dir
		R) delete=1 ;; 				# release the space
		c) Clear=1; mk_dir=1 ;; 				# whether clear the output dir
		t) Test=1 ;;
		\?) echo $USAGE && exit 1
	esac
done
shift $(($OPTIND - 1))
#if [ $(( $plot + $cal + $select )) -eq 0 ]; then plot=1;cal=1;select=1; fi
echo "___________________________________________________________________"
color 3 2 " pbs=$pbs;submit=$submit;monmean=$monmean;Test=$Test;delete=$delete"
echo "-------------------------------------------------------------------"
if [ "$Test" = "1" ]; then echo "-t for TEST!"; exit 1; fi
#================================================================================== 
				if [ "$Clear" = "1" ]; then
					rm -rf *output_*_BATS_Zeng
					rm EIN15*.in EIN15*.pbs runlog.EIN* release*.err release*.out pprcm*.err pprcm*.out *ein15*.out *ein15*.err
				fi
#=================================================== 
color 1 3 " start to write the in files: "
	i=1
	iconv90908=0
	for dir in EIN15
	do
		for rad in $(echo $@) # default: $@ = " RRTM CCM "
		do
			for conv in GE EE GG EG TT 
			do
				for moisture in SUBEX Micro
				do
					for pbl in Holtslag UW
					do
						
				if [ "$mk_dir" = "1" ]; then
					if [ "$i" -lt 10 ]; then
						mkdir 0${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng
					else
						mkdir ${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng
					fi
				fi
#=================================================== to synchronize ...

if [ "$sync" = "1" ]; then
	target=${1:-/Users/tang/climate/Modeling/EIN15}
	FROM=("RAD" "ATM" "STS" "SRF")
	for name in ${FROM[@]}
	do
		color -n 1 7 "synchronize  model $i ";color 7 1 " $(eval echo $name) "
		if [ "$i" -lt 10 ]; then
			rsync -arzhSPH $s ctang@titan.univ.run:/worktmp2/RegCM_DATA/Modeling/EIN15/output_${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng/$name.all.nc $target/0${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_bats_zeng/
		else
			rsync -arzhSPH $s ctang@titan.univ.run:/worktmp2/RegCM_DATA/Modeling/EIN15/output_${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng/$name.all.nc $target/${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_bats_zeng/
		fi
	done
fi
#=================================================== 
					iconv90908=0

					dirout90908=output_${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng
					echo $dirout90908
					domname90908=$dir

#=================================================== 
					case $rad in 
						RRTM) rrtm90908=1 ;;
						CCM) rrtm90908=0 ;;
					esac    # --- end of case ---

					case $conv in 
						GE) icup_lnd90908=2;icup_ocn90908=4 ;;
						EE) icup_lnd90908=4;icup_ocn90908=4 ;;
						GG) icup_lnd90908=2;icup_ocn90908=2 ;;
						EG) icup_lnd90908=4;icup_ocn90908=2 ;;
						TT) icup_lnd90908=5;icup_ocn90908=5;iconv90908=4;;
					esac    # --- end of case ---

					case $moisture in 
						SUBEX) ipptls90908=1 ;;
						Micro) ipptls90908=2 ;;
					esac    # --- end of case ---

					case $pbl in 
						Holtslag) ibltyp90908=1 ;;
						UW) ibltyp90908=2 ;;
					esac    # --- end of case ---

				
					if [ $(( $ipptls90908 + $ibltyp90908 )) -eq 4 ]; then ((i++)); continue;fi

#=================================================== 
					idiag90908=0

					gdate190908=2001010100
					gdate290908=2006010100

					ifrest90908='true'

					mdate090908=$gdate190908
					mdate190908=2005010100
					mdate290908=2006010100
#=================================================== 
					
				if [ "$pbs" = "1" ]; then
					color -n 7 3 $i;	echo ${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng_2001-2005.in
					cat  standard.in | awk '{gsub(/rrtm90908/,"'$rrtm90908'");\
						gsub(/icup_lnd90908/,"'$icup_lnd90908'");gsub(/icup_ocn90908/,"'$icup_ocn90908'");\
						gsub(/ipptls90908/,"'$ipptls90908'");\
						gsub(/ibltyp90908/,"'$ibltyp90908'");\
						gsub(/gdate190908/,"'$gdate190908'");\
						gsub(/gdate290908/,"'$gdate290908'");\
						gsub(/ifrest90908/,"'$ifrest90908'");\
						gsub(/iconv90908/,"'$iconv90908'");\
						gsub(/mdate090908/,"'$mdate090908'");\
						gsub(/mdate190908/,"'$mdate190908'");\
						gsub(/mdate290908/,"'$mdate290908'");\
						gsub(/idiag90908/,"'$idiag90908'");\
						gsub(/domname90908/,"'$domname90908'");\
						gsub(/dirout90908/,"'$dirout90908'");print}' > ${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng_2001-2005.in
					fi

#=================================================== generate the pbs file
				if [ "$pbs" = "1" ]; then
						pbs.sh ${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng_2001-2005.in ein15.$rad.$i
						pbs_pprcm.sh $dirout90908 pprcm.$rad.$i
						pbs_release.sh $dirout90908 release.$rad.$i
				fi

#=================================================== submit the jobs
				if [ "$submit" = "1" ]; then
						namelist=${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng_2001-2005.in

						if [ "$i" = "1" ];then
						echo	qsub $namelist.pbs
							qsub $namelist.pbs
							sleep 10
							if [ "$monmean" = "1" ]; then
								pbsid=$(qstat | grep ein15.$rad | tail -n 1 | awk '{print $1}')
								qsub -W depend=afterany:$pbsid $namelist.pprcm.pbs
								sleep 10
							fi
							if [ "$delete" = "1" ]; then
								pbsid=$(qstat | grep pprcm.$rad | tail -n 1 | awk '{print $1}')
								qsub -W depend=afterok:$pbsid $namelist.release.pbs
								sleep 10
							fi
						else

							pbsid=$(qstat | grep ein15.$rad | tail -n 1 | awk '{print $1}')
							echo id=$pbsid
							qsub -W depend=afterany:$pbsid $namelist.pbs

							if [ "$monmean" = "1" ]; then
								sleep 10
								pbsid=$(qstat | grep ein15.$rad | tail -n 1 | awk '{print $1}')
								qsub -W depend=afterany:$pbsid $namelist.pprcm.pbs
							fi
							if [ "$delete" = "1" ]; then
								pbsid=$(qstat | grep pprcm.$rad | tail -n 1 | awk '{print $1}')
								qsub -W depend=afterok:$pbsid $namelist.release.pbs
								sleep 10
							fi
						fi

						sleep 10
						if [ "$i" = "20" ];then 
							qstat 
						fi
					fi
#=================================================== submit the jobs : end
					((i++))
				done
			done
		done
	done
done
