#==================================================================== 
##==========set for Prompt string customizations ====================
#==================================================================== 
##	\d 当前日期
##	\h 主机名
##	\t 当前时间
##	\u 用户名
#	\w 工作目录
#=============================================================== for shell



#export PS1='\[\033[01;33m\]\u@\h\[\033[01;31m\] \W\$\[\033[00m\] '
#export PS1="\[\e[36;1m\]\u@\[\e[32;1m\]\H>; \[\e[0m\]"
#export PS1="[\w]>>>(^_^)"
#export PS1="[Ɓảšħ \w]>> "
#export PS1="[\w]>> "
#export PS1="[☃ \A \w]>> "
export PS1="\[\033[1;33m\]\w >>\[\033[0m\] "
#export PS1='\e[1;38;5;56;48;5;234m\u \e[38;5;240mon \e[1;38;5;28;48;5;234m\h \e[38;5;54m\d \@\e[0m\n\e[0;38;5;56;48;5;234m[\w] \e[1m\$\e[0m '
#=============================================================== for color
export CLICOLOR=1
export LSCOLORS=gxfxaxdxfxegedabagacadcae
export FC=gfortran

#=================================================== command line editor
set -o vi
#set -o emacs
EDITOR=/usr/bin/vim

#==================================================================== 
#==================================================================== 
#==================================================================== 
#==================================================================== 
#======================================================= for my alias
#alias kla="ssh -X tangchao@202.121.49.52" # the key is in the ~/Shell/kla
alias gp="/usr/local/bin/gnuplot"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

alias dash="call_dash.sh"

alias hist="history"


#==================================================================== 
#=================================================== my servers
alias tt="ssh -Y ctang@titan.univ.run" #the key is jing90908ss
alias ttt="ssh -Y ctang@ccur.univ-reunion.fr" #the key is jing90908ss
alias titan="echo  ctang@ccur.univ-reunion.fr" #the key is jing90908ss
alias tt="ssh ctang@10.82.80.222" #use the ip_sra.pub key
alias titan="echo  ctang@10.82.80.222" #the key is jing90908ss
alias jjj="ssh -Y ctang@ccur.univ-reunion.fr" #the key is jing90908ss
alias dijon="echo c+kvC\(22*+r6 | pbcopy; ssh -X -C ctb19335@ssh-ccub.u-bourgogne.fr" # key:c+kvC(22*+r6

alias reu="ssh ctang@frontal-ssh.univ-reunion.fr" #use the ip_sra.pub key
#alias imac="ssh -Y le2p@titan.univ.run" #the key is aurore09
alias imac="echo "aurore09" | pbcopy; ssh -Y le2p@10.243.6.78" #the key is aurore09
alias ham="ssh -Y u237007@thunder7.zmaw.de" #the key is jing9090*ss
alias hamm="ssh -Y u237007@login.zmaw.de" #the key is jing9090*ss

alias cines2="echo "m2et72j7taje" | pbcopy ;ssh -Y bmorel@occigen.cines.fr"  #  m2et72j7taje
#alias cines="color 1 7 "93jd9lku8fx3"; ssh -Y ctang@occigen.cines.fr"  #  m2et72j7taje
alias cines="echo "jb2fn284uu76" | pbcopy ; ssh -Y ctang@occigen.cines.fr"  # 2018-2019 
#alias cines="echo "93jd9lku8fx3" | pbcopy ; ssh -Y ctang@occigen.cines.fr"  #  m2et72j7taje
alias scpcines="echo "jb2fn284uu76" | pbcopy; scp"
alias showcines="echo ctang@occigen.cines.fr"  #  m2et72j7taje
alias cinesp="echo "93jd9lku8fx3" | pbcopy"
alias password_mac="ehco le2p, aurore09"


#==================================================================== 
#=================================================== command alias
alias permit="xattr -rd com.apple.quarantine"
alias bad="xattr -rd com.apple.quarantine" 

