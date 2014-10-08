export PAGER=less
export TERM=$TERM
alias list="ls -latrh --color"
if [ "$(uname)" == "Darwin" ]; then
    alias ls="ls -G"
elif [ "$(uname)" == "Linux" ]; then
    alias ls="ls --color"
fi

export PATH=$HOME/tools/bin:$PATH
export LD_LIBRARY_PATH=$HOME/tools/lib:$LD_LIBRARY_PATH
export MANPATH=$HOME/tools/share/man:$MANPATH
export PKG_CONFIG_PATH=$HOME/tools/lib/pkgconfig:$PKG_CONFIG_PATH
export DOCTEXT_PATH=$HOME/tools/share
export C_INCLUDE_PATH=$HOME/tools/include:$C_INCLUDE_PATH

if [ -z "$PS1" ]; then
    return
fi

export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

export EDITOR="vim"

ulimit -c unlimited

if [ "$(uname)" == "Darwin" ]; then
    alias sshvm="ssh localhost -p 31337"
    export PATH=/usr/local/Cellar/ccache/3.1.9/libexec:$PATH
    alias gvim="mvim"

    # Use the correct vim
    alias vim="/usr/local/Cellar/macvim/7.4-72/MacVim.app/Contents/MacOS/Vim"
    export EDITOR="/usr/local/Cellar/macvim/7.4-72/MacVim.app/Contents/MacOS/Vim"

    # Mount LRDS development directory on virtual machine
    alias mount_lrds='sshfs -p 31337 localhost:/home/wbland/Repositories/lrds ~/Repositories/lrds'

    # Start virtual machine for LRDS development
    alias start_vm='VBoxHeadless -s Ubuntu'

    export TEXTFILTER_PATH=$HOME/tools/share/doctext
    export DOCTEXT_PATH=$HOME/tools/share/doctext

    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi

    # todo.txt stuff
    alias t="todo.sh"
    export TODOTXT_DEFAULT_ACTION=ls

    # Totalview path
    export PATH=/opt/totalview/bin:$PATH
    export LM_LICENSE_FILE=7127@licman1.mcs.anl.gov

    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
else
    source $HOME/tools/share/autoScreen

    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi

    PERL_MB_OPT="--install_base \"/homes/wbland/perl5\""; export PERL_MB_OPT;
    PERL_MM_OPT="INSTALL_BASE=/homes/wbland/perl5"; export PERL_MM_OPT;

    export PERL5LIB=/homes/wbland/tools/share/perl/5.14.2
fi

alias update_cscope="find $HOME/Repositories \
    \( \( -name mvapich2 -o -name ulfm -o -name ompi-trunk \) -prune \) \
        -o \( -name *.h.in -o -name *.h -o -name *.c -o -name *.cpp \) -print > cscope.files ; \
    cscope -R -b -f $HOME/.cscope.out ; \
    rm -f cscope.files"

export CSCOPE_DB=$HOME/.cscope.out

# MPICH Debugging information
alias mpich_debug_on='export MPICH_DBG_FILENAME="log/dbg-%w-%d.log" ; export MPICH_DBG_CLASS=ALL ; export MPICH_DBG_LEVEL=VERBOSE'
alias mpich_debug_off='unset MPICH_DBG_FILENAME ; unset MPICH_DBG_CLASS ; unset MPICH_DBG_LEVEL'

alias config_mpich_debug="./configure CC=gcc CXX=g++ FC=gfortran F77=gfortran CFLAGS=-O0 \
    --prefix=$HOME/tools \
    --disable-mpe \
    --disable-romio \
    --enable-g=all \
    --enable-spawn \
    --enable-maintainer-mode \
    --enable-error-checking=all \
    --with-pm=hydra \
    --with-pmi=simple \
    --disable-cxx \
    --enable-fortran \
    --enable-strict=noopt \
    --disable-fast \
    --disable-perftest \
    --enable-nemesis-dbg-localoddeven"

alias config_mpich_fast="./configure CC=gcc CXX=g++ FC=gfortran F77=gfortran \
    --prefix=$HOME/tools \
    --disable-romio \
    --enable-strict \
    --enable-fast=all"

export MPIR_CVAR_CH3_NOLOCAL=0 # Turn off if you want to try shared memory in MPICH

alias mygrep="grep -r -n -I -s --color"

export MPIR_CVAR_CH3_ENABLE_FT=1

alias mygrep="grep -r -n -I -s"
