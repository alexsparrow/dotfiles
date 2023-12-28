{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = import ./hyprland.conf.nix;
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/.local/share/wallpaper/910709.jpg
    wallpaper = eDP-1,~/.local/share/wallpaper/910709.jpg
  '';

  xdg.dataFile."wallpaper".source = ../wallpaper;
}
