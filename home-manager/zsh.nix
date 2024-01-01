{ config, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      pacman-prune = "sudo pacman -Rsn $(pacman -Qdtq)";
      # https://bbs.archlinux.org/viewtopic.php?id=187359
      pacman-non-dep = "comm -23 <(pacman -Qqt | sort) <(echo $ignorepkg | tr ' ' '\n' | cat <(pacman -Sqg $ignoregrp) - | sort -u)";
      ssl_info = "openssl s_client -connect $1:443 </dev/null 2>/dev/null | openssl x509 -inform pem -text";
    };

    plugins = [
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

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        { name = "zsh-users/zsh-syntax-highlighting"; tags = [ defer:2 ]; }
      ];
    };
  };
}
