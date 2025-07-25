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
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export OpenMP_ROOT=$(brew --prefix)/opt/libomp
export EDITOR=vim

autoload -Uz colors && colors
zstyle ':completion:*' menu select
# eval "$(uv generate-shell-completion zsh)"
source $HOME/dotfiles/.completion.d
source $HOME/.cargo/env

# for vscode integrated terminal
bindkey -e

#refer rg over ag
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
fi
if type fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd'
fi

export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export BAT_THEME="Catppuccin Mocha"

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


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mashiro.toyooka.ng-pt/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/mashiro.toyooka.ng-pt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mashiro.toyooka.ng-pt/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/mashiro.toyooka.ng-pt/google-cloud-sdk/completion.zsh.inc'; fi

# pnpm
export PNPM_HOME="/Users/mashiro.toyooka.ng-pt/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
