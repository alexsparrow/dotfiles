{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      # Host configs are named after the hostname (alex-nuc, alex-fw).
      hmup = "home-manager switch -b backup --flake ~/dotfiles#$(hostname)";
      darwinup = "sudo darwin-rebuild switch --flake ~/dotfiles";
    };

    initContent = ''
      function ssl_info() {
        openssl s_client -connect $1:443 </dev/null 2>/dev/null | openssl x509 -inform pem -text
      }
    '';

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
      {
        name = "zsh-alex";
        src = ./zsh-alex;
        file = "alex.zsh";
      }
    ];
  };
}