alias ..="cd ../" 
alias ....="cd ../../"
#=================================================== 
#unalias cd
#cd()
#{
    #if [[ "$#" == "0" ]];then
        #command cd 
    #else
        #if [[ "$1" == ".." ]]; then
            #shift
            #command "cd ../"
        #else 
            #command cd "$@"
        #fi
    #fi
#}
#=================================================== 
alias la="ls -AF" 
alias s.="source ~/.bashrc" 
alias v.="vim ~/.bashrc" 
alias vv.="vim ~/.vimrc" 
#alias vvf.="vim ~/Code/Shell/functions.sh"
alias vvf.="vim /Users/ctang/Microsoft_OneDrive/OneDrive/CODE/Shell/functions.sh"
alias cdi="cd /Users/ctang/Library/Mobile\ Documents/com~apple~CloudDocs"
export dircloud='/Users/ctang/Library/Mobile\ Documents/com~apple~CloudDocs'
alias gyso="cd /Users/ctang/Microsoft_OneDrive/OneDrive/Science/GYSOMATE"
#alias enso="cd /Users/ctang/climate/Modeling/Ensemble/ENSO"
#alias cdrrtmg="cd /Users/ctang/climate/Modeling/rrtmg_sw_v3.9/column_model"
alias cdi="cd /Users/ctang/Library/Mobile\ Documents/com~apple~CloudDocs"
alias cdb="cd /Volumes/NTFS_2.7T/ClimateWorksBackup/4peng/swio_1979-2015"
alias cdm="cd /Users/ctang/climate/Modeling"
alias cdm="cd /Users/ctang/Microsoft_OneDrive/OneDrive/CODE/Mialhe_2020"
alias cde="cd ~/climate/GLOBALDATA/OBSDATA/ERA_Interim/ERA_Interim_SSR_vs_GEBA"
alias cds="cd /Users/ctang/Code/validation_SARAH-2_GEBA_SA/"
alias vp.="vim /Users/ctang/Microsoft_OneDrive/OneDrive/CODE/Python/ctang.py"
alias cdw="cd /Users/ctang/climate/GLOBALDATA/OBSDATA/WRDC"

alias cdds="cd /Users/ctang/Microsoft_OneDrive/OneDrive/CODE/Shell"
alias cdp="cd /Users/ctang/Microsoft_OneDrive/OneDrive/CODE/Pauline_2019"
alias cddm="cd /Users/ctang/Documents/MATLAB"
alias cddo="cd /Users/ctang/climate/GLOBALDATA/OBSDATA"
alias cddg="cd /Users/ctang/climate/GLOBALDATA"
alias cddn="cd /Users/ctang/climate/GLOBALDATA/OBSDATA/GEBAdata/validation.cm_saf"
alias cddr="cd /Users/ctang/climate/RegCM/RegCM-4.5.0"
alias cdd="cd /Users/ctang/Microsoft_OneDrive/OneDrive/CODE/Cines_setup"
alias cdd="cd /Users/ctang/Microsoft_OneDrive/OneDrive/CODE/SolarPV_ClimateChange"
alias cdd="cd /Users/ctang/Microsoft_OneDrive/OneDrive/CODE/CORDEX_AFR_studies/"
alias cdd="cd /Users/ctang/Microsoft_OneDrive/OneDrive/CODE/Prediction_PV"
alias cddc="cd /Users/ctang/Microsoft_OneDrive/OneDrive/CODE/Shell"
alias cds='cd /Users/ctang/Microsoft_OneDrive/OneDrive/Science'

