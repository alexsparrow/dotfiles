# The terminal niri's Mod+T opens. Note the config path: ghostty reads
# $XDG_CONFIG_HOME/ghostty/config (no extension), which is why the old
# hand-written config.ghostty was being ignored.
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      # Nord, darkened. An explicit `background` overrides the theme's own
      # (#2e3440) regardless of key order. Darker still: #1e222a, #16181d.
      theme = "Nord";
      background = "#242933";

      # Opaque: the wallpaper is a blue-grey cityscape, and blending it in
      # washed the terminal out to a flat mid blue. 0.9 if you want a hint.
      background-opacity = 0.9;
      # Default 0.7, which would otherwise make an unfocused window more
      # see-through than a focused one.
      unfocused-split-opacity = 1.0;
    };
  };
}
