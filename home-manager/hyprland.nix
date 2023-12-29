{
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;

  xdg.configFile."waybar/" = {
    source = ./waybar;
    recursive = true;
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/.local/share/wallpaper/910709.jpg
    wallpaper = eDP-1,~/.local/share/wallpaper/910709.jpg
  '';

  xdg.dataFile."wallpaper".source = ../wallpaper;
}
