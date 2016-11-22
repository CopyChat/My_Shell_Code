#!/bin/bash - 
#===============================================================================
#
#          FILE: varname.sh
# 
#         USAGE: ./varname.sh + RegCM global data directory 
# 
#   DESCRIPTION:  change the names of variables in netCDF files
# 
#       OPTIONS: ---  
#  REQUIREMENTS: ---  cdo, awk, grads, gradsmap2, gradsbias2,
# 					  stdmap.gs, stdbiasmap.gs color.gs,cbarn.gs
# 					  GrADSNcPrepare in RegCM-4.3.5.6/bin
# 					  there is a tar file in ~/backup/pprc.tar
#          BUGS: ---  no ncpdq command, leave the ofile unpacked
#        USAGES: ---  1,put the requirements in the right places. 
#        AUTHOR: Tang (Tang), chao.tang.1@gmail.com
#  ORGANIZATION: le2p
#       CREATED: 02/15/2014 09:52:53 RET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# define the parameters
####################################################
oldvarname=( "var130" "var156" "var157" "var131" "var132" )
newvarname=( "t" "z" "r" "u" "v" ) # Please DONNOT change this line.
										# Default for EINXX

olddimname=( "lon" "lat" "lev" )
newdimname=( "longitude" "latitude" "level" )
#=================================================== 
fperfix=( "air" "hgt" "rhum" "uwnd" "vwnd" ) # Please DONNOT change this line.Again
####################################################
#
oldvarname2=("${olddimname[@]}" "${oldvarname[@]}")
newvarname2=("${newdimname[@]}" "${newvarname[@]}")
#echo ${oldvarname2[*]}
#echo ${newvarname2[*]}

#
# deal with the command line
#=================================================== 
if [ $# -lt 1 ]; then
	echo "Useage: varname + RegCM global data directory ( such as 1986)"
	exit
else
	if [ $# -eq 1 ]; then
		cd $1
		DefaultDir=$(pwd)
		year=$(pwd | awk -F '/' '{print $NF}')
		echo $year
		#================================= test the directory
		if [ $(ls *.????.??.nc 2>&- | wc -l) -lt 1 ];then
			echo "------------------------"
			echo "SORRY, NO EINXX input file in this directory."
			exit
		else
			if [ $(ls *.????.??.nc 2>&- | wc -l) -gt 20 ];then
				echo " too many files in this directory "
				exit
			fi
		fi
	else
		echo "Come on, too much arguments!"
		exit
	fi
fi
#=================================================== 
# check the variable namefor j in 0 1 2
	if [ "${#oldvarname[*]}" -ne 5  ];then
		echo "Please DO NOT change the number of var names.^_^"
		exit
	fi
#=================================================== 
rm temp.001.nc 2>&-

for time in 00 06 12 18
do
	echo "---------------------- timestep: $time"
	
#=================================================== merge
	cdo -b 64 merge *.????.$time.nc temp.001.nc






# ===================change units: Pa to millibars & invert the pressure lev
	echo "================== convert Pa to millibars & invert the pressure lev"
	cp ~/Shell/netCDF/zaxis $DefaultDir
	cdo -b 64 setzaxis,zaxis temp.001.nc temp.002.nc  # :NOTE:02/28/2014 15:17:48 RET:Tang: this line change level to lev
	#cdo -M -r -b 64 invertlev temp.001.nc temp.002.nc 
	#rm temp.002.nc 2>$-
# =========================================change variable names
	echo "================== change variable names "
	changevar=$(echo ${oldvarname2[*]} ${newvarname2[*]} | awk '{ for (i = 1; i <= NF/2; i++) printf "-v .%s,%s ",$i,$(i+NF/2) }')
	changedim=$(echo ${olddimname[*]} ${newdimname[*]} | awk '{ for (i = 1; i <= NF/2; i++) printf "-d .%s,%s ",$i,$(i+NF/2) }')
	ncrename $changedim temp.002.nc
	ncrename $changevar temp.002.nc
	ncatted -O -a _FillValue,,o,f,-32767 temp.002.nc
	cp temp.002.nc temp.001.nc

#=================================================== change the attributes
	echo "============= change the attributes"
	#ncatted -O -a axis,longitude,d,, temp.001.nc
	ncatted -O -a axis,latitude,d,, temp.001.nc
	ncatted -O -a units,t,c,c,"K" temp.001.nc
	ncatted -O -a units,r,c,c,"%" temp.001.nc
	#ncatted -O -a long_name,r,c,c,"Relative humidity" temp.001.nc
	#ncatted -O -a standard_name,r,c,c,"Relative humidity" temp.001.nc
	ncatted -O -a units,u,c,c,"m s**-1" temp.001.nc
	#ncatted -O -a long_name,u,c,c,"U component of wind" temp.001.nc
	#ncatted -O -a standard_name,u,c,c,"eastward_wind" temp.001.nc
	ncatted -O -a units,v,c,c,"m s**-1" temp.001.nc
	#ncatted -O -a long_name,v,c,c,"U component of wind" temp.001.nc
	#ncatted -O -a standard_name,v,c,c,"northward_wind" temp.001.nc
	ncatted -O -a units,z,c,c,"m**2 s**-2" temp.001.nc
	#ncatted -O -a long_name,z,c,c,"Geopotential" temp.001.nc
	#ncatted -O -a standard_name,z,c,c,"Geopotential" temp.001.nc
	#=================================================== select variable
	echo "================== select variable"
	i=0
	while [ $i -lt ${#fperfix[*]} ]
	do
		cdo -M -r -b 64 selvar,${newvarname[$i]} temp.001.nc ${fperfix[$i]}.$year.$time.temp.nc
		ncpdq -O ${fperfix[$i]}.$year.$time.temp.nc ${fperfix[$i]}.$year.$time.nc
		rm ${fperfix[$i]}.$year.$time.temp.nc 
	
	echo "================== del the attributes "
	#ncatted -O -a positive,level,d,, ${fperfix[$i]}.$year.$time.nc
	ncatted -O -a axis,level,d,, ${fperfix[$i]}.$year.$time.nc
	#ncatted -O -a standard_name,level,o,c,pressure_level ${fperfix[$i]}.$year.$time.nc
	ncdump -h ${fperfix[$i]}.$year.$time.nc | head -30


		((i++))
	done
	rm temp.001.nc
done

exit
