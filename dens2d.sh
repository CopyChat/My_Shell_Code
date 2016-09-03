#!/bin/bash - 
#===============================================================================
#
#          FILE: dens2d.sh
# 
#         USAGE: ./dens2d.sh 
# 
#   DESCRIPTION: to calculate the 2D density map of input array $1,
# 				 output is $2
# 
#       OPTIONS: ---
#  REQUIREMENTS: --- transpose, 
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 01/02/13 22:58:19 CST
#      REVISION:  ---
#===============================================================================



if [ -z "$1" ]; then
	echo "please input the sourse file"
	exit 1
fi

#=================================================== 

bin1=20
bin2=10

ra_min=193
ra_max=195.5
dec_min=27
dec_max=28.5

out_ra="ra"
out_dec="dec"
#=================================================== 
step1=$(echo "" | awk '{print ('$ra_max'-'$ra_min')/'$bin1'}')
step2=$(echo "" | awk '{print ('$dec_max'-'$dec_min')/'$bin2'}')

#=================================================== out ra & dec
#echo "" | awk '{print '$ra_min';for(i=1;i<='$bin1';i++) {print ('$ra_min'+(i*'$step1'))}}' > $out_ra
#echo "" | awk '{print '$dec_min';for(i=1;i<='$bin2';i++) {print ('$dec_min'+(i*'$step2'))}}' > $out_dec
#===================================================
#echo $step1 $step2
sort -n -k 1 $1 > radecc.temp9745320358
l=$(wc -l radecc | awk '{print $1}')
#echo $l
#====================================================
i=0
while [ $i -lt $bin1 ]
do
	awk '$1>('$ra_min'+'$i'*'$step1') && $1 < ('$ra_min'+('$i'+1)*'$step1')' radecc > ra$i.temp9745320358 
#=================================================== for dec
	j=0
	while [ $j -lt $bin2 ]
	do
		sort -n -k 2 ra$i.temp9745320358 > ra$i.temp97453203581
		awk '$2>('$dec_min'+'$j'*'$step2') && $2 < ('$dec_min'+('$j'+1)*'$step2')' ra$i.temp97453203581 > ra$i.dec$j
	((j++))
	done
	((i++))
done 
#=================================================== for a 2D density map:

i=0
while [ $i -lt $bin1 ]
do
	j=0
	while [ $j -lt $bin2 ]
	do
		wc ra$i.dec$j | awk '{printf "%s ",$1}'  >> 2dmap.temp9745320358

		((j++))
		done
		echo "" | awk '{printf "\n",""}' >> 2dmap.temp9745320358
	((i++))
done 

transpose.sh 2dmap.temp9745320358

rm *.temp9745320358 *.temp97453203581
