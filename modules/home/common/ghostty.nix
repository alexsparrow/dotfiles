# Shared terminal settings for Linux and macOS.
{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.hostPlatform.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    enableZshIntegration = true;

    settings = {
      theme = "Nord";

      # On Linux this also needs the Ghostty window rule in
      # ../linux/niri/config.kdl so the wallpaper shows through.
      background-opacity = 0.9;
      # Default 0.7, which compounds with background-opacity and makes an
      # unfocused window more see-through than a focused one.
      unfocused-split-opacity = 1.0;
      # Default is 10MB per surface. Long Claude Code sessions fill it, and
      # every resize (e.g. niri's Mod+F maximize-column) reflows all of it.
      scrollback-limit = 2000000;
    };
  };
}
