{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;

    # The 26.05+ default. Migrating means moving ~/.mozilla/firefox here.
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        multi-account-containers
      ];
    };
  };
}
