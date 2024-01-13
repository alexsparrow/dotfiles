{ nvidia, ... }:
let
  additionalFiles = if nvidia then [ ./hyprland.nvidia.conf ] else [ ];
  configFiles = [ ./hyprland.conf ] ++ additionalFiles;
  configFileContents = builtins.concatStringsSep "\n" (builtins.map builtins.readFile configFiles);
in
{
  xdg.configFile."hypr/hyprland.conf".text = configFileContents;

  xdg.configFile."waybar/" = {
    source = ./waybar;
    recursive = true;
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/.local/share/wallpaper/910709.jpg
    preload = ~/.local/share/wallpaper/992551.jpg
    wallpaper = eDP-1,~/.local/share/wallpaper/910709.jpg
    wallpaper = DP-5,~/.local/share/wallpaper/992551.jpg
  '';

  xdg.dataFile."wallpaper".source = ../wallpaper;
}
