{ pkgs, ... }:
{
  home.packages = with pkgs; [
    aerospace
    discord
    firefox
    iterm2
    slack
    spotify
  ];
}
