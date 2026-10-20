{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.my.niri.outputs = lib.mkOption {
    type = lib.types.lines;
    default = "";
    description = ''
      Machine-specific niri `output` blocks, appended to niri/config.kdl.
      Omit to let niri pick modes automatically.
    '';
  };

  # niri itself is enabled system-wide (programs.niri.enable in /etc/nixos), so
  # this module only owns the config and the tools it reaches for.
  config = {
    xdg.configFile."niri/config.kdl".text =
      builtins.readFile ./niri/config.kdl + config.my.niri.outputs;

    home.packages = with pkgs; [
      fuzzel # Mod+D launcher
      swaylock # Super+Alt+L
      xwayland-satellite # X11 apps under niri
    ];
  };
}
