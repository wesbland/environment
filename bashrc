export PAGER=less
export TERM=$TERM
alias list="ls -latrh --color"  
alias ls="ls -G --color"
alias mv="mv -i" 
alias cp="cp -i" 
#alias vi="vim"

export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

export EDITOR="vim"

ulimit -c unlimited

alias sshdesk="ssh bertuzzi.mcs.anl.gov"
alias sshvm="ssh localhost -p 31337"

export PATH=/usr/local/Cellar/ccache/3.1.9/libexec:$HOME/tools/bin:$PATH

export CSCOPE_DB=$HOME/.cscope.out

alias update_cscope='cd /Users/wbland/Repositories/ ; cscope -R -b -f /Users/wbland/.cscope.out  ; cd - > /dev/null'

# MPICH Debugging information
alias mpich_debug_on='export MPICH_DBG_FILENAME="log/dbg-%w-%d.log" ; export MPICH_DBG_CLASS=ALL ; export MPICH_DBG_LEVEL=VERBOSE'

# Mount LRDS development directory on virtual machine
alias mount_lrds='sshfs -p 31337 localhost:/home/wbland/Repositories/lrds ~/Repositories/lrds'

# Start virtual machine for LRDS development
alias start_vm='VBoxHeadless -s Ubuntu'
