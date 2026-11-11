# noctalia draws the wallpaper and rotates through ~/Pictures/Wallpapers at
# random (./noctalia/wallpaper.toml). If my.wallpapers.repo is set, this
# module clones that repo there and pulls it on every switch, so wallpapers
# pushed to it reach every machine without touching the flake. If it isn't
# set (or the fetch fails - offline, no access), the folder is just a
# folder: drop images in by hand.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.wallpapers;
  dir = "${config.home.homeDirectory}/Pictures/Wallpapers";
  git = lib.getExe pkgs.git;
in
{
  options.my.wallpapers.repo = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    example = "git@github.com:someone/wallpapers.git";
    description = "Git repo to keep ~/Pictures/Wallpapers in sync with.";
  };

  config = lib.mkMerge [
    {
      home.activation.wallpaperDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run mkdir -p ${lib.escapeShellArg dir}
      '';
    }

    (lib.mkIf (cfg.repo != null) {
      # After linkGeneration so any old home.file symlinks into the store are
      # cleaned up first. Never fails the switch.
      home.activation.wallpapers =
        lib.hm.dag.entryAfter
          [
            "linkGeneration"
            "wallpaperDir"
          ]
          ''
            export GIT_SSH_COMMAND="${pkgs.openssh}/bin/ssh -o BatchMode=yes -o ConnectTimeout=10"
            dir=${lib.escapeShellArg dir}
            if [ -d "$dir/.git" ]; then
              run ${git} -C "$dir" pull --ff-only --quiet \
                || warnEcho "wallpapers: pull failed, keeping what's there"
            elif [ -z "$(ls -A "$dir")" ]; then
              run ${git} clone --quiet ${lib.escapeShellArg cfg.repo} "$dir" \
                || warnEcho "wallpapers: clone failed, folder left empty"
            else
              warnEcho "wallpapers: $dir isn't empty and isn't a clone, not touching it"
            fi
          '';
    })
  ];
}
