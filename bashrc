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
else
    source $HOME/tools/share/autoScreen
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
    --with-pm=hydra \
    --with-pmi=simple \
    --disable-cxx \
    --enable-f77 \
    --enable-fc \
    --enable-strict=noopt \
    --disable-fast \
    --disable-perftest \
    --enable-nemesis-dbg-localoddeven"

alias config_mpich_fast="./configure CC=gcc CXX=g++ FC=gfortran F77=gfortran \
    --prefix=$HOME/tools \
    --disable-romio \
    --enable-strict \
    --enable-fast=all \
    --disable-f77 \
    --disable-fc"

export MPIR_CVAR_CH3_NOLOCAL=1 # Turn off if you want to try shared memory in MPICH
