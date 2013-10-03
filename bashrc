export PAGER=less
export TERM=$TERM
alias list="ls -latrh --color"
if [ "$(uname)" == "Darwin" ]; then
    alias ls="ls -G"
elif [ "$(uname)" == "Linux" ]; then
    alias ls="ls --color"
fi
alias mv="mv -i"
alias cp="cp -i"
#alias vi="vim"

export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

export EDITOR="vim"

ulimit -c unlimited

if [ "$(uname)" == "Darwin" ]; then
    alias sshvm="ssh localhost -p 31337"
    export PATH=/usr/local/Cellar/ccache/3.1.9/libexec:$HOME/tools/bin:$PATH
    alias gvim="mvim"

    # Mount LRDS development directory on virtual machine
    alias mount_lrds='sshfs -p 31337 localhost:/home/wbland/Repositories/lrds ~/Repositories/lrds'

    # Start virtual machine for LRDS development
    alias start_vm='VBoxHeadless -s Ubuntu'
else
    export PATH=$HOME/tools/bin:$PATH
fi

alias update_cscope="find $HOME/Repositories \
    \( \( -name mvapich2 -o -name ulfm -o -name ompi-trunk \) -prune \) \
        -o \( -name *.h.in -o -name *.h -o -name *.c -o -name *.cpp \) -print > cscope.files ; \
    cscope -R -b -f $HOME/.cscope.out ; \
    rm -f cscope.files"

export CSCOPE_DB=$HOME/.cscope.out

export C_INCLUDE_PATH=$HOME/tools/include:$C_INCLUDE_PATH
export LD_LIBRARY_PATH=$HOME/tools/lib:$LD_LIBRARY_PATH
export MANPATH=$HOME/tools/share/man:$MANPATH

# MPICH Debugging information
alias mpich_debug_on='export MPICH_DBG_FILENAME="log/dbg-%w-%d.log" ; export MPICH_DBG_CLASS=ALL ; export MPICH_DBG_LEVEL=VERBOSE'
alias mpich_debug_off='export MPICH_DBG_FILENAME="" ; export MPICH_DBG_CLASS= ; export MPICH_DBG_LEVEL='

alias config_mpich="./configure CC=gcc CXX=g++ FC=gfortran F77=gfortran \
    --prefix=$HOME/tools \
    --enable-g \
    --disable-romio \
    --enable-debuginfo \
    --enable-threads=runtime \
    --disable-silent-rules \
    --enable-maintainer-mode \
    --enable-strict \
    --enable-coverage"
