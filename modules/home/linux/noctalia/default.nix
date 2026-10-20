# Noctalia v5 config. v5 merges every *.toml in ~/.config/noctalia, then
# ~/.local/state/noctalia/settings.toml (written by the Settings UI) on top -
# so the UI wins on conflicts. Keep these keys out of the UI.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  wallpapers = "${config.home.homeDirectory}/Pictures/Wallpapers";
  monitors = config.my.noctalia.wallpaperMonitors;

  # Giving each monitor its own directory - even the same one - makes the
  # rotation pick for each independently instead of one image everywhere.
  monitorSections = lib.concatMapStrings (m: ''

    [wallpaper.monitors.${m}]
    directory = "${wallpapers}"
  '') monitors;
in
{
  options.my.noctalia.wallpaperMonitors = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    example = [
      "DP-5"
      "HDMI-A-1"
    ];
    description = ''
      Output connectors (`niri msg outputs`) that each get their own random
      wallpaper. Empty means one image on every monitor.
    '';
  };

  config = {
    home.packages = [ pkgs.noctalia ];

    xdg.configFile = {
      "noctalia/theme.toml".source = ./theme.toml;
      "noctalia/idle.toml".source = ./idle.toml;
      "noctalia/wallpaper.toml".text =
        builtins.replaceStrings
          [ "@wallpapers@" "per_monitor_directories = false" ]
          [
            wallpapers
            "per_monitor_directories = ${lib.boolToString (monitors != [ ])}"
          ]
          (builtins.readFile ./wallpaper.toml)
        + monitorSections;
    };
  };
}
