{ inputs, pkgs, ... }:
{
  imports = [
    ./homebrew.nix
    ./java.nix
  ];

  environment.systemPackages = with pkgs; [
    tmux
    vim
  ];

  users.users.alex = {
    name = "alex";
    home = "/Users/alex";
  };

  system.primaryUser = "alex";

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  services.emacs.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
