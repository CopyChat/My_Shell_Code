#!/bin/bash - 
#===============================================================================
#
#          FILE: pprcm.sh
# 
         USAGE=" ./pprcm.sh [OPTION...] [+ RegCM outpur directory]"
# 
#   DESCRIPTION: do Post-Processing RegCM calculation &
# 				plot of the netCDF outcome data
# 
#       OPTIONS: ---  default: corrent directory
#       		 ---  -p, plot with GrADS ONLY 
#       		 ---  -c, ONLY calculate the partial relation coefficients
#       		 ---  -s, ONLY select the target variables
#       		 ---  -m, use the monthly mean data
#       		 ---  -e, use EIN data
#       		 ---  -x, EIN data vs OBS data
#       		 ---  -t, to test the code ONLY
#       		 ---  -o, ONLY calculate the ocean
#       		 ---  -l, ONLY calculate the land
#
#  REQUIREMENTS: ---  cdo, awk, grads, gradsmap2, gradsbias2,
# 					  stdmap.gs, stdbiasmap.gs color.gs,cbarn.gs
# 					  GrADSNcPrepare in RegCM-4.3.5.6/bin
# 					  there is a tar file in ~/backup/pprcm.tar
# 					  mask.sh
#          BUGS: ---  no ncpdq command, leave the ofile unpacked
#       		 ---  -x, cannot plot, ein15 refuse sdfopen 
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
varlist=("cl" "mask,pr,prmax,tas")
#:TODO:03/13/2014 08:32:58 AM RET:Tang: make sure no varibles with the same name
outname=("rad" "sts") 			# output file name: $prefix.$outname.out.nc
plotvars=("pr" "tas")  			# the variables to be ploted
sta_vars=( "pr" "tas" ) 		# variables to be analyzed
OBS_DATA=/Users/tang/climate/GLOBALDATA/OBSDATA/
EIN_DATA=/Users/tang/climate/GLOBALDATA/5yrMean/
MASK=/Users/tang/Shell/netCDF
############################################################
#
plot=0;cal=0;select=0;monthly=0;ein=0;cross=0;land=0;ocean=0
#=================================================== 
while getopts ":pcsmxetlo" opt; do
	case $opt in 
		p) plot=1 ;;
		c) cal=1 ;;
		s) select=1 ;;
		m) monthly=1 ;;
		e) ein=1 ;;
		x) cross=1 ;;
		l) land=1 ; mask=land ;;
		o) ocean=1 ; mask=ocean ;;
		t) Test=1 ;;
		\?) echo $USAGE && exit 1
	esac
done
shift $(($OPTIND - 1))
if [ $(( $plot + $cal + $select )) -eq 0 ]; then plot=1;cal=1;select=1; fi
if [ $ocean -eq 1 ]; then mask=ocean; fi
if [ $cross -eq 1 ]; then ein=0; fi
echo "___________________________________________________________________"
echo plot=$plot cal=$cal select=$select monthly=$monthly ein=$ein cross=$cross mask=$mask
echo "~------------------------------------------------------------------"
#=================================================== 
Dir=${1:-.} 						 # default dir

if ! [ -e "$Dir" ] ; then
	echo $USAGE; echo "$Dir doesn't exist" ; exit 1
elif ! [ -d "$Dir" ]; then 
	echo $USAGE; echo "While, $Dir isn't a directory"; exit 1
else 
	cd $Dir; DefaultDir=$(pwd)
	#================================= default output file name
	#dir=${DefaultDir##/*/}  # :TODO:03/13/2014 08:21:33 AM RET:Tang: 
	#Dir=${DefaultDir:0:$(( ${#DefaultDir} - 7))}
	dir=$(echo $DefaultDir | awk -F "/" '{print $(NF-1)}')
	prefix=${88:-$dir}  # :TODO:03/13/2014 09:15:38 AM RET:Tang: default
	echo output file :  $prefix.*.out.nc
	echo "################################################"
	sleep 1
