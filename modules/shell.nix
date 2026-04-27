{ pkgs, config, ... }:

let
  warpCert = "${config.home.homeDirectory}/.local/share/warp/combined.pem";
  warpCrt = "${config.home.homeDirectory}/.local/share/warp/cloudflare.crt";
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ls = "ls -FG";
      ll = "ls -alFG";
    };

    initContent = ''
      autoload -Uz colors && colors
      zstyle ':completion:*' menu select

      if [ -f "$HOME/.completion.d" ]; then
        source "$HOME/.completion.d"
      fi

      bindkey -e

      export TERM="xterm-256color"
    '';

    envExtra = ''
      if [ -f "${warpCert}" ]; then
        export SSL_CERT_FILE="${warpCert}"
        export REQUESTS_CA_BUNDLE="${warpCert}"
        export UV_HTTP_CA_BUNDLE="${warpCert}"
        export GRPC_DEFAULT_SSL_ROOTS_FILE_PATH="${warpCert}"
      fi

      if [ -f "${warpCrt}" ]; then
        export NODE_EXTRA_CA_CERTS="${warpCrt}"
      fi
    '';
  };
  home.file.".completion.d".source = ./../config/.completion.d;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.sheldon = {
    enable = true;
    enableZshIntegration = true;
  };
  xdg.configFile."sheldon/plugins.toml".text = ''
    shell = "zsh"

    [plugins.zsh-defer]
    github = "romkatv/zsh-defer"

    [templates]
    defer = "{{ hooks?.pre | nl }}{% for file in files %}zsh-defer source \"{{ file }}\"\n{% endfor %}{{ hooks?.post | nl }}"

    [plugins.compinit]
    inline = 'autoload -Uz compinit && compinit -C'

    [plugins.zsh-async]
    github = "mafredri/zsh-async"

    [plugins.zsh-completions]
    apply = ["defer"]
    github = "zsh-users/zsh-completions"

    [plugins.zsh-autosuggestions]
    apply = ["defer"]
    github = "zsh-users/zsh-autosuggestions"

    [plugins.zsh-syntax-highlighting]
    apply = ["defer"]
    github = "zsh-users/zsh-syntax-highlighting"

    [plugins.pure]
    github = "sindresorhus/pure"
  '';

  home.sessionVariables = {
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "/opt/homebrew/bin"
  ];

}
