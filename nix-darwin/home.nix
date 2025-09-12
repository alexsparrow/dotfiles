{ config, pkgs, lib, ... }:

{

  imports = [
    ../home-manager/emacs.nix
  ];

  home = {
    packages = with pkgs; [
      llm
      glow
      kubectl
      postgresql
      nixfmt-rfc-style

      aerospace
      spotify
      discord
      slack
      iterm2
    ];
  };


  programs.starship.enable = true;
  programs.vscode = {
    enable = true;
  };

  # ... other configurations like programs, packages, etc.
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
