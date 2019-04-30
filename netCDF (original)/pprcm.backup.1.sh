#!/bin/bash - 
#===============================================================================
#
#          FILE: pprcm.sh
# 
         USAGE=" ./pprcm.sh [OPTION...] [+ RegCM outpur directory] [+ prefix]"
# 
#   DESCRIPTION: do Post-Processing RegCM calculation &
# 				plot of the netCDF outcome data
# 
#       OPTIONS: ---  default: corrent directory
#       		 ---  -p, plot with GrADS ONLY 
#       		 ---  -c, ONLY calculate the partial relation coefficients
#       		 ---  -s, ONLY select the target variables
#       		 ---  -m, use the monthly mean data
#       		 ---  -m, use EIN data
#
#  REQUIREMENTS: ---  cdo, awk, grads, gradsmap2, gradsbias2,
# 					  stdmap.gs, stdbiasmap.gs color.gs,cbarn.gs
# 					  GrADSNcPrepare in RegCM-4.3.5.6/bin
# 					  there is a tar file in ~/backup/pprcm.tar
#          BUGS: ---  no ncpdq command, leave the ofile unpacked
#        USAGES: ---  1,put the requirements in the right directory
#          		 ---  2,modify gradsmap & gradsbias, see themselves
# 		         ---  3,modify this file as required 
#       		 ---  4,I CLOSED the Warning about Inconsistent variable
# 					  definition for xlat and xlon.
# 		         ---  5,make sure parameters in this file compatible 
# 					  with echo other 
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 02/15/2014 09:52:53 RET
#      REVISION:  ---
#===============================================================================
#set -o nounset                              # Treat unset variables as an error

# Define the variable to be select, calculate & plot
############################################################
namelist=("RAD" "STS") 			# DO NOT change the order !!
varlist=("cl" "pr,prmax,tas")
outname=("rad" "sts") 			# output file name: $prefix.$outname.out.nc
plotvars=("pr" "tas")  			# the variables to be ploted
sta_vars=( "pr" "tas" ) 		# variables to be analyzed
OBS_DATA=/Users/tang/climate/GLOBALDATA/OBSDATA/
EIN_DATA=/Users/tang/climate/GLOBALDATA/5yrMean/
############################################################
#
# deal with the command line
plot=0;cal=0;select=0;monthly=0;ein=0 
#=================================================== 
while getopts ":pcsme" opt; do
	case $opt in 
		p) plot=1 ;;
		c) cal=1 ;;
		s) select=1 ;;
		m) monthly=1 ;;
		e) ein=1 ;;
		\?) echo $USAGE && exit 1
	esac
done
shift $(($OPTIND - 1))
if [ $(($OPTIND)) -eq 1 ]; then	plot=1;cal=1;select=1; fi
#=================================================== 
Dir=${1:-.} 						 # default dir

if ! [ -e "$Dir" ] ; then
	echo $USAGE; echo "$Dir doesn't exist" ; exit 1
elif ! [ -d "$Dir" ]; then 
	echo $USAGE; echo "While, $Dir isn't a directory"; exit 1
else 
	cd $Dir; DefaultDir=$(pwd)
	#================================= default output file name
	#dir=${DefaultDir##/*/}
	#Dir=${DefaultDir:0:$(( ${#DefaultDir} - 7))}
	dir=$(echo $DefaultDir | awk -F "/" '{print $(NF-1)}')
	prefix=${2:-$dir}
	echo out put file name:  $prefix.*.out.nc
	echo "######################################################"
	#sleep 3
fi
####################################
### select the variables
####################################
if [ $select -eq 1 ]; then

	#================================= test the directory
	if [ $(ls *S*.????????00.nc 2>&- | wc -l) -lt 1 ];then
		echo "SORRY, NO RegCM output file in $DefaultDir"
		echo $USAGE; exit 1
	fi

