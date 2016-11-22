#!/bin/bash - 
#===============================================================================
#
#          FILE: functions.sh
# 
#         USAGE: ./functions.sh 
# 
#   DESCRIPTION: this file contains my bash shell functions ONLY for the sensitivity test
# 				 of RegCM model in 2014-08, 40 configurations,5years,ein15 input data.
# 				 located in the ~/climate/Modeling/EIN15  directory. all the data are backuped 
#  				to my hard disk TOSHIBA
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 03/07/2014 14:30:26 RET
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

#=================================================== for RegCM test




#=================================================== 
# do the same thing in the model directory
function job_in_model
{
	USAGE="job_in_model [ opt ] [ + commands ]"
#=================================================== 
    CMD=0
#=================================================== 
	#modeladdress=/Users/tang/climate/Modeling/EIN15
	modeladdress="/Volumes/PHOTO/Modeling/EIN15"
#=================================================== 
	pdir=$(pwd)
	cd $modeladdress
	i=1
	for dir in EIN15
	do
	    for rad in RRTM CCM
	    do
	        for conv in GE EE GG EG TT 
	        do
	            for moisture in SUBEX Micro
                do
	                for pbl in Holtslag UW
	                do
	                    if [ "$i" -lt 10 ]; then
	                        namelist=0${i}_${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng_2001-2005.in
                            output=0${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng
	                    else
	                        namelist=${i}_${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng_2001-2005.in
	                        output=${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng
	                    fi
	                    runlog=runlog.$namelist

#=================================================== do the job
	                     color -n 7 6 " $i ";color -n 1 7 " do the jobs in directory: "; color 7 1 " $modeladdress/$output"
                        if [ $(($i%4)) = 0 ];then
                            color -n 7 6 " Model:$i "; color 1 7 "$namelist"
                        else
                	        cd $modeladdress/$output
                            if [ "$CMD" = "1" ]; then
                	            eval $@
                	        else
                                echo -n ""
                                for file in $(ls *all*.nc)
                                do
#                                   echo for file $file...
#                                   cdo showtimestamp $file >> timestamp_$i
#here I output the timestamps of the netCDF files,and compare it to the standard 
#timestamps file $timestamp_std
                                    until [ $( diff timestamp_$i ../timestamp_std | wc -l) -eq 0 ];
                                    do
                                        vimdiff timestamp_$i ../timestamp_std
                                    done
                                    color 6 7 " start to shift time ... "
										if [ "$i" -lt 10 ];then
	                                    echo "cdo shifttime,-1month $file 0${i}_${file%.all.*}.mon.mean.${file##*all.}"
   		                                cdo shifttime,-1month $file 0${i}_${file%.all.*}.mon.mean.${file##*all.}
									else
	                                    echo "cdo shifttime,-1month $file ${i}_${file%.all.*}.mon.mean.${file##*all.}"
   		                                cdo shifttime,-1month $file ${i}_${file%.all.*}.mon.mean.${file##*all.}
									fi

                                done
                            fi
                        fi

#=================================================== 
	                    ((i++))
	                done
	            done
            done
	    done
	done
	cd $pdir
}


#=================================================== 
function modelist
{
	i=1
	for dir in EIN15
	do 
        for rad in RRTM CCM 
        do 
            for conv in GE EE GG EG TT 
            do 
                for moisture in SUBEX Micro 
                do 
                    for pbl in Holtslag UW 
                    do 
                        namelist=${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng_2001-2005.in 
                        output=output_${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng 
                        runlog=runlog.$namelist
                        pbs=$namelist.pbs

						if [ "$#" -lt "1" ]; then
							color 2  " +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ "
							color -n 7 5 "$i ";
							color 7 1 $namelist
							color 7 2 $output
							color 7 3 $runlog
							color 2 "============================== tail runlog ============="
							tail $runlog
							color 2 "============================== tail runlog ============="
							color 7 4 $pbs
#							color -n 5 4 "$i "; echo $pbs
							if ( grep "RegCM V4 simulation successfully reached end" $runlog ); then
									if  [ -e $output/EIN15_SAV.2002010100.nc ];then
										color -n 7 3 " $i "; color 7 1 " RegCM: good ! "
									fi
									if ( grep "========== DONE ============" $output/runlog*pprcm* 2>&1 ); then
										color -n 7 3 " $i "; color 7 1 "    pprcm: Good Job !"
									else
										color -n 7 3 " $i "; color 1 7 "    pprcm: Job CRASH!"
									fi
									if  [ $(ls $output/EIN15_RAD.*.nc 2>&-| wc -l ) -lt 5 ];then
										color -n 7 3 " $i "; color 7 1 "    release: Good Job !"
									else
										color -n 7 3 " $i "; color 1 7 "    release: Job CRASH !"

									fi
								fi
						else
							if [ "$i" = "$1" ]; then	
								color -n 7 5 "$i ";
								color 7 1 $namelist
								color 7 2 $output
								color 7 3 $runlog
							color 2 "============================== tail runlog ============="
							tail $runlog
							color 2 "============================== tail runlog ============="
								color 7 4 $pbs
#								color -n 5 4 "$i "; echo $pbs
								if ( grep "RegCM V4 simulation successfully reached end" $runlog ); then
									if  [ -e $output/EIN15_SAV.2002010100.nc ];then
										color -n 7 3 " $i "; color 7 1 " RegCM: good ! "
									fi
									if ( grep "========== DONE ============ 2005" $output/runlog*pprcm* 2>&1 ); then
										color -n 7 3 " $i "; color 7 1 "    pprcm: Good Job !"
									else
										color -n 7 3 " $i "; color 1 7 "    pprcm: Job CRASH!"
									fi
									if  [ $(ls $output/EIN15_RAD.*.nc 2>&-| wc -l ) -lt 5 ];then
										color -n 7 3 " $i "; color 7 1 "    release: Good Job !"
									else
										color -n 7 3 " $i "; color 1 7 "    release: Job CRASH !"
									fi
								fi
							fi
						fi
#=================================================== 
					((i++))
					done
				done
			done
		done
	done
}
#=================================================== 
# check the physics setting handled by mk_in_pbs
function setcheck
{
	ddd=/worktmp2/RegCM_DATA/Modeling/EIN15
	i=1
	for dir in EIN15
	do 
	    for rad in RRTM CCM 
        do 
            for conv in GE EE GG EG TT 
            do 
                for moisture in SUBEX Micro
                do
                    color 1 7 output_${dir}_${rad}_${conv}_${moisture}_BATS_Holtslag_Zeng
                    dirout90908=output_${dir}_${rad}_${conv}_${moisture}_BATS_Holtslag_Zeng 
                    color -n 7 3 " $i ";	color 1 7 ${dir}_${rad}_${conv}_${moisture}_BATS_Holtslag_Zeng:
                    color -n 7 3 " $i ";	color 1 7 ${dir}_${rad}_${conv}_${moisture}_BATS_Holtslag_Zeng_2001-2005.in
                    ncdump -h $ddd/$dirout90908/EIN15_RAD.*.nc | grep rrtm_radiation_scheme_activated
                    ncdump -h $ddd/$dirout90908/EIN15_RAD.*.nc | grep cumulus_convection_scheme
                    ncdump -h $ddd/$dirout90908/EIN15_RAD.*.nc | grep moisture_scheme 
                    ((i++)) 
                done 
            done

        done
	done
}
#=================================================== 
function qdelall
{
	tag=${1:-"ctang"}
	color 7 1 tag=$tag

	i=1
	for pbs in $(qstat | grep $tag | awk '{print $1}')
	do 
        color -n 1 7 "kill job: ";color 7 1 " $pbs "
        qdel $pbs
	done
}


function getvar2
{
    modeldir=/Users/tang/climate/Modeling/EIN15
    cd $modeldir

    k=1
	for dir in $(ls -d */)
	do
        if [ "$k" -lt "20" ]; then
        echo $dir
        echo "sleep 2"
        sleep 2
	    cd $modeldir/$dir
        for rad in $(ls *RAD.mon.mean.200?.nc )
        do
            echo deal with file $rad ...
            echo "cdo selvar,rsns,rsnscl,rsnl,rsnlcl,rts,rtl,rtnlcl,rsnt $rad $rad.var.nc"
            cdo selvar,rsns,rsnscl,rsnl,rsnlcl,rts,rtl,rtnlcl,rsnt $rad $rad.var.nc
        done
        echo "cdo mergetime *RAD.mon.mean.*.var.nc ${rad%%_*}.RAD.mon.mean.allvar.nc"
        cdo mergetime *RAD.mon.mean.*.var.nc ${rad%%_*}.RAD.mon.mean.allvar.nc
        echo "cdo ymonmean ${rad%%_*}.RAD.mon.mean.allvar.nc ${rad%%_*}.RAD.ymon.mean.nc"
        cdo ymonmean ${rad%%_*}.RAD.mon.mean.allvar.nc ${rad%%_*}.RAD.ymon.mean.nc
        rm *var.nc *allvar.nc
        ls *ymon.mean.nc
        
        echo "cdo seltimestep,5,6,7,8,9,10 ${rad%%_*}.RAD.ymon.mean.nc ${rad%%_*}.RAD.ymon.mean.2001-2005.MJJASO.RRTM.nc"
        cdo seltimestep,5,6,7,8,9,10 ${rad%%_*}.RAD.ymon.mean.nc ${rad%%_*}.RAD.ymon.mean.2001-2005.MJJASO.RRTM.nc
        echo "cdo seltimestep,1,2,3,4,11,12 ${rad%%_*}.RAD.ymon.mean.nc ${rad%%_*}.RAD.ymon.mean.2001-2005.NDJFMA.RRTM.nc"
        cdo seltimestep,1,2,3,4,11,12 ${rad%%_*}.RAD.ymon.mean.nc ${rad%%_*}.RAD.ymon.mean.2001-2005.NDJFMA.RRTM.nc
        color 4 7  "===============-================="

        cdo showvar ${rad%%_*}.RAD.ymon.mean.2001-2005.NDJFMA.RRTM.nc
        cdo showtimestamp ${rad%%_*}.RAD.ymon.mean.2001-2005.NDJFMA.RRTM.nc

        cdo showvar ${rad%%_*}.RAD.ymon.mean.2001-2005.MJJASO.RRTM.nc
        cdo showtimestamp ${rad%%_*}.RAD.ymon.mean.2001-2005.MJJASO.RRTM.nc
        color 1 7  "==================="



        for srf in $(ls *SRF.mon.mean.200?.nc )
        do
            echo "cdo selvar,tas,pr $srf $srf.var.nc"
            cdo selvar,tas,pr $srf $srf.var.nc
        done
        echo "cdo mergetime *SRF.mon.mean.*.var.nc ${srf%%_*}.SRF.mon.mean.allvar.nc"
        cdo mergetime *SRF.mon.mean.*.var.nc ${srf%%_*}.SRF.mon.mean.allvar.nc
        echo "cdo ymonmean ${srf%%_*}.SRF.mon.mean.allvar.nc ${srf%%_*}.SRF.ymon.mean.nc"
        cdo ymonmean ${srf%%_*}.SRF.mon.mean.allvar.nc ${srf%%_*}.SRF.ymon.mean.nc
        rm *var.nc *allvar.nc
        ls *ymon.mean.nc

        echo "cdo seltimestep,5,6,7,8,9,10 ${srf%%_*}.SRF.ymon.mean.nc ${srf%%_*}.SRF.ymon.mean.2001-2005.MJJASO.RRTM.nc"
        cdo seltimestep,5,6,7,8,9,10 ${srf%%_*}.SRF.ymon.mean.nc ${srf%%_*}.SRF.ymon.mean.2001-2005.MJJASO.RRTM.nc
        echo "cdo seltimestep,1,2,3,4,11,12 ${srf%%_*}.SRF.ymon.mean.nc ${srf%%_*}.SRF.ymon.mean.2001-2005.NDJFMA.RRTM.nc"
        cdo seltimestep,1,2,3,4,11,12 ${srf%%_*}.SRF.ymon.mean.nc ${srf%%_*}.SRF.ymon.mean.2001-2005.NDJFMA.RRTM.nc

        color 1 7  "===============-================="
        cdo showvar ${srf%%_*}.SRF.ymon.mean.2001-2005.NDJFMA.RRTM.nc
        cdo showtimestamp ${srf%%_*}.SRF.ymon.mean.2001-2005.NDJFMA.RRTM.nc
        echo ""
        
        cdo showvar ${srf%%_*}.SRF.ymon.mean.2001-2005.MJJASO.RRTM.nc
        cdo showtimestamp ${srf%%_*}.SRF.ymon.mean.2001-2005.MJJASO.RRTM.nc

	    cd $modeldir
    fi
        ((k++))
    done
	    
}



#=================================================== 
function getvar
{

	DIR=/Users/tang/Desktop/Tang-Mac-Share/EIN15
    DIR2=/Users/tang/climate/Modeling/EIN15

	i=1
	for dir in EIN15
	do
		for rad in RRTM CCM
		do
			for conv in GE EE GG EG TT 
			do
				for moisture in SUBEX Micro
				do
					for pbl in Holtslag UW
					do
						namelist=${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng_2001-2005.in
						output=${i}_output_${dir}_${rad}_${conv}_${moisture}_${pbl}_BATS_Zeng
						runlog=runlog.$namelist
						pbs=$namelist.pbs
						#mv $DIR/$output/ ${i}_$output

						color 1 7 "---------------------------------------------------$i----------------"
						cd $DIR/$output

#						for file in $(ls ${i}_???.all.200?.nc)
#						do
#							a=$(cdo -r showtimestamp $file | grep "2003-01-01T00:00:00")
#							if [ $(echo $a | awk '{print NF}') = 13 ];then
#								color -n 7 1 "got the file ";color -n 1 7 " $file " ;color -n 1 7 " in model: "; color 7 1 " $i "
#								color 2 5 "eval echo $a"
#								cdo -r seltimestep,2,3,4,5,6,7,8,9,10,11,12,13 $file $file.temp
#								mv $file $file.backup
#								mv $file.temp $file
#								cdo -r shifttime,-1month $file sft.$file
#							fi
#
#							cdo -r shifttime,-1month $file sft.$file
#
#						done
						
						cd $DIR/$output

#=================================================== mon.mean
                            #rm $i.RAD.mon.mean.2001-2005.selvar.nc
                            #rm $i.SRF.mon.mean.2001-2005.selvar.nc
						
							 cdo -r selvar,cl,clw,dswssr,dswssrd,dlwssr,dlwssrd,clt,rsns,rsnscl,rsnl,rsnlcl,rts,rtl,rtnlcl,rsnt $i.RAD.mon.mean.2001-2005.nc $DIR2/$output/$i.RAD.mon.mean.2001-2005.selvar.nc 
							 cdo -r selvar,prc,tas,pr,rsdl,rsds,evspsbl,hfss,aldirs,aldifs $i.SRF.mon.mean.2001-2005.nc $DIR2/$output/$i.SRF.mon.mean.2001-2005.selvar.nc
#=================================================== 
						cd $DIR/$output

		cdo -r ymonmean $DIR2/$output/$i.RAD.mon.mean.2001-2005.selvar.nc $i.RAD.ymon.mean.2001-2005.nc
		cdo -r ymonmean $DIR2/$output/$i.SRF.mon.mean.2001-2005.selvar.nc $i.SRF.ymon.mean.2001-2005.nc

                        #rm $i.RAD.ymon.mean.2001-2005.MJJASO.nc
                        #rm $i.RAD.ymon.mean.2001-2005.NDJFMA.nc
                        #rm $i.SRF.ymon.mean.2001-2005.MJJASO.nc
                        #rm $i.SRF.ymon.mean.2001-2005.NDJFMA.nc

	 for name in RAD SRF
	 do
		 echo "cdo -r seltimestep,5,6,7,8,9,10 $i.$name.ymon.mean.nc ${i}.$name.ymon.mean.2001-2005.MJJASO.nc"
		 echo "cdo -r seltimestep,1,2,3,4,11,12 $i.$name.ymon.mean.nc $i.$name.ymon.mean.2001-2005.NDJFMA.nc"
		 cdo -r seltimestep,5,6,7,8,9,10 $i.$name.ymon.mean.2001-2005.nc $DIR2/$output/${i}.$name.ymon.mean.2001-2005.MJJASO.nc
		 cdo -r seltimestep,1,2,3,4,11,12 $i.$name.ymon.mean.2001-2005.nc $DIR2/$output/$i.$name.ymon.mean.2001-2005.NDJFMA.nc

        rm $i.$name.ymon.mean.2001-2005.nc
	 done

#=================================================== 
						cd $DIR

						((i++))
					done
				done
			done
		done
	done
    
#=================================================== 
    ln -sf $DIR2/*output*/*MJJ*.nc $DIR2/plot_data/
    cd $DIR2/plot_data

    for file in $(ls *.nc)
    do
        GrADSNcPrepare $file
    done

}




