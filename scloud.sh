#!/bin/bash - 
#===============================================================================
#
#          FILE: scloud
# 
#         USAGE: scloud
# 
#   DESCRIPTION: rsync onedrive to icloud and vers veso
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: default: cp to the current directory
#        AUTHOR: Tang (Tang), tangchao90908@sina.com
#  ORGANIZATION: KLA
#       CREATED: 10/07/12 10:03:34 CST
#      REVISION:  1.1
#===============================================================================

set -o nounset                              # Treat unset variables as an error
. /Users/ctang/Microsoft_OneDrive/OneDrive/CODE/Shell/functions.sh


iCloud='/Users/ctang/Library/Mobile\ Documents/com~apple~CloudDocs'
OneDrive=/Users/ctang/Microsoft_OneDrive/OneDrive

Nutstore=/Users/ctang/Nutstore/

icloud_2_Nutstore=(\
    "ctang.backup/" \
    )

onedrive_2_icloud=(\
    "ClimateEndNoteLibrary.enl "
    "ClimateEndNoteLibrary.Data/"
    "ctang.backup/" \
    "Science/" \
    )

icloud_2_oneDrive=(\
    "backup/" \
    "Setting/" \
    "tones/" \
    "Lib/" \
    "Documents/" \
    "Marie/" \
    )


# back OneDrive 2 iCloud

len=${#onedrive_2_icloud[@]}

for ((i=0;i<$len;i++))
do
	color -n 1 7 "backing up file:  "
    color 7 1 " ${onedrive_2_icloud[$i]}"
    rsync -aurvhSPH $OneDrive/${onedrive_2_icloud[$i]} /Users/ctang/Library/Mobile\ Documents/com~apple~CloudDocs/${onedrive_2_icloud[$i]}
done


##### back up to OneDrive from iCloud

len=${#icloud_2_oneDrive[@]}

for ((i=0;i<$len;i++))
do
	color -n 1 7 "backing up file:  "
    color 7 1 " ${icloud_2_oneDrive[$i]}"
    rsync -aurvhSPH /Users/ctang/Library/Mobile\ Documents/com~apple~CloudDocs/${icloud_2_oneDrive[$i]} $OneDrive/${icloud_2_oneDrive[$i]} 
done

#=================================================== 
# back OneDrive 2 iCloud

len=${#icloud_2_Nutstore[@]}

for ((i=0;i<$len;i++))
do
	color -n 1 7 "backing up file:  "
    color 7 1 " ${icloud_2_Nutstore[$i]}"
    rsync -arvuhSPH /Users/ctang/Library/Mobile\ Documents/com~apple~CloudDocs/${icloud_2_Nutstore[$i]} $Nutstore/${icloud_2_Nutstore[$i]} 
done

#=================================================== 
color 7 1 " rsync iCloud <<====>> OneDrive is DONE"
