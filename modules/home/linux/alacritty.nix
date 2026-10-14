{ pkgs, ... }:
{
  home.packages = [ pkgs.alacritty ];

  xdg.configFile."alacritty/alacritty.toml".source = ./alacritty.toml;
}
