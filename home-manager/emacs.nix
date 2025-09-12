{ pkgs, nix-doom-emacs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };

  xdg.configFile."doom/" = {
    source = ./doom;
    recursive = true;
  };
}
