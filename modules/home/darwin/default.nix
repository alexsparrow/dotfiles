{ pkgs, ... }:
{
  home.packages = with pkgs; [
    aerospace
    discord
    iterm2
    slack
    spotify
  ];
}
