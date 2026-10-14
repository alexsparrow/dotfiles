# The terminal niri's Mod+T opens. Note the config path: ghostty reads
# $XDG_CONFIG_HOME/ghostty/config (no extension), which is why the old
# hand-written config.ghostty was being ignored.
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    # Matching ./alacritty.toml: Nord, slightly transparent.
    settings = {
      theme = "Nord";
      background-opacity = 0.8;
    };
  };
}
