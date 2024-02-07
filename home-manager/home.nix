{ config, pkgs, nurpkgs, firefox-nightly, nixgl_, emacs-overlay, nvidia, ... }:
let
  nixGLWrap = (import ./nixgl.nix { pkgs = pkgs; nvidia = nvidia; }).nixGLWrap;
  goread = (import ../packages/goread.nix { lib = pkgs.lib; buildGoModule = pkgs.buildGoModule; fetchFromGitHub = pkgs.fetchFromGitHub; });
  semtex = (import ../packages/semtex.nix { lib = pkgs.lib; fetchurl = pkgs.fetchurl; appimageTools = pkgs.appimageTools; });
in
{
  home.username = "alex";
  home.homeDirectory = "/home/alex";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    (if nvidia then nixgl.auto.nixGLNvidia else nixgl.nixGLIntel)

    hyprpaper
    grim
    slurp
    wl-clipboard
    cliphist
    waybar
    rofi-wayland
    acpilight
    wmctrl
    xorg.xwininfo
    bc
    circumflex
    goread

    (nixGLWrap alacritty)
    (nixGLWrap hyprland)
    xfce.thunar

    texlive.combined.scheme-medium
    hledger
    hledger-web
    signal-desktop
    whatsapp-for-linux
    spotify
    discord
    evince
    foliate
    kooha
    calibre
    nomacs
    gimp
    nom
    zip
    strace
    wine

    semtex

    kubectl
    helm
    postgresql
    nmap
    htop
    gdb
    docker-compose
    ripgrep
    terraform
    rustup
    jetbrains.idea-community
    nodejs
    upower
    toot

    slack
    zotero_beta

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "DroidSansMono" ]; })

    (pkgs.writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".bin" = {
      source = ../bin;
      recursive = true;
    };

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  xdg.configFile."alacritty/alacritty.toml".source = ./alacritty.toml;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
