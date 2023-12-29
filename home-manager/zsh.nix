{ config, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
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
