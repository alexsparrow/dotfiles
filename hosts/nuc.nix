# Desktop (NVIDIA), NixOS + standalone home-manager.
# Graphics drivers are the system's job (hardware.nvidia in /etc/nixos).
{
  imports = [ ../modules/home/linux ];

  # Left, right - a different random wallpaper on each.
  my.noctalia.wallpaperMonitors = [
    "DP-5"
    "HDMI-A-1"
  ];

  home.stateVersion = "23.11";
}