fi
#=================================================== 
vsize1=${varlist[@]//,/ }  		# duplicate varnames
vsize2=$(tr ' ' '\n' <<< "${varlist[@]//,/ }" | sort -u | tr '\n' ' ')
#echo  ${#vsize2} vs ${#vsize1}
if [ ${#vsize2} -lt ${#vsize1} ]; then
	echo "Attentiont: At least two vars have the same names!"
	echo "One variable name would be changed, Continue? (Yes/n)?"
	read answer
	if [ $answer = "Yes" ]; then : else exit 1; fi
fi
#===================================================
#declare -A b 		# using associative array	
#for i in ${var[@]}; do 
	#echo $i	
	#echo b=${b[$i]}
	#b[$i]=1;
	#echo b==${b[$i]}
#done
#echo ${!b[@]}



if [ "$Test" = "1" ]; then echo "-t for TEST!"; exit 1; fi
####################################
### select the variables
####################################
if [ $select -eq 1 ]; then

	#================================= test the directory
	if [ $(ls *S*.????????00.nc 2>&- | wc -l) -lt 1 ];then
		echo "SORRY, NO RegCM output file in $DefaultDir"
		echo $USAGE; exit 1
	fi
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
	if [ $nof -lt 1 ];then ((i++));continue; fi
	for file in $(ls *$name.????????00.nc 2>&- )
	do
		echo "================" $file
		cdo -b 64 selvar,${varlist[$i]} $file ${outname[$i]}.$file.temp 2>&-
	done
	cdo -b 64 mergetime ${outname[$i]}*$name*.temp ${outname[$i]}.all.nc
	cdo -b 64 -r ymonmean ${outname[$i]}.all.nc ${outname[$i]}.all.nc.temp

	#ncpdq ${outname[$i]}.all.nc.temp $prefix.${outname[$i]}.out.nc 2>&-
	if [ $(ls $prefix.${outname[$i]}.out.nc 2>&- | wc -l ) -lt 1 ];then  # maybe no ncpdq command
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
### 	calculate MEAN, COR, BIAS, RMSE     
#############################################
if [ $cal -eq 1 ]; then
echo plot=$plot cal=$cal select=$select monthly=$monthly ein=$ein cross=$cross mask=$mask
	cd $DefaultDir
 # :TODO:03/10/2014 22:50:01 RET:Tang: 
	tarfile=$prefix.out.temp.nc
	if [ $(ls $prefix.*.out.nc | wc -l ) -lt 2 ]; then 
		cp $(ls $prefix.*.out.nc) $tarfile
		echo "cp $(ls $prefix.*.out.nc) $tarfile"
		#if [ -n $? ]; then echo " no file required " ; exit 1; fi
 # :TODO:03/13/2014 08:26:37 AM RET:Tang: deal with this error return.
	else
		cdo -b 64 merge $prefix.*out.nc $tarfile
 # :TODO:03/13/2014 08:32:58 AM RET:Tang: make sure no varibles with the same name
	fi
#=================================================== set the data to be used
	if [ $monthly -eq 1 ]; then
		if [ $cross -eq 1 ]; then 
			rm $tarfile 2>&-
			cdo -b 64 merge $EIN_DATA/precip.ymonmean.ein15.nc $EIN_DATA/air.ymonmean.ein15.nc $tarfile
		fi
		if [ $ein -eq 1 ]; then
			obs=( "precip.ymonmean.ein15.nc" "air.ymonmean.ein15.nc" )
		else
			obs=( "precip.ymon.mean.nc" "air.ymon.mean.nc" )
		fi
	else
		if [ $cross -eq 1 ]; then 
			rm $tarfile 2>&-
			cdo -b 64 merge $EIN_DATA/precip.5ymean.ein15.nc $EIN_DATA/air.5ymean.ein15.nc $tarfile
		fi
		if [ $ein -eq 1 ]; then
			obs=( "precip.5ymean.ein15.nc" "air.5ymean.ein15.nc" )
		else
			obs=( "precip.5ymean.nc" "air.5ymean.nc" )
		fi
	fi
	echo  data2 = ${obs[*]}
	echo "00000000000000000000000000000000000000000000000000"
#=================================================== 
	j=0
	while [ $j -lt ${#sta_vars[*]} ]
	do
		if [ $ein -eq 1 ]; then
			cp $EIN_DATA${obs[$j]} $DefaultDir 2>&-
		else
			cp $OBS_DATA${obs[$j]} $DefaultDir 2>&-
		fi
#=================================================== remapping to tarfile
		cdo -s -b 64 genbil,$tarfile ${obs[$j]} weights.nc 
		cdo -s -b 64 remap,$tarfile,weights.nc ${obs[$j]} ${obs[$j]}.obs.temp.nc; rm weights.nc 2>&-
#=================================================== mask the land
		if [ "$mask" != "0" ]; then
			if [ $cross = "1" ] ; then 
				echo "there is no data in the ocean of EIN."
				exit 1
			fi
			echo $mask
			overwrite.sh "cdo -b 64 div $tarfile $MASK/$mask.nc" $tarfile
			overwrite.sh "cdo -b 64 div ${obs[$j]}.obs.temp.nc $MASK/$mask.nc " ${obs[$j]}.obs.temp.nc
			
		fi
#=================================================== select variables
		echo "cdo -s selvar,${sta_vars[$j]} $tarfile ${sta_vars[$j]}.out.temp.nc"
		cdo -s selvar,${sta_vars[$j]} $tarfile ${sta_vars[$j]}.out.temp.nc
#=================================================== monthly mean
	if [ $monthly -eq 0 ]; then
		cdo -s -b 64 timmean ${sta_vars[$j]}.out.temp.nc ${sta_vars[$j]}.out.1.temp.nc
		echo "???????????"
		mv ${sta_vars[$j]}.out.1.temp.nc ${sta_vars[$j]}.out.temp.nc
	fi
	
#=================================================== change units
# if tarfile is Regcm output precip, then kg m-2.s-1 -->  mm/day
		if [ ${sta_vars[$j]} = "pr" ] && [ $cross -eq 0 ]; then 
			cdo -b 64 mulc,86400 ${sta_vars[$j]}.out.temp.nc ${sta_vars[$j]}.out.temp.temp.nc 2>&-
			echo "# units : kg m-2.s-1 -->  mm/day"
			mv ${sta_vars[$j]}.out.temp.temp.nc ${sta_vars[$j]}.out.temp.nc
		fi
#==================================================== calculate
		echo "=============================================================================================="
		echo "correlation" ${sta_vars[$j]} ":"
		#echo "cdo -s -b 64 fldcor ${obs[$j]}.obs.temp.nc ${sta_vars[$j]}.out.temp.nc ${sta_vars[$j]}.cor.nc"
		cdo -s -b 64 fldcor ${obs[$j]}.obs.temp.nc ${sta_vars[$j]}.out.temp.nc ${sta_vars[$j]}.cor.nc 2>&-
		cdo -s infov ${sta_vars[$j]}.cor.nc  
		echo "______________________________________________________________________________________________"
		echo "mean" ${sta_vars[$j]} ":"
		cdo -s -b 64 fldmean ${sta_vars[$j]}.out.temp.nc ${sta_vars[$j]}.fldmean.nc 2>&-
		cdo -s infov ${sta_vars[$j]}.fldmean.nc 
		echo "______________________________________________________________________________________________"
		echo "obs mean" ${sta_vars[$j]}":" 
		cdo -s -b 64 fldmean ${obs[$j]}.obs.temp.nc ${obs[$j]}.fldmean.nc 2>&-
		cdo -s infov ${obs[$j]}.fldmean.nc 
		echo "______________________________________________________________________________________________"
		echo "bias mean" ${sta_vars[$j]}[ model-obs]":"
		cdo -b 64 sub ${sta_vars[$j]}.fldmean.nc ${obs[$j]}.fldmean.nc mean.bias.${sta_vars[$j]}.temp.nc 2>&-
		cdo -s infov mean.bias.${sta_vars[$j]}.temp.nc 
		echo "______________________________________________________________________________________________"
		echo "RMSE ${sta_vars[$j]} [ model vs obs ]:"
		cdo -b 64 -s sub ${sta_vars[$j]}.out.temp.nc ${obs[$j]}.obs.temp.nc bias.${sta_vars[$j]}.temp.nc 2>&-
		cdo -b 64 -s sqr bias.${sta_vars[$j]}.temp.nc sqr.${sta_vars[$j]}.temp.nc 2>&-
		cdo -b 64 -s fldmean sqr.${sta_vars[$j]}.temp.nc fld.sqr.${sta_vars[$j]}.temp.nc 2>&-
		cdo -b 64 -s sqrt fld.sqr.${sta_vars[$j]}.temp.nc rmse.${sta_vars[$j]}.temp.nc 2>&-
		cdo -s infov rmse.${sta_vars[$j]}.temp.nc
		echo "=============================================================================================="
		echo "=============================================================================================="
#=================================================== plot the bias for tas
		if [ ${sta_vars[$j]} = "tas" ];then
			if [ $ein -eq 1 ]; then
				echo "gradsbias3 ${sta_vars[$j]} tas ${sta_vars[$j]}.out.temp.nc ${obs[$j]} "
				gradsbias3 ${sta_vars[$j]} tas ${sta_vars[$j]}.out.temp.nc ${obs[$j]} 
			else
				echo "gradsbias3 ${sta_vars[$j]} air ${sta_vars[$j]}.out.temp.nc ${obs[$j]} "
				gradsbias3 ${sta_vars[$j]} air ${sta_vars[$j]}.out.temp.nc ${obs[$j]} 
			fi
		fi
#=================================================== plot the bias for pr
		if [ ${sta_vars[$j]} = "pr" ];then
			if [ $ein -eq 1 ]; then
				echo "gradsbias3 ${sta_vars[$j]} pr ${sta_vars[$j]}.out.temp.nc ${obs[$j]} "
				gradsbias3 ${sta_vars[$j]} pr ${sta_vars[$j]}.out.temp.nc ${obs[$j]} 
			else
			echo "	gradsbias3 ${sta_vars[$j]} precip ${sta_vars[$j]}.out.temp.nc ${obs[$j]} "
				gradsbias3 ${sta_vars[$j]} precip ${sta_vars[$j]}.out.temp.nc ${obs[$j]} 
			fi
			cp ${sta_vars[$j]}.out.temp.nc  pr.out.nc
		fi
#=================================================== clean up
		rm ${obs[$j]} 2>&-
		((j++))
	done
	exit
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
