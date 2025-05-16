typeset -U path PATH
path=(
	/usr/bin
	/opt/homebrew/bin(N-/)
	/opt/homebrew/sbin(N-/)
	/usr/sbin
	/bin
	/sbin
	/usr/local/bin(N-/)
	/usr/local/sbin(N-/)
	/Library/Apple/usr/bin
	/opt/X11/bin
)

# init sheldon
eval "$(sheldon source)"

alias ls='ls -FG'
alias ll='ls -alFG'
alias python=python3
alias mp=multipass

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export OpenMP_ROOT=$(brew --prefix)/opt/libomp
export EDITOR=vim

autoload -Uz colors && colors
zstyle ':completion:*' menu select
eval "$(uv generate-shell-completion zsh)"
source $HOME/.cargo/env

# for vscode integrated terminal
bindkey -e


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
#         . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