#alias gcc="gcc -std=c99"
#alias topcat="topcat -Xmx4256M"
#alias sqlcl="sqlcl.py" # in /Users/tang/astro/software/sdss:
#alias mysql="/usr/local/mysql/bin/mysql" 
#======================================================================= 
#======================================================= for awk scripts
alias transpose="awk -f /Users/tang/Shell/transpose.awk"
#======================================================================= 
#=========================================================== my servers
alias solarisedu="ssh tangchao90908@x4100-edu.unix-center.net"
alias solaris="ssh tangchao90908@x4100.unix-center.net"
alias osolarisedu="ssh tangchao90908@solaris-edu.unix-center.net"
alias osolaris="ssh tangchao90908@solaris.unix-center.net"
alias freebsdedu="ssh tangchao90908@freebsd-edu.unix-center.net"
alias freebsd="ssh tangchao90908@freebsd.unix-center.net"
alias aixedu="ssh tangchao90908@aix-edu.unix-center.net"
alias aix="ssh tangchao90908@aix.unix-center.net"
alias ubuntuedu="ssh tangchao90908@ubuntu-edu.unix-center.net"
alias ubuntu="ssh tangchao90908@ubuntu.unix-center.net"
alias fedoraedu="ssh tangchao90908@fedora-edu.unix-center.net"
alias fedora="ssh tangchao90908@fedora.unix-center.net"
alias enca="enca -L zh_CN -x UTF-8"
# key jing9090908(unix-center,www.unix-center.net)
#=================================================================
#============================================ for my Shell scripts
#source ~/Shell/.shrc
alias wcc="superwc" 
alias rjpg="renamejpg"
alias rpdf="renamepdf"
alias reps="renameps"
alias al="addlinenumber"
alias chmodd="sudo chmod a+xwr" 
alias passage="PASSaGE_macosx386"
alias ftpkla="ftp 202.121.53.133" 
#==================================================================== 
#========================================================== my path

PATH=/Users/ctang/Microsoft_OneDrive/OneDrive/CODE/Python:$PATH;export PATH
PATH=/Users/ctang/Microsoft_OneDrive/OneDrive/CODE/Shell/netCDF:$PATH;export PATH
PATH=/Users/ctang/climate/ncl/bin:$PATH;export PATH
PATH=/Users/ctang/anaconda3/bin:$PATH;export PATH
PATH=/Users/ctang/Code/Apple:$PATH;export PATH
PATH=/Users/ctang/Code/Python:$PATH;export PATH
PATH=/Users/ctang/Code/Shell:$PATH;export PATH
PATH=/Users/ctang/Code/Plotting/Python:$PATH;export PATH
PATH=/Users/ctang/Code/Shell/RegCM:$PATH;export PATH
PATH=/Users/ctang/Code/Shell/netCDF:$PATH;export PATH
PATH=/Users/ctang/Microsoft_OneDrive/OneDrive/CODE/Shell:$PATH;export PATH
#PATH=/opt/local/libexec/gnubin:$PATH;export PATH  # for GNU coreutils
PATH=/opt/pgi/osx86-64/15.9/bin:$PATH;export PATH
PATH=/Users/tang/astro/software/sdss:$PATH;export PATH
PATH=/Applications/MATLAB_R2014a.app/bin:$PATH; export PATH
PATH=/opt/local/bin:$PATH;export PATH
PATH=/usr/local/ferret/bin:$PATH;export PATH
PATH=/Users/tang/astro/ZPHOT/src:$PATH;export PATH
PATH=/Users/tang/.vim/plugin:$PATH;export PATH
PATH=/Users/tang/astro/PASSaGE:$PATH;export PATH
PATH=/Users/tang/Shell:$PATH;export PATH
PATH=/Users/tang/Shell/netCDF:$PATH;export PATH
PATH=/Users/tang/Python:$PATH;export PATH
PATH=/Users/tang/Python/netCDF:$PATH;export PATH
PATH=/Users/tang/Shell/otherscripts:$PATH;export PATH
PATH=/Library/TeX/Root/bin/universal-darwin:$PATH;export PATH
PATH=/usr/local/texlive/2011/bin/x86_64-darwin:$PATH;export PATH
PATH=/usr/local/include/c++/4.6.1/tr1:$PATH;export PATH
PATH=/usr/local/scisoft/bin:$PATH;export PATH
PATH=/usr/local/starjava/bin:$PATH;export PATH
PATH=/usr/local/scisoft/Applications/fv.app/Contents/MacOS:$PATH;export PATH
PATH=/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/:$PATH;export PATH
PATH=/Applications/Gnuplot.app/Contents/MacOS:$PATH;export PATH
PATH=/Users/tang/Shell/otherscripts:$PATH;export PATH
PATH=/Users/tang/astro/ulyss:$PATH;export PATH
#==================================================================== 
#===================================================== set man path
MANPATH=/usr/man:/usr/local/man:/usr/local/share/man:$MANPATH;export MANPATH
MANPATH=/usr/local/scisoft/packages/jpeg-8d/share/man:$MANPATH;export MANPATH

