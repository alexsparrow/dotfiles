# Not imported by default any more: niri is the compositor I actually use.
# Kept around (and importable per-host) until I'm sure I'm not going back.
#
# hyprland.nvidia.conf is deliberately unused: NixOS sets the nvidia/wayland
# env vars system-wide, so it's only here in case a host ever needs them again.
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprland
    hyprpaper
    rofi-wayland
    waybar
  ];

  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;

  xdg.configFile."waybar/" = {
    source = ./waybar;
    recursive = true;
  };

  # hyprpaper reads absolute paths, hence its own copy of the wallpapers;
  # ./wallpaper.nix puts the same set where noctalia looks.
  xdg.dataFile."wallpaper".source = ../../../wallpaper;

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/.local/share/wallpaper/910709.jpg
    preload = ~/.local/share/wallpaper/992551.jpg
    wallpaper = eDP-1,~/.local/share/wallpaper/910709.jpg
    wallpaper = DP-5,~/.local/share/wallpaper/992551.jpg
  '';
}
