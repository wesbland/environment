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
fi

alias update_cscope="cd $HOME/Repositories/ ; cscope -R -b -f $HOME/.cscope.out  ; cd - > /dev/null"

export CSCOPE_DB=$HOME/.cscope.out

export C_INCLUDE_PATH=$HOME/tools/include

# MPICH Debugging information
alias mpich_debug_on='export MPICH_DBG_FILENAME="log/dbg-%w-%d.log" ; export MPICH_DBG_CLASS=ALL ; export MPICH_DBG_LEVEL=VERBOSE'
