{ pkgs, nix-doom-emacs, ... }:
{
  # imports = [ nix-doom-emacs.hmModule ];
  # programs.doom-emacs = {
  programs.emacs = {
    enable = true;
    #   doomPrivateDir = ./doom.d; # Directory containing your config.el, init.el
    # and packages.el files
    # emacsPackage = pkgs.emacs-pgtk;

    package = pkgs.emacs-pgtk;
  };

  xdg.configFile."doom/" = {
    source = ./doom;
    recursive = true;
  };
}
