#===============================================================================
#
#          FILE: transpose.awk
# 
#         USAGE: transpose file1 
# 
#   DESCRIPTION: to transpose a matrix 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: --- why the result has so many TAB
#         NOTES: ---
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 11/29/12 20:03:31 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


awk -f /Users/ctang/Code/Shell/transpose.awk $1
exit



#echo $1
line=$(wc -l $1)
#wc $1 | awk '{print $2/$1}'
column=$(wc $1 | awk '{print $2/$1}')
Col=$(expr $column \+ 1)
#echo $line $column
i=1
while [ $i -lt $Col ]
do
	awk '{print $'$i'}' $1 > transpose1.temp
	paste -s transpose1.temp | awk '{gsub(/\t/," ");print}' 
	rm transpose1.temp
	((i++))
done
