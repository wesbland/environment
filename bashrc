export PAGER=less
export TERM=$TERM
alias list="ls -latrh --color"
if [ "$(uname)" == "Darwin" ]; then
    alias ls="ls -G"
elif [ "$(uname)" == "Linux" ]; then
    alias ls="ls --color"
fi

export PATH=$HOME/tools/x86/bin:$HOME/.dotfiles/tmux:$HOME/.dotfiles/diff-so-fancy:$PATH
export LD_LIBRARY_PATH=$HOME/tools/x86/lib:$LD_LIBRARY_PATH
export MANPATH=$HOME/tools/x86/share/man:$MANPATH
export PKG_CONFIG_PATH=$HOME/tools/x86/lib/pkgconfig:$PKG_CONFIG_PATH
export DOCTEXT_PATH=$HOME/tools/x86/share
export C_INCLUDE_PATH=$HOME/tools/x86/include:$C_INCLUDE_PATH

if [ -z "$PS1" ]; then
    return
fi

alias vim="nvim"
export EDITOR="nvim"

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

    export GIT_PROMPT_ONLY_IN_REPO=1
    if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
        GIT_PROMPT_THEME=Default
        source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
    fi

    PATH="/Users/wbland/perl5/bin${PATH:+:${PATH}}"; export PATH;
    PERL5LIB="/Users/wbland/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
    PERL_LOCAL_LIB_ROOT="/Users/wbland/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
    PERL_MB_OPT="--install_base \"/Users/wbland/perl5\""; export PERL_MB_OPT;
    PERL_MM_OPT="INSTALL_BASE=/Users/wbland/perl5"; export PERL_MM_OPT;
else
    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi

    source "$HOME/.dotfiles/git-prompt.sh"
    source "$HOME/.dotfiles/bash_completion/git-completion.bash"

    if [ -f /opt/intel/csr/etc/hub.bash_completion.sh ]; then
        . /opt/intel/csr/etc/hub.bash_completion.sh
    fi

    export PATH=/opt/intel/csr/bin:$PATH
    export LD_LIBRARY_PATH=/opt/intel/csr/lib:/opt/intel/csr/lib64:$LD_LIBRARY_PATH
    export MANPATH=/opt/intel/csr/share/man:$MANPATH
    export PKG_CONFIG_PATH=/opt/intel/csr/lib/pkgconfig:$PKG_CONFIG_PATH
    export C_INCLUDE_PATH=/opt/intel/csr/include:$C_INCLUDE_PATH

    INTEL_PROXY='http://proxy-chain.intel.com:911'
    INTEL_HTTPS_PROXY='https://proxy-chain.intel.com:912'
    export {http,ftp,socks,all,npm_config,npm_config_https}_proxy=$INTEL_PROXY
    export {HTTP,FTP,SOCKS,ALL}_proxy=$INTEL_PROXY
    export {HTTP,FTP,SOCKS,ALL}_PROXY=$INTEL_PROXY
    export HTTPS_PROXY=$INTEL_HTTPS_PROXY
    export https_proxy=$INTEL_HTTPS_PROXY
    export no_proxy=intel.com,.intel.com,10.0.0.0/8,192.168.0.0/16,localhost,127.0.0.0/8,134.134.0.0/16

    source /opt/rh/devtoolset-4/enable
fi

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\]:\W\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\]\$\[\033[00m\] '

alias update_cscope="pushd $HOME; \
    find $HOME/code \( \( -name install \) -prune \) -o \( -name *.h.in -o -name *.h -o -name *.c -o -name *.cpp \) -print > cscope.files ; \
    cscope -R -b -f $HOME/.cscope.out ; \
    rm -f cscope.files; \
    popd"

export CSCOPE_DB=$HOME/.cscope.out

# MPICH Debugging information
alias mpich_debug_on='export MPICH_DBG_FILENAME="log/dbg-%w-%d.log" ; export MPICH_DBG_CLASS=ALL ; export MPICH_DBG_LEVEL=VERBOSE'
alias mpich_debug_off='unset MPICH_DBG_FILENAME ; unset MPICH_DBG_CLASS ; unset MPICH_DBG_LEVEL'

#if [ -f /opt/intel/cc/15.0.090/bin/iccvars.sh ]; then
#    source /opt/intel/cc/15.0.090/bin/iccvars.sh intel64
#elif [ -f /opt/intel/bin/iccvars.sh ]; then
#    source /opt/intel/bin/iccvars.sh intel64
#fi

export LOGFILE=${PMI_RANK}.${PID}.${HOSTNAME}.out
export LOGFILEERR=${PMI_RANK}.${PID}.${HOSTNAME}.err

alias git="hub"

# Turn off tmux integration with fuzzy finder
export FZF_TMUX=0
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
