# noctalia draws the wallpaper and rotates through this folder at random
# (./noctalia/wallpaper.toml). All this module does is populate it from
# ../../../wallpaper.
#
# recursive = true so the directory stays writable - wallpapers dropped in by
# hand survive, they're just not version controlled.
{
  home.file."Pictures/Wallpapers" = {
    source = ../../../wallpaper;
    recursive = true;
  };
}