#==================================================================== 
#==================================================================== 
#===========================
#    set fot bc03
#===========================
PATH=/Users/tang/astro/bc03/src:$PATH;export PATH
alias csp="csp_galaxev"
alias gpl="galaxevpl"
alias add="add_bursts"
alias vdisp="vel_disp"
alias dgr="downgrade_resolution"
alias gpl="galaxevpl"
alias cmev="cm_evolution"
#
FILTERS=FILTERBIN.RES # not work, set env using 'export' command
export FILTERS="/Users/tang/astro/bc03/src/FILTERBIN.RES"
export A0VSED="/Users/tang/astro/bc03/src/A0V_KURUCZ_92.SED"
export RF_COLORS_ARRAYS="/Users/tang/astro/bc03/src/RF_COLORS.filters"
PATH=/Users/tang/astro/bc03/src:$PATH;export PATH

#==================================================================== 
#============================================================ for SM
PATH=/usr/local/scisoft/packages/sm2_4_34/bin:$PATH;export PATH
PATH=/usr/local/bin:$PATH;export PATH
alias sm="sm -m /Users/tang/.smlib/start.sm"

#==================================================================== 
#====================================================== for starlink
#export STARLINK_DIR="/Users/tang/astro/star-namaka/"
#source $STARLINK_DIR/etc/profile
#. /usr/local/scisoft/bin/irafuser.bash
#==================================================================== 
#============================================================ for X11
#export IRAFARCH=f2c
export TERMINFO=/usr/share/terminfo
#==================================================================== 
#===================================================== for idl v7.1.1
PATH=/Applications/itt/idl/bin:$PATH;export PATH
export IDL_STARTUP="/Users/ctang/Lib/IDL_LIB//startup.pro"
#export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/lib/:$DYLD_FALLBACK_LIBRARY_PATH
#export DYLD_FALLBACK_LIBRARY_PATH=/System/Library/Frameworks/ImageIO.framework/Versions/A/Resources:$DYLD_FALLBACK_LIBRARY_PATH
#export DYLD_FALLBACK_LIBRARY_PATH=/System/Library/Frameworks/ImageIO.framework/Versions/A/ImageIO:$DYLD_FALLBACK_LIBRARY_PATH
#=================================================== 
# ImageMagick
export MAGICK_HOME="/Users/ctang/Lib/ImageMagick-7.0.7"
export PATH="/Users/ctang/Lib/ImageMagick-7.0.7/bin":$PATH
#export DYLD_LIBRARY_PATH="/Users/ctang/Lib/ImageMagick-7.0.7/lib"
#==================================================================== 
#================================================ for idl idlutils
export IDL_DIR="/Applications/itt/idl"
export IDLUTILS_DIR="/Users/tang/IDLWorkspace71/idlutils"
PATH=$IDLUTILS_DIR/bin:$PATH
export IDL_PATH=+$IDLUTILS_DIR/pro:$IDL_PATH
export IDL_PATH=+$IDL_DIR/lib:$IDL_PATH
export IDL_PATH=+$IDLUTILS_DIR/goddard/pro:$IDL_PATH
#==================================================================== 
#================================================ for kcorrect
export KCORRECT_DIR="/Users/tang/astro/kcorrect"
export IDL_PATH=+$KCORRECT_DIR/pro:$IDL_PATH
export IDL_PATH=+$KCORRECT_DIR/pro/fit:$IDL_PATH
export DUST_DIR=/Users/tang/astro/nyu_vagc/
#================================================
export PATH=$KCORRECT_DIR/bin:$PATH
#LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$KCORRECT_DIR/lib
export LD_LIBRARY_PATH=+

