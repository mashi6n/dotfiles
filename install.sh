set -eux

if [ ! -d "$HOME/dotfiles" ]; then
  echo "dotfiles/ directory not found."
  echo "Please place dotfiles/ in your home directory."
  exit 1
fi

mkdir -p $HOME/.config

[ -e $HOME/.zshrc ] || ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
[ -e $HOME/.config/sheldon ] || ln -s $HOME/dotfiles/sheldon $HOME/.config/sheldon
[ -e $HOME/.config/raycast ] || ln -s $HOME/dotfiles/raycast $HOME/.config/raycast
[ -e $HOME/.config/alacritty ] || ln -s $HOME/dotfiles/alacritty $HOME/.config/alacritty
[ -e $HOME/.config/karabiner ] || ln -s $HOME/dotfiles/karabiner $HOME/.config/karabiner
[ -e $HOME/.config/nvim ] || ln -s $HOME/dotfiles/nvim $HOME/.config/nvim
[ -e $HOME/.config/bat ] || ln -s $HOME/dotfiles/bat $HOME/.config/bat
[ -e $HOME/.completion.d ] || ln -s $HOME/dotfiles/.completion.d $HOME/.completion.d
[ -e $HOME/.tmux.conf ] || ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
