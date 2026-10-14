{ pkgs, ... }:
{
  imports = [
    ./direnv.nix
    ./emacs.nix
    ./git.nix
    ./vscode.nix
    ./zsh.nix
  ];

  home.sessionVariables.EDITOR = "vim";

  home.username = "alex";
  home.homeDirectory = if pkgs.stdenv.hostPlatform.isDarwin then "/Users/alex" else "/home/alex";

  # Tools I want on every machine, whatever the platform.
  home.packages = with pkgs; [
    claude-code
    devenv # per-project toolchains; keeps this list to the machine-wide stuff
    docker-compose
    glow
    htop
    kubectl
    llm
    nixfmt
    nmap
    postgresql
    ripgrep
    zip
  ];

  home.file.".bin" = {
    source = ../../../bin;
    recursive = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
