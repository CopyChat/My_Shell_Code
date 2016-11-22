#!/bin/bash - 
#===============================================================================
#
#          FILE: pprcm.sh
# 
#         USAGE: ./pprcm.sh + RegCM outpur directory [ + out prefix ]
# 
#   DESCRIPTION: do Post-Processing RegCM calculation &
# 				plot of the netCDF outcome data
# 
#       OPTIONS: ---  the output directory
#  REQUIREMENTS: ---  cdo2, awk, grads, gradsmap2, gradsbias2,
# 					  stdmap.gs, stdbiasmap.gs color.gs
# 					  GrADSNcPrepare in RegCM-4.3.5.6/?
# 					  there is a tar file in ~/backup/pprcm.tar
#          BUGS: ---  no ncpdq command, leave the ofile unpacked
#        USAGES: ---  1,put the requirements in the right places. 
#          		 ---  2,modify gradsmap & gradsbias, see themselves
# 		         ---  3,modify this file as require 
#       		 ---  4,I CLOSED the Warning about Inconsistent variable
# 					  definition for xlat and xlon.
# 		         ---  5,make sure parameters in this file compatible 
# 					  with echo other 
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 02/13/2014 09:52:53 RET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# define the parameters
####################################################
#namelist=("RAD" "STS") # DO NOT change the order !!
#varlist=("dswssr,dswssrd,dlwssr,dlwssrd,cl,clt" "pr,prmax,tas,tasmin,tasmax")
namelist=("STS") # DO NOT change the order !!
varlist=("pr,prmax,tas,tasmin,tasmax")
outname=("sts") # output file name: $prefix.$outname.out.nc
stsname=sts # get the name for ploting
plotvars=("pr" "tas")  # the variables to be ploted
#OBS_DATA=/Users/tang/solar_energy/GLOBALDATA/OBSDATA
OBS_DATA=/worktmp/users/bmorel/RegCM_DATA/OBSDATA
#=================================================== 
obs=( "$OBS_DATA/precip.5ymean.nc" "$OBS_DATA/air.5ymean.nc" )
sta_vars=( "pr" "tas" ) # variables to be analyzed
####################################################
#
#
# deal with the command line
#=================================================== 
if [ $# -lt 1 ]; then
	echo "Useage: pprcm + RegCM output directory + [prefix of output file]"
	exit
else
	if [ $# -eq 1 ]; then
		cd $1
		DefaultDir=$(pwd)
		#================================= test the directory
		if [ $(ls *S*.????????00.nc 2>&- | wc -l) -lt 1 ];then
			echo "------------------------"
			echo "SORRY, NO RegCM output file in this directory."
			exit
		fi
		#================================= default output file name
		echo "------------------------"
		echo "Default outputfile name: 'RegCM-working-directory'.*.out.nc"
		dir=$(pwd | awk -F '/' '{print $(NF-1)}')
		prefix=$dir
		echo out put file name:  $prefix.*.out.nc
		echo "######################################"
		#sleep 4

	else
		cd $1
		DefaultDir=$(pwd)
		prefix=$2
		echo "Default outputfile name prefix:" $2
	fi
fi
tarfile=$OBS_DATA/$prefix.out.temp.nc
#=================================================== clean up
rm $prefix.*.out.nc *.all.nc *.nc.temp 2>&-
#=================================================== 

i=0
while [ $i -lt ${#namelist[*]} ]
do
	name=${namelist[$i]}
	nof=$(ls *$name.????????00.nc 2>&- | wc -l)
	echo "----------------------------------"
	echo " there are $nof $name files"
	echo "----------------------------------"
	for file in $(ls *$name.????????00.nc 2>&- )
	do
		if [ $nof -lt 1 ];then
			break
			echo " there is NO $name file"
		else
			echo "================" $file
			echo "cdo2 -b 64 selvar,${varlist[$i]} $file ${outname[$i]}.$file.temp"
			cdo2 -b 64 selvar,${varlist[$i]} $file ${outname[$i]}.$file.temp 2>&-
		fi
	done
	echo "cdo2 -b 64 mergetime ${outname[$i]}*$name*.temp ${outname[$i]}.all.nc"
	cdo2 -b 64 mergetime ${outname[$i]}*$name*.temp ${outname[$i]}.all.nc

	echo "calculate the Multi-year monthly mean ..."
	echo "###########################################"
	sleep 2

	cdo2 -b 64 -r ymonmean ${outname[$i]}.all.nc ${outname[$i]}.all.nc.temp
	echo "# -r means using relative time units"
	echo "cdo2 -b 64 -r ymonmean ${outname[$i]}.all.nc ${outname[$i]}.all.nc.temp"

	echo "ncpdq ${outname[$i]}.all.nc.temp $prefix.${outname[$i]}.out.nc"
	#ncpdq ${outname[$i]}.all.nc.temp $prefix.${outname[$i]}.out.nc


	if [ $(ls $prefix.${outname[$i]}.out.nc 2>&- | wc -l ) -lt 1 ];then  # maybe no ncpdq command
		cp ${outname[$i]}.all.nc.temp $prefix.${outname[$i]}.out.nc 
		#echo " can not run ncpdq, so NO add_offset, NO missing_value"
		echo "leave the outpuf file unpacked..."
	fi
	if [ ${namelist[$i]} = "STS" ]; then # for ploting 
		stsname=${outname[$i]}
	fi
	# for grads to read the output file	
	echo  "	GrADSNcPrepare $prefix.${outname[$i]}.out.nc"
	GrADSNcPrepare $prefix.${outname[$i]}.out.nc
	#ls  $prefix.${outname[$i]}.out.nc*
	rm *.temp* 2>&- 

	((i++))
done
#=================================================== clean
rm *.all.nc *.nc.temp 2>&-

echo "========== DONE ============"
ls -lh $prefix*.out.nc

#=================================================== to plot with python
#~/Python/temp.py model.all.nc 2

#exit
#############################################
### 	calculate MEAN, COR,      
#############################################

tarfile=$OBS_DATA/$prefix.out.temp.nc
cdo2 merge $prefix*.out.nc $tarfile
cd $OBS_DATA
#####################################

echo " change directory..."
j=0
while [ $j -lt ${#sta_vars[*]} ]
do
	#==================================== remapping OBS
	cdo2 -s -b 64 genbil,$tarfile ${obs[$j]} weights.nc 
	cdo2 -s -b 64 remap,$tarfile,weights.nc ${obs[$j]} ${obs[$j]}.obs.temp.nc; rm weights.nc 2>&-
	cdo2 -s selvar,${sta_vars[$j]} $tarfile ${sta_vars[$j]}.out.temp.1.nc
	
	cdo2 -s -b 64 yearmean ${sta_vars[$j]}.out.temp.1.nc ${sta_vars[$j]}.out.temp.nc


	if [ ${sta_vars[$j]} = "pr" ]; then # change units: kgm-2.s-1 to mm/day
		cdo2 -b 64 mulc,86400 ${sta_vars[$j]}.out.temp.nc ${sta_vars[$j]}.out.temp.temp.nc
		mv ${sta_vars[$j]}.out.temp.temp.nc ${sta_vars[$j]}.out.temp.nc

		#ncatted -O -a units,pr,m,c,mm/day ${sta_vars[$j]}.out.temp.nc
		# CAN NOT use this on titan
		#cdo2 -s pardes ${sta_vars[$j]}.out.temp.nc
		#cdo2 -s infov ${sta_vars[$j]}.out.temp.nc 
	fi
#=================================================== 
	echo "========== correlation" ${sta_vars[$j]} "=========="
	cdo2 -s -b 64 fldcor ${obs[$j]}.obs.temp.nc ${sta_vars[$j]}.out.temp.nc ${sta_vars[$j]}.cor.nc
	cdo2 -s infov ${sta_vars[$j]}.cor.nc && rm ${sta_vars[$j]}.cor.nc
	echo "========== mean" ${sta_vars[$j]} "=========="
	cdo2 -s -b 64 fldmean ${sta_vars[$j]}.out.temp.nc ${sta_vars[$j]}.fldmean.nc 
	cdo2 -s infov ${sta_vars[$j]}.fldmean.nc 

	echo "========== obs mean" ${sta_vars[$j]} "=========="
	cdo2 -s -b 64 fldmean ${obs[$j]}.obs.temp.nc ${obs[$j]}.fldmean.nc 
	cdo2 -s infov ${obs[$j]}.fldmean.nc 

	echo "========== bias mean" ${sta_vars[$j]}[ model-obs]"=========="
	cdo2 -b 64 sub ${sta_vars[$j]}.fldmean.nc ${obs[$j]}.fldmean.nc bias.${sta_vars[$j]}.temp.nc
	cdo2 -s infov bias.${sta_vars[$j]}.temp.nc && rm bias.${sta_vars[$j]}.temp.nc

#=================================================== plot
echo "	gradsbias3 ${sta_vars[$j]} ${sta_vars[$j]}.out.temp.nc ${obs[$j]}  "
	gradsbias3 ${sta_vars[$j]} ${sta_vars[$j]}.out.temp.nc ${obs[$j]} 
	mv bias.${sta_vars[$j]}.eps $DefaultDir
#=================================================== clean up

	((j++))
done

rm $prefix* *.ctl *.temp.*nc *.fldmean.nc *.cor.nc 2>&-
rm $prefix.*.temp.nc 2>&-
cd $DefaultDir

exit 1
####################################
####  PLOT with GrADS
####################################

cd $DefaultDir
echo " change directory..."

#======================= deal with the packed netCDF files
#ncpdq -U test.sts.out.nc unpack.nc
#cp test.sts.out.nc back.nc
#mv unpack.nc test.sts.out.nc
#======================= deal with the packed netCDF files
ls *.ctl
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

echo "============================================"
echo "============================================"
echo "============================================"
echo "======== Post-Processing RegCM Done ========"
echo " output:"
echo "--------"
ls $prefix.*.out.nc map.*.eps bias.*.eps


echo "============================================"

exit

#echo " output: $prefix.*.out.nc "
#echo "   plot: map.*.eps "
#echo "   plot: bias.*.eps "
