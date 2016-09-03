#!/bin/bash
# to extrapolate the probabilities of pairs in z space from the projected distance
#awk '{ gsub(/,/,"\t");print}' ../original_data/sdss > sdss1


#================================================ to cut 
#awk '$6>150 && $6<160 && $7<40 && $7>30' sdss1 > cut100
#awk '{print $1, $6, $7, $8}' cut100 > cut
wc cut
# 6689 galaxies


a=$( average cut 4 )
echo average z=$a
# average ~ 0.105877
b=$( z2dis $a | tail -1 | awk '{print $2}')
echo dis=$b z=$a
# distance at 0.105877 ~ 440.836379 Mpc
c=$(echo | awk 'END{print (18/3.1415)/'$b'}')
d=$(echo | awk 'END{print (18*3600/3.1415)/'$b'}')
echo 100kpc "~" $c degree $d arcsecond 
# 100kpc ~ 0.0129974 degree 46.7908 arcsecond

#================================================ calculate the angular distance
#gcc angulardis.c -o angular_distance
#./angular_distance
# output file: cut_angular.cat: id 	ra1 	dec1 	Zspec 	id2 	ra2 	dec2 	Zspec2 	angular_distance 
# output file structure: 	1 	2 		3 		4 		5 		6 		7 		8 		9
#l=$(average cut_angular.cat 9)
#echo average separation of all pairs: $l
# is 5.12974 degree
#wc cut_angular.cat

#================================================ limits for separation: 100kpc

#awk '$9 < '$c'' cut_angular.cat > samplt50
#rm cut_angular.cat
echo there are $(wc samplt50 |awk '{print $1}' ) pairs "<" $d
# 213 ????!!!
h=$(average samplt50 9)
i=$(echo | awk 'END{print (3600*'$h')}')
echo average separation of projected pairs: $h "~" $i arcsecond
# average separation of projected pairs: 0.00801082 ~ 28.839 arcsecond

#================================================ delatZ/(1+z)
awk '{print ($4-$8)/(1+$4), ($4-$8)/(1+$8)}' samplt50 > lt50z
#================================================ for z distribution
awk '{print $1, $2, $3, $4}' samplt50 > znzn4col
awk '{print $5, $6, $7, $8}' samplt50 >> znzn4col
awk '{print $4}' znzn4col > znzn1col
wc znzn1col
#================================================ for random z 
#rm rand_z
#gcc Random.c -o Random
#./Random 10
# output Random redshift: rand_z(DelataZ/(1+Z)) & rand_zz1 : 1000 times

smm randz.sm



#================================================ draw
smm histotgh.sm 
smm zhisto.sm
#rm rand_zz1
smm loghistotgh.sm


#=================================================213 pairs < 100kpc in 22368016, why?
#awk '{print $9}' cut_angular.cat | sort > angluar_sort
#open angluar_sort
#average angluar_sort # the same !
#rm angluar_sort
# ok !

#================================================ are wyz's galaxies all in the catalog ??
#cat ../wyz/cut > jj && cat cut >> jj
#sort jj | uniq > kk
#q=$(wc kk)
#rm jj kk
#echo sdss-wyz=$q galaxies
# YES, her galaxies are all in the sdss_cut catalog

#================================================ are wyz's pairs all in the sdss pairs???
#cat ../wyz/cut_angular.cat > jj && cat cut_angular.cat >> jj
#sort -n -k 1 jj | uniq > kk
#sort cut_angular.cat > kkk
#comm -3 kk kkk > diff
#echo $(wc dif)
# NO, 54739 different lines why the pairs in wyz are not in the sdss pairs?
#================================================ are they in diff order A-B != B-A
#awk '{print $1,$2,$3,$4}' diff > jk
#awk '{print $5,$6,$7,$8}' diff > kj
#paste jk kj > jkjk
#sort jkjk > com1
#awk '{print $1,$2,$3,$4,$5,$6,$7,$8}' ../wyz/cut_angular.cat > com2
#sort com2 > com3
#comm -3 com1 com3 > com


#================================================= average of angular dis of wyz's 668 galaxies
#average ../wyz/cut_angular.cat 9
# 5.08118 < that of sdss 5.12974 degree

