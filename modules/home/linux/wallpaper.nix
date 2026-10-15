# noctalia draws the wallpaper and picks one at random from its browse folder
# (Settings -> Wallpaper -> Automation: enabled, order = random). All this
# module does is populate that folder from ../../../wallpaper.
#
# recursive = true so the directory stays writable - wallpapers dropped in by
# hand survive, they're just not version controlled.
{
  home.file."Pictures/Wallpapers" = {
    source = ../../../wallpaper;
    recursive = true;
  };
}