#==================================================================== 
#================================================ for impro
export IMPRO_DIR="/Users/tang/IDLWorkspace71/impro"
export IDL_PATH=+$IMPRO_DIR/pro:$IDL_PATH
#==================================================================== 
#=================================================== for multi-gaussian fit
export IDL_LIB_TANG="/Users/tang/astro/idl_lib_tang"
export IDL_PATH=+$IDL_LIB_TANG/mge_fit_sectors:$IDL_PATH
export IDL_PATH=+$IDL_LIB_TANG:$IDL_PATH
#==================================================================== 
#=================================================== for fuse_idl_utilities_022007
export IDL_PATH=+$IDL_LIB_TANG/fuse_idl_utilities_022007:$IDL_PATH
#==================================================================== 
#=================================================== for ltools_022007
export IDL_PATH=+$IDL_LIB_TANG/ltools_022007:$IDL_PATH
#==================================================================== 
#================================================ set for less
export LESS="-x4 -Ps'Press SPACE to CONTINUE, v to call VIM, h for help, q to QUITE'" # :NOTE:10/13/12 00:30:47 CST:Tang: set tab as 4 charactors

#=================================================== 
#set for Gcc 4.8.1
#=================================================== 
#export PATH=/usr/local/gcc-4.8.1/bin:$PATH
export PATH=/opt/local/bin:$PATH
#=================================================== 
#set for gfortran 4.8.2
#=================================================== 
#export PATH=/usr/local/gfortran/bin:$PATH
#=================================================== 
export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/local/lib/:$LD_LIBRARY_PATH
#export DYLD_LIBRARY_PATH=/usr/local/lib/:$DYLD_LIBRARY_PATH
#export DYLD_LIBRARY_PATH=/opt/local/lib/:$DYLD_LIBRARY_PATH
#alias gcc="gcc-4.8.1" 
#alias gfortran="gfortran-4.8.1" 
#=================================================== 
#set for netCDF-4.3
#=================================================== 
#=================================================== 
#set for cdo
#=================================================== 
alias cdo="cdo -b 64"
alias cdot="cdo showtimestamp"
#=================================================== 
# set for RegCM 4.3.5.6
#=================================================== 
export PATH=/Users/ctang/climate/RegCM/RegCM-4.5.0/bin:$PATH
export REGCM_ROOT=/Users/ctang/climate/RegCM/RegCM-4.5.0
export REGCM_SRC=/Users/ctang/climate/RegCM/RegCM-4.5.0/src
export REGCM_RUN=/Users/ctang/climate/Modeling/test
export REGCM_GLOBEDAT=/Users/ctang/climate/GLOBALDATA

export ICTP_DATASITE="http://clima-dods.ictp.it/Data/RegCM_Data"
#=================================================== 
# set for ncl
#=================================================== 
export NCARG_ROOT=/Users/ctang/climate/ncl
export PATH=$NCARG_ROOT/bin:$PATH
export MANPATH=$NCARG_ROOT/man:$MANPATH
export PATH=/Users/ctang/climate/ncl/bin:$PATH
export LD_LIBRARY_PATH=/Users/ctang/climate/ncl/lib/:$LD_LIBRARY_PATH

