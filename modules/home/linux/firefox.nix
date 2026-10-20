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
      settings = {
        # Text scale as a percentage (UI and pages). Scales text only, so it
        # stacks with the monitor's scale factor instead of replacing it.
        "ui.textScaleFactor" = 110;
      };
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        ublock-origin
        multi-account-containers
      ];
    };
  };

  # Make Firefox the default browser. This takes over ~/.config/mimeapps.list,
  # so the other handlers apps registered there are kept here too.
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "x-scheme-handler/claude-cli" = "claude-code-url-handler.desktop";
      "x-scheme-handler/bitwarden" = "bitwarden.desktop";
      "x-scheme-handler/slack" = "slack.desktop";
    };
  };
  home.sessionVariables.BROWSER = "firefox";
}
