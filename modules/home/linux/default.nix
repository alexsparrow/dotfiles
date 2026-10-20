{
  imports = [
    # ./dunst.nix - noctalia handles notifications; kept in case that changes.
    ./alacritty.nix
    ./firefox.nix
    ./niri.nix
    ./noctalia
    ./packages.nix
    ./wallpaper.nix
  ];

  home.sessionVariables = {
    # Native Wayland for Electron/Chromium apps. NIXOS_OZONE_WL is read by the
    # nixpkgs wrappers (vscode, slack, spotify, ...); the ELECTRON_ hint is read
    # by Electron 28+ itself, which covers apps whose wrappers ignore the first.
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
