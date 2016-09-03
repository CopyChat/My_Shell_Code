#!/bin/bash - 
#===============================================================================
#
#          FILE: statistic.sh
# 
#         USAGE: ./statistic.sh 
# 
#   DESCRIPTION: to calculate the statistic values to the input file 
# 
#       OPTIONS: --- if -l is given, the code will calculate each column
#  REQUIREMENTS: ---
#          BUGS: --- # :TODO:01/03/13 21:58:29 CST:Tang: make the script more relaiable
#         NOTES: ---  # :OUTPUT:03/20/13 09:49:13 CST:Tang: min,max,mean,sigma,median,poisson_err,sum
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 01/03/13 21:56:59 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error




if [ $# -lt 1 ];then
	echo "please input a file"
	exit 1
fi

if [ $# -eq 2 ]
then
	column=$(wc $2 | awk '{print $2/$1}')
	lines=$(wc $2 | awk '{print $1}')
#	echo $column
fi

if [ $# -eq 1 ]
then
	column=$(wc $1 | awk '{print $2/$1}')
	lines=$(wc $1 | awk '{print $1}')
#	echo $column
fi
# get the index of the media value
#media=$(echo $lines | awk '{if (($1%2) > 0) {print ($1+1)/2}else{print $1/2+1}}')
#echo $media
#=================================================== 
	case "$1" in
		-l) 
			for ((i=1;i<=$column;i++))
			do
				c=$i

				echo "------for $i Column-------"
				awk 'NR == 1 { min = $'$c'; minline = $0; next; } $'$c' < min { min=$'$c' }; END { print min }' $2 # min
				awk 'NR == 1 { max = $'$c'; maxline = $0; next; } $'$c' > max { max=$'$c' }; END { print max }' $2 # max
				mean=$(awk '{sum+=$'$c'} END {print sum/NR}' $2)
				echo $mean 																							# mean
				awk '{sum+=('$mean'-$'$c')*('$mean'-$'$c')} END {print sqrt(sum/(NR))}' $2 					# standard deviation
#				awk '{sum+=('$mean'-$'$c')*('$mean'-$'$c')} END {print sqrt(sum/((NR-1)*NR))}' $2 					# standard deviation
#mean_err=$(awk '{sum+=$'$c'} END {print sum/(NR*sqrt(NR))}' $2)

#=================================================== median
				if [ $((lines%2)) -lt 1 ] # odd
				then
					media=$(echo "" | awk '{print ('$lines')/2}')
					sort -n -k $c $2 | awk 'NR=='$media',NR==('$media'+1){print $'$c'}' | awk '{sum+=$1}END{print sum/2}'
				else
					media=$(echo "" | awk '{print (1+'$lines')/2}')
					sort -n -k $c $2 | awk 'NR=='$media'{print $'$c'}' 
				fi
poisson_err=$(awk '{sum+=$'$c'} END {print 1/sqrt(NR)}' $2)
#				echo $mean_err
				echo poisson_err
				awk '{sum+=$'$c'} END {print sum}' $2 																# sum
			done ;;


#=================================================== 
#=================================================== 
#=================================================== 
		*)
			if [ $# -eq 2 ] 
			then
				c=$1
				awk 'NR == 1 { min = $'$c'; minline = $0; next; } $'$c' < min { min=$'$c' }; END { print min }' $2 # min
				awk 'NR == 1 { max = $'$c'; maxline = $0; next; } $'$c' > max { max=$'$c' }; END { print max }' $2 # max
				mean=$(awk '{sum+=$'$c'} END {print sum/NR}' $2)
				echo $mean 																							# mean
				awk '{sum+=('$mean'-$'$c')*('$mean'-$'$c')} END {print sqrt(sum/(NR))}' $2 					# standard deviation
#				awk '{sum+=('$mean'-$'$c')*('$mean'-$'$c')} END {print sqrt(sum/((NR-1)*NR))}' $2 					# standard deviation
#				mean_err=$(awk '{sum+=$'$c'} END {print sum/(NR*sqrt(NR))}' $2)
#				echo $mean_err

#=================================================== median
				if [ $((lines%2)) -lt 1 ] # odd
				then
					media=$(echo "" | awk '{print ('$lines')/2}')
					sort -n -k $c $2 | awk 'NR=='$media',NR==('$media'+1){print $'$c'}' | awk '{sum+=$1}END{print sum/2}'
				else
					media=$(echo "" | awk '{print (1+'$lines')/2}')
					sort -n -k $c $2 | awk 'NR=='$media'{print $'$c'}'
				fi
				poisson_err=$(awk '{sum+=$'$c'} END {print 1/sqrt(NR)}' $2)
				echo $poisson_err
				awk '{sum+=$'$c'} END {print sum}' $2 																# sum
#=================================================== 
#=================================================== 
			else  #   $#==1
				c=1
                echo min
				awk 'NR == 1 { min = $'$c'; minline = $0; next; } $'$c' < min { min=$'$c' }; END { print min }' $1 # min
                echo max
				awk 'NR == 1 { max = $'$c'; maxline = $0; next; } $'$c' > max { max=$'$c' }; END { print max }' $1 # max
				mean=$(awk '{sum+=$'$c'} END {print sum/NR}' $1)
				echo mean $mean 																							# mean
#				awk '{sum+=$'$c';sumsq+=$'$c'*$'$c'} END {print sqrt(sumsq/NR-(sum/NR)**2)}' $1 					# standard deviation
                echo std
                awk '{sum+=('$mean'-$'$c')*('$mean'-$'$c')} END {print sqrt(sum/(NR))}' $1 					# standard deviation # :TODO:03/19/13 16:04:24 CST:Tang: sigma/sqrt(n-1)
#awk '{sum+=('$mean'-$'$c')*('$mean'-$'$c')} END {print sqrt(sum/((NR-1)*NR))}' $1 					# standard deviation # :TODO:03/19/13 16:04:24 CST:Tang: sigma/sqrt(n-1)
#				mean_err=$(awk '{sum+=$'$c'} END {print sum/(NR*sqrt(NR))}' $1)

#=================================================== median
				if [ $((lines%2)) -lt 1 ] # odd
				then
					media=$(echo "" | awk '{print ('$lines')/2}')
                    echo media
					sort -n -k $c $1 | awk 'NR=='$media',NR==('$media'+1){print $'$c'}' | awk '{sum+=$1}END{print sum/2}'
				else
					media=$(echo "" | awk '{print (1+'$lines')/2}')
                    echo media
					sort -n -k $c $1 | awk 'NR=='$media'{print $'$c'}'
				fi
				poisson_err=$(awk '{sum+=$'$c'} END {print 1/sqrt(NR)}' $1)
#				echo $mean_err																							# mean
                echo poisson_err
				echo $poisson_err
                echo sum
				awk '{sum+=$'$c'} END {print sum}' $1 																# sum
			fi ;;
	esac

exit	

