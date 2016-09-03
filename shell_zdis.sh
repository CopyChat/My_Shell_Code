#!/bin/bash - 
#===============================================================================
#
#          FILE: shell_zdis.sh
# 
#         USAGE: ./shell_zdis.sh 
# 
#   DESCRIPTION: to prepare the sample for zdistribution.c 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 12/24/12 16:04:45 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
input1="PairsFinal___1"
input2="PairsFinal___2"
input3="sdss_redshift"

NumRandom=10
Delta=0.02
#Max=$(max.sh 1 $input3 | awk '{print $1}')
Max=0.4
echo $Max
step=$(echo "" | awk '{print '$Max'/'$Delta'}')
echo $step


awk '$84>0{print $84}' $input1 > z1
awk '$84>0{print $84}' $input2 > z2
#wcc z1
cp z2 pairsZ
cat z1 >> pairsZ

l=$(wc -l pairsZ | awk '{print $1}')
echo $l
#===============================================================================
rm zdis*.temp
rm zhis*.temp dr6_zdis
i=0
while [ $i -lt $NumRandom ]
do
#	echo $i,$l,$input3
	chose_randomly.sh $l $input3 > zdis$i.temp

#=================================================== for histo
	j=0
	while [ $j -lt $step ]
	do
#		echo $j $Delta
		awk '$1>('$j'*'$Delta') && $1 < (('$j'+1)*'$Delta')' zdis$i.temp | wc -l >> zhis$i.temp 
#		tail -10 zhis$i.temp
		((j++))
	done

#=================================================== 
	((i++))
done 
paste -d " " zhis*.temp > 1000chose.temp

#=================================================== for dev
awk '{sum=0;for(i=1;i<=NF;i++) sum=sum+$i; $(NF+1)=sum/'$NumRandom';print}' 1000chose.temp > zdis7878_temp
awk '{sum=0;for(i=1;i<NF;i++) sum=sum+($i-$NF)*($i-$NF); $(NF+1)=sqrt(sum/'$NumRandom');print}' zdis7878_temp > dr6_zdis.temp8787
awk '{print $(NF-1),$NF}' dr6_zdis.temp8787 > dr6_zdis


#=================================================== histo for real distribution
rm allam_zdis zbin
	j=0
	while [ $j -lt $step ]
	do
#		echo $j $Delta
		awk '$1>('$j'*'$Delta') && $1 < (('$j'+1)*'$Delta')' pairsZ | wc -l >> allam_zdis
		echo "" | awk '{print '$j'*'$Delta'+'$Delta'/2}' >> zbin
#		tail -10 zhis$i.temp
		((j++))
	done

#====================== to draw
smm zdis.sm
