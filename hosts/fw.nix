# Framework laptop, NixOS + standalone home-manager.
{
  imports = [ ../modules/home/linux ];

  # No output blocks yet - niri auto-detects. Fill in from `niri msg outputs`
  # once this machine is actually running the config.
  # my.niri.outputs = ''
  #   output "eDP-1" {
  #       mode "..."
  #       scale 2
  #   }
  # '';

  home.stateVersion = "23.11";
}
