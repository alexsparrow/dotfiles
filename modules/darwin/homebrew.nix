{ inputs, ... }:
{
  nix-homebrew = {
    enable = true;
    user = "alex";
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
    };
    mutableTaps = false;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    brews = [ ];
    casks = [ ];
  };
}
