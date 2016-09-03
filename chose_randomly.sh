#!/bin/bash - 
#===============================================================================
#
#          FILE: chose_randomly.sh
# 
#         USAGE: chose_randomly.sh lines filename
# 
#   DESCRIPTION: to chose some lines randomly from the exited file 
# 
#       OPTIONS: $2 filename 
# 				 $1, num of lines to chose limits is 1 000 000
#  REQUIREMENTS: --- the c code returnrandom in ~/Shell compiled based on the 
# 					 source in ~/Shell/source/ with the same name
#          BUGS: --- the input file DONOT have to be rectangular
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 10/16/12 17:15:47 CST
#      REVISION:  1.0
#===============================================================================

set -o nounset                              # Treat unset variables as an error

l=$(wc $2 | awk '{print $1}')
 # :TODO:10/16/12 18:48:48 CST:Tang: some debug codes to print the errors 
 # :TODO:10/16/12 18:49:31 CST:Tang: use bash to produce random points

 # :TODO:10/16/12 18:07:07 CST:Tang: change the limits of randomreturn
returnrandom $l # :TODO:10/16/12 18:29:26 CST:Tang: outfile named "random_temp.dat9090"
#awk 'NR==FNR{a[$1]=$1}NR!=FNR{for(i in a) {if(FNR==a[i]) {print $0,FNR,a[NFR]}}}' random_temp.dat908 $2
#
paste -d " " random_temp.dat9090 $2 | sort -n -k 1 | head -$1 | awk '{$1="";print $0}' | sed "s/^ *//g" 
# :NOTE:10/16/12 19:18:29 CST:Tang: awk leaving a space before each line, & use sed remove it
#paste random_temp.dat9090 $2 | sort -n -k 1 | head -$1 | awk '{$1 = null ;print}'
rm random_temp.dat9090

#echo ''|awk "BEGIN{srand($RANDOM)}{for (i=1;i<=$1;i++)printf \"%d\n\",rand()*$l}" > random_temp.dat908
#for nr in $(echo ''|awk "BEGIN{srand($RANDOM)}{for (i=1;i<=$1;i++)printf \"%d\n\",rand()*$l}" > random_temp.dat908)
#do
#
#awk '{print NR,$0}' $2 > random_temp.3
#chose.sh random_temp.dat908 random_temp.3 | awk '{$1="";print $0}' | sed "s/^ *//g"


#rm random_temp.dat908 random_temp.3

##vim random_temp.dat908
##awk 'NR==FNR{a[$1]=$1}NR!=FNR{$(NF+1)=FNR;if($(NF+1)==a[$(NF+1)]) {$(NF+1)="";print}}' random_temp.dat908 $2
#