#=================================================== 
# set for idl
#=================================================== 
#=================================================== 
# set for grads
#=================================================== 
alias grads="grads"
#export PATH=/usr/local/grads-2.1.0/bin:$PATH
export PATH=/usr/local/grads-2.0.2/bin:$PATH
export GADDIR=/Users/ctang/Lib/grads-2.1.0/lib
export GASCRP=/Users/ctang/Lib/grads-2.1.0/lib/scripts
#=================================================== 
# set for phyton 2.7
#=================================================== 
#export PYTHONSTARTUP=/Users/ctang/.pythonstartup
export PYTHONPATH=/Users/ctang/Lib/Python
#=================================================== 
# set for perl
#=================================================== 
export PERL5LIB=/Users/ctang/climate/perl:$PERL5LIB
export PERL5LIB=/Users/ctang/climate/perl/ECMWF:$PERL5LIB
export PERL_LWP_SSL_VERIFY_HOSTNAME=0
export CPATH=/opt/local/include:$CPATH
#=================================================== 
# set for java
#=================================================== 
export CLASSPATH=/Users/ctang/climate/java:$CLASSPATH
#=================================================== 
#==================================================================== 
#==================================================================== 
#==================================================================== 
#=========================================================== for test
alias cmip=~/climate/GLOBALDATA/CMIP5
alias cd='cd '
#==================================================================== 
source /Users/ctang/Microsoft_OneDrive/OneDrive/CODE/Shell/functions.sh
#==================================================================== 
function matlabb 										# for matlab
{
	local name=${1%.m}
	matlab -nodesktop -nosplash -r ${1%.m}
	return 0
}
alias matlab='matlab -nodesktop'
#=================================================== test
#=================================================== linshi
alias vsel.="vim ~/Shell/seltimestep.sh"


alias sha256sum="shasum"
#=================================================== for ESMF
export PATH=/Users/tang/ESMF/local/bin/bing/Darwin.gfortran.64.mpiuni.default:$PATH
export ESMF_DIR=/Users/tang/ESMF
#export ESMF_BOPT=g 
#export MACOSX_DEPLOYMENT_TARGET=14.1
export ESMF_INSTALL_PREFIX=/Users/tang/ESMF/local
export ESMF_NETCDF=standard
#export ESMF_NETCDF_INCLUDE=/usr/local/include/
#export ESMF_NETCDF_LIBPATH=/usr/local/lib
#export ESMF_PNETCDF=standard
#export ESMF_COMPILER=/usr/local/gcc-4.8.1/bin/gcc-4.8.1
#export ESMF_CXX=/usr/local/gcc-4.8.1/bin/g++-4.8.1
export ESMF_CXXCOMPILEOPTS='-lnetcdf'
export ESMF_CXXOPTFLAG='-lnetcdf'
#=================================================== gcc and gfortran

export PATH=/usr/local/gfortran/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/gfortran/lib:$LD_LIBRARY_PATH

#=================================================== for mds
alias mds='sudo fs_usage -w -f filesys mdworker'
#=========================================================== for ictp
alias ictp1="color 7 1 25E2EG3v; ssh -Y ctang@argo.ictp.it"
alias ictpc="color 7 1 fBF5z4Qx; ssh -Y ctang@argo.ictp.it" #new
alias ictp="color 1 7 ^_^; ssh -Y ctang@argo.ictp.it"
alias ictp2="color 1 7 ^_^; ssh -Y ctang@argo"
alias marie="ssh Marie@marie-macbook-air.home"
alias Marie="ssh Marie@192.168.1.18"
alias iMac="ssh le2p@10.243.6.78"
alias gyso="echo 123 | pbcopy; ssh -Y gysomate@10.243.6.78"
alias grp07="echo mEaJaNT2 | pbcopy; ssh -Y grp07@argo.ictp.it"

alias svnregcm="svn checkout --username ctang https://gforge.ictp.it/svn/regcm//tags/RegCM-4.4.5" # jing90908ss

alias cp="cp -v"
alias mv="mv -v"



