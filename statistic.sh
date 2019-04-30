#!/bin/bash - 
#===============================================================================
#
#          FILE: statistic.sh
# 
USAGE="./statistic.sh -opt file"
# 
#   DESCRIPTION: to calculate the statistic values to the input file 
# 
#       OPTIONS: --- -l, the code will calculate each line
options="
#                    -a, all the statistic values \n
#                    -i, min  \n
#                    -M, max  \n 
#                    -h, help, just this one. \n
#                    -m, mean  \n
#                    -s, std \n
#                    -p, possion_err \n
#                    -S, sum \n
#                    -t, test \n
"
#  REQUIREMENTS: ---
#          BUGS: --- # :TODO:01/03/13 21:58:29 CST:Tang: make the script more relaiable
#         NOTES: ---  # :OUTPUT:03/20/13 09:49:13 CST:Tang: min,max,mean,sigma,median,poisson_err,sum
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 01/03/13 21:56:59 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


TEST=0;
STD=0; MEAN=0; MIN=0; MAX=0; MEDIA=0; POSSION_ERR=0 ; SUM=0
LINE=0; 
#=================================================== 

while getopts ":talhiMmspS" opt; do
    case $opt in
        t) TEST=1 ;;
        a) STD=1; MEAN=1; MIN=1; MAX=1; MEDIA=1; POSSION_ERR=1 ;;
        l) LINE=1 ;;
        i) MIN=1 ;;
        M) MAX=1 ;;
        m) MEAN=1 ;;
        h) echo $USAGE; echo $options && exit 1;;
        s) STD=1 ;;
        S) SUM=1 ;;
        p) POSSION_ERR=1 ;;
        \?) echo $USAGE && exit 1
        esac
done
shift $(($OPTIND - 1))
#=================================================== 
inputfile=${1:-please input a file}

#=================================================== 



if [ "$TEST" = "1" ]; then # calculate by column
    echo inputfile is $inputfile
    echo "parameters: LINE=$LINE;STD=$STD; MEAN=$MEAN; MIN=$MIN; MAX=$MAX; MEDIA=$MEDIA; POSSION_ERR=$POSSION_ERR ; SUM=$SUM"
    exit
fi

function column_cal
{

column=$(wc $inputfile | awk '{print $2/$1}')
lines=$(wc $inputfile | awk '{print $1}')

        if [ "$MIN" = "1" ]; then
			for ((i=1;i<=$column;i++))
			do
				c=$i
				awk 'NR == 1 { min = $'$c'; minline = $0; next; } $'$c' < min { min=$'$c' }; END { printf "%f ",min }' $inputfile # min
            done
            echo "" 
        fi

        if [ "$MAX" = "1" ]; then
			for ((i=1;i<=$column;i++))
			do
				c=$i
				awk 'NR == 1 { max = $'$c'; maxline = $0; next; } $'$c' > max { max=$'$c' }; END { printf "%f ", max }' $inputfile # max
            done
            echo ""
        fi
            
        if [ "$MEAN" = "1" ]; then
			for ((i=1;i<=$column;i++))
            do
                c=$i
				awk '{sum+=$'$c'} END {printf "%f ",sum/NR}' $inputfile
            done
            echo ""
        fi

        if [ "$STD" = "1" ]; then
            for ((i=1;i<=$column;i++))
            do
                c=$i
                #echo column=$column
                #echo c=$i
                mean=$(awk '{sum+=$'$c'} END {print sum/NR}' $inputfile)
                awk '{sum+=('$mean'-$'$c')*('$mean'-$'$c')} END {printf "%f ", sqrt(sum/NR)}' $inputfile
                #awk '{sum+=('$mean'-$'$c')*('$mean'-$'$c')} END {printf "%f ", sqrt(sum/((NR-1)*NR))}' $inputfile
            done
            echo "" 
        fi

        if [ "$MEDIA" = "1" ]; then
			for ((i=1;i<=$column;i++))
			do
				c=$i
				if [ $((lines%2)) -lt 1 ] # odd
				then
					media=$(echo "" | awk '{print ('$lines')/2}')
					sort -n -k $c $inputfile | awk 'NR=='$media',NR==('$media'+1){print $'$c'}' | awk '{sum+=$1}END{printf "%f ", sum/2}'
				else
					media=$(echo "" | awk '{print (1+'$lines')/2}')
					sort -n -k $c $inputfile | awk 'NR=='$media'{printf "%f ", $'$c'}' 
				fi
            done
            echo "" 
        fi

        if [ "$POSSION_ERR" = "1" ]; then
			for ((i=1;i<=$column;i++))
			do
				c=$i
                #poisson_err=$(
                awk '{sum+=$'$c'} END {printf "%f ",1/sqrt(NR)}' $inputfile
                
            done
            echo "" 
        fi

        
        if [ "$SUM" = "1" ]; then
            for ((i=1;i<=$column;i++))
			do
				c=$i
			    awk '{sum+=$'$c'} END {printf "%f ", sum}' $inputfile 																# sum
            done
            echo ""
        fi
} # end function column_cal


if [ "$LINE" = "0" ]; then # calculate by column
    column_cal
else
    transpose.sh $inputfile > .statical.sh.temp

    inputfile="./.statical.sh.temp"
    column_cal > .statical.sh.col.temp
    transpose.sh .statical.sh.col.temp
    rm ./.statical.sh.temp .statical.sh.col.temp
fi


