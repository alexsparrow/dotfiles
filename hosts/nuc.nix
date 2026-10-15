# Desktop (NVIDIA), NixOS + standalone home-manager.
# Graphics drivers are the system's job (hardware.nvidia in /etc/nixos).
{
  imports = [ ../modules/home/linux ];

  my.niri.outputs = ''
    output "HDMI-A-1" {
        mode "3840x2160@30.000"
        scale 1.5
    }
  '';

  home.stateVersion = "23.11";
}
