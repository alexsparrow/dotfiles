# Desktop (NVIDIA), NixOS + standalone home-manager.
# Graphics drivers are the system's job (hardware.nvidia in /etc/nixos).
{
  imports = [ ../modules/home/linux ];

  home.stateVersion = "23.11";
}