#=================================================== list the file
# to list in size
#
#Simply use something like:
alias list="ls -lhSr"
#To exclude directories:

alias listf="ls -lhS | grep -v '^d'"
#I see now how it still shows symbolic links, which could be folders. 
#Symbolic links always start with a letter l, as in link.  
#Change the command to filter for a -. This should only leave regular files:

alias listl="ls -lhS | grep '^-'"
#On my system this only shows regular files.

#update 3:
#To add recursion I would leave the sorting of the lines to the sort command 
#and tell it to use the 5th column to sort on.

alias listr="ls -lhR | grep '^-' | sort -k 5 -rn"

#-rn means Reverse and numeric to get the biggest files at the top. 
#Down side of this command is that it does not show the full path of the files.

#If you do need the full path of the files, use something like this:

#alias listd="find . -type d  | xargs du -h | sort -rn "
#alias listd="du -d 1 | sort -n | awk 'BEGIN {OFMT = "%.0f"} {print $1/1024,"MB", $2}'"
alias listd="du -sh */ | gsort -h"
#The find command will recursively list all files in all sub directories of ., xargs will use the output of find as an argument to du -h meaning disk usage -humanreadable and then sort the output again.

alias rmlinks="find . -type l -exec sh -c 'rm "{}"' \;"
shopt -s extglob
if shopt -q login_shell; then
    [any code that outputs text here]
fi

export iterm2_hostname=Tang.local
#source ~/.iterm2_shell_integration.bash

#=================================================== 
alias getip="wget http://ipinfo.io/ip -qO -"
#export LC_CTYPE='es_US.utf8'

#=================================================== for ferret
export FER_DIR="/usr/local/ferret"
export FER_DSETS="/usr/local/ferret/fer_dsets"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_101.jdk/Contents/Home/"
export FER_PALETTE="$FER_DIR/ppl"       # palette search list
export PLOTFONTS="$FER_DIR/ppl/fonts"
export CPP_X11="/opt/X11/include/"
#=================================================== 

alias cdbackdir="cd /Volumes/tang_01/Backups.backupdb/Tang/2016-09-02-001922/Macintosh\ HD/Users/tang/"


#=================================================== 
# to install netCDF-fortran

export NCDIR="/usr/local"
export NFDIR="/usr/local"
#=================================================== install RegCM
 #=================================================

#NETCDF

export NETCDF=/usr/local
export NETCDF_INC=$NETCDF/include
export NETCDF_LIB=$NETCDF/lib
export PATH=$NETCDF/bin:${PATH}



#RegCM

#export REGCM_ROOT=/home/jialiwang/RegCM4...(I don't think I need  this)


export LD_LIBRARY_PATH=$NETCDF/lib
export MPI='/usr/local/'
export LD_LIBRARY_PATH=$MPI/lib:$LD_LIBRARY_PATH

#=================================================== ImageMagick
#export MAGICK_HOME=/usr/local/ImageMagick-7.0.1
#PATH=/usr/local/ImageMagick-7.0.1/bin:$PATH;export PATH
#export DISPLAY=:0

#=================================================== HDFLook
export HDFLOOKTMP=/Users/ctang/.HDFLOOKTMP
PATH=/Applications/HDFLook:$PATH;export PATH

#=================================================== Basemap in Python
export GEOS_DIR=/Library/Frameworks/GEOS.framework/Versions/Current/unix
export GEOS_DIR=/Library/Frameworks/GEOS.framework/Versions/3/unix/
#=================================================== 
alias tm='tmux new bash'
alias vt.='vim ~/.tmux.conf.local'
alias python="/usr/local/bin/python"
#export PYTHONPATH=$PYTHONPATH:/Users/ctang/anaconda3/lib/python3.7/site-packages
export icloud="/Users/ctang/Library/Mobile\ Documents/com~apple~CloudDocs"
alias gysomate='source activate GYSOMATE'
alias pauline='source activate MIALHE2020'
