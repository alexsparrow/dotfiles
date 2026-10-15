# The terminal niri's Mod+T opens. Note the config path: ghostty reads
# $XDG_CONFIG_HOME/ghostty/config (no extension), which is why the old
# hand-written config.ghostty was being ignored.
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      theme = "Nord";

      # A little wallpaper through the background. Depends on the ghostty
      # window rule in ./niri/config.kdl - without it, what shows through is
      # niri's focus ring colour rather than the wallpaper.
      background-opacity = 0.9;
      # Default 0.7, which compounds with background-opacity and makes an
      # unfocused window more see-through than a focused one.
      unfocused-split-opacity = 1.0;
    };
  };
}
