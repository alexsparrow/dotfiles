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

  # These names come from the my.wallpapers.repo clone (./wallpaper.nix).
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/Pictures/Wallpapers/910709.jpg
    preload = ~/Pictures/Wallpapers/992551.jpg
    wallpaper = eDP-1,~/Pictures/Wallpapers/910709.jpg
    wallpaper = DP-5,~/Pictures/Wallpapers/992551.jpg
  '';
}
