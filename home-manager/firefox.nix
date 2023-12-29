{ pkgs, firefox-nightly, ... }:
{
  programs.firefox = {
    enable = true;
    package = firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin;

    profiles.default = with pkgs; {
      id = 0;
      name = "default";
      isDefault = true;
      extensions = with nur.repos.rycee.firefox-addons; [
        ublock-origin
        multi-account-containers
      ];
    };
  };
}