tarfile=$OBS_DATA/$prefix.out.temp.nc
#=================================================== clean up
rm $prefix.*.out.nc *.all.nc *.nc.temp 2>&-
#=================================================== 
i=0
while [ $i -lt ${#namelist[*]} ]
do
	name=${namelist[$i]}; nof=$(ls *$name.????????00.nc 2>&- | wc -l)
	echo "----------------------------------"
	echo " there are $nof $name files"
	echo "----------------------------------"
	for file in $(ls *$name.????????00.nc 2>&- )
	do
		if [ $nof -lt 1 ];then
			break; echo " there is NO $name file"
		else
			echo "================" $file
			cdo -b 64 selvar,${varlist[$i]} $file ${outname[$i]}.$file.temp 2>&-
		fi
	done
	cdo -b 64 mergetime ${outname[$i]}*$name*.temp ${outname[$i]}.all.nc
	cdo -b 64 -r ymonmean ${outname[$i]}.all.nc ${outname[$i]}.all.nc.temp

	ncpdq ${outname[$i]}.all.nc.temp $prefix.${outname[$i]}.out.nc
	if [ -e "$prefix.${outname[$i]}.out.nc" ];then  # maybe no ncpdq command
		cp ${outname[$i]}.all.nc.temp $prefix.${outname[$i]}.out.nc 
#echo " can not run ncpdq, so NO add_offset, NO missing_value"
		echo "leave the outpuf file unpacked..."
	fi
	if [ ${namelist[$i]} = "STS" ]; then stsname=${outname[$i]}; fi
	GrADSNcPrepare $prefix.${outname[$i]}.out.nc 2>&-
	rm *.temp* 2>&- 
	((i++))
done
#=================================================== clean
rm *.all.nc *.nc.temp 2>&-
echo "========== DONE ============"
ls -lh $prefix.*out.nc
fi

#############################################
### 	calculate MEAN, COR,      
#############################################
if [ $cal -eq 1 ]; then
 # :TODO:03/10/2014 22:50:01 RET:Tang: 
	tarfile=$prefix.out.temp.nc
	if [ $(ls $prefix.*.out.nc | wc -l ) -lt 2 ]; then 
		:
	else
		cdo merge $prefix.*out.nc $tarfile
	fi
#=================================================== 
	if [ $monthly -eq 1 ]; then
		if [ $ein -eq 1 ]; then
			#obs=( "$EIN_DATA/precip.ymonmean.ein15.nc" "$EIN_DATA/air.ymonmean.ein15.nc" )
			obs=( "precip.ymonmean.ein15.nc" "air.ymonmean.ein15.nc" )
		else
			obs=( "precip.ymon.mean.nc" "air.ymon.mean.nc" )
		fi
	else
		if [ $ein -eq 1 ]; then
			obs=( "precip.5ymean.ein15.nc" "air.5ymean.ein15.nc" )
		else
			obs=( "precip.5ymean.nc" "air.5ymean.nc" )
		fi
	fi
#=================================================== 
	j=0
	while [ $j -lt ${#sta_vars[*]} ]
	do
		cp $EIN_DATA${obs[$j]} $DefaultDir
		cp $OBS_DATA${obs[$j]} $DefaultDir
#=================================================== remapping OBS
		cdo -s -b 64 genbil,$tarfile ${obs[$j]} weights.nc 
		cdo -s -b 64 remap,$tarfile,weights.nc ${obs[$j]} ${obs[$j]}.obs.temp.nc; rm weights.nc 2>&-
		cdo -s selvar,${sta_vars[$j]} $tarfile ${sta_vars[$j]}.out.temp.nc
#=================================================== monthly mean
	if [ $monthly -eq 0 ]; then
		cdo -s -b 64 yearmean ${sta_vars[$j]}.out.temp.nc ${sta_vars[$j]}.out.1.temp.nc
		mv ${sta_vars[$j]}.out.1.temp.nc ${sta_vars[$j]}.out.temp.nc
	fi
#=================================================== change units
		if [ ${sta_vars[$j]} = "pr" ]; then # kg m-2.s-1 -->  mm/day
			cdo -b 64 mulc,86400 ${sta_vars[$j]}.out.temp.nc ${sta_vars[$j]}.out.temp.temp.nc
			mv ${sta_vars[$j]}.out.temp.temp.nc ${sta_vars[$j]}.out.temp.nc
		fi
#==================================================== calculate
		echo "========== correlation" ${sta_vars[$j]} "=========="
		cdo -s -b 64 fldcor ${obs[$j]}.obs.temp.nc ${sta_vars[$j]}.out.temp.nc ${sta_vars[$j]}.cor.nc
		cdo -s infov ${sta_vars[$j]}.cor.nc && rm ${sta_vars[$j]}.cor.nc
#----------------------------------------------------
		echo "========== mean" ${sta_vars[$j]} "=========="
		cdo -s -b 64 fldmean ${sta_vars[$j]}.out.temp.nc ${sta_vars[$j]}.fldmean.nc 
		cdo -s infov ${sta_vars[$j]}.fldmean.nc 
#--------------------------------------------------- 
		echo "========== obs mean" ${sta_vars[$j]} "=========="
		cdo -s -b 64 fldmean ${obs[$j]}.obs.temp.nc ${obs[$j]}.fldmean.nc 
		cdo -s infov ${obs[$j]}.fldmean.nc 
#--------------------------------------------------- 
		echo "========== bias mean" ${sta_vars[$j]}[ model-obs]"=========="
		cdo -b 64 sub ${sta_vars[$j]}.fldmean.nc ${obs[$j]}.fldmean.nc bias.${sta_vars[$j]}.temp.nc
		cdo -s infov bias.${sta_vars[$j]}.temp.nc && rm bias.${sta_vars[$j]}.temp.nc
#=================================================== plot
	#echo "	gradsbias3 ${sta_vars[$j]} ${sta_vars[$j]}.out.temp.nc ${obs[$j]}  "
	#gradsbias3 ${sta_vars[$j]} ${sta_vars[$j]}.out.temp.nc ${obs[$j]} 
	#mv bias.${sta_vars[$j]}.eps $DefaultDir
#=================================================== clean up
		((j++))
	done
	rm *.ctl *.temp.*nc *.fldmean.nc *.cor.nc $prefix.*.temp.nc 2>&-
fi
####################################
####  PLOT with GrADS
####################################
if [ $plot -eq 1 ]; then
	cd $DefaultDir
	k=1
	while [ $k -lt 13 ]
	do
		for var in ${plotvars[*]}
		do
			gradsmap2 $var $prefix.$stsname.out.nc $k
			gradsbias2 $var $prefix.$stsname.out.nc $k
		done
		((k++))
	done
	echo "======== Post-Processing RegCM Done ========"
	echo " output:"
	ls $prefix.*.out.nc map.*.eps bias.*.eps
	echo "============================================"
fi
