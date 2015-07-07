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

#source ~/.dotfiles/git-prompt.sh
. $(brew --prefix)/Library/Taps/bfontaine/homebrew-command-not-found/handler.sh

export GIT_PROMPT_ONLY_IN_REPO=1
if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
    GIT_PROMPT_THEME=Default
    source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
fi

export EDITOR="vim"

ulimit -c unlimited

alias mygrep="grep -r -n -I -s --color"

if [ "$(uname)" == "Darwin" ]; then
    alias gvim="mvim"

    export TEXTFILTER_PATH=$HOME/tools/share/doctext
    export DOCTEXT_PATH=$HOME/tools/share

    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi

    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
else
    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Add tool to allow git to talk to mercurial
if [ -d $HOME/tools/git-remote-hg ]; then
    export PATH=$HOME/tools/git-remote-hg:$PATH
fi

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\]:\W\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\]\$\[\033[00m\] '

alias update_cscope="find $HOME/code \
    \( \( -name mvapich2 -o -name ulfm -o -name ompi-trunk -o -name ompi-ulfm -o -name mpich-intel \) -prune \) \
        -o \( -name *.h.in -o -name *.h -o -name *.c -o -name *.cpp \) -print > cscope.files ; \
    cscope -R -b -f $HOME/.cscope.out ; \
    rm -f cscope.files"

export CSCOPE_DB=$HOME/.cscope.out

# MPICH Debugging information
alias mpich_debug_on='export MPICH_DBG_FILENAME="log/dbg-%w-%d.log" ; export MPICH_DBG_CLASS=ALL ; export MPICH_DBG_LEVEL=VERBOSE'
alias mpich_debug_off='unset MPICH_DBG_FILENAME ; unset MPICH_DBG_CLASS ; unset MPICH_DBG_LEVEL'

export MPIR_CVAR_CH3_NOLOCAL=0 # Turn off if you want to try shared memory in MPICH
export MPIR_CVAR_ENABLE_FT=1

