{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    # emacs-pgtk is Wayland-native; on darwin take the stock AppKit build.
    package = if pkgs.stdenv.hostPlatform.isDarwin then pkgs.emacs else pkgs.emacs-pgtk;
  };

  xdg.configFile."doom/" = {
    source = ./doom;
    recursive = true;
  };
}
