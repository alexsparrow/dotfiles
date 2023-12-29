{ config, pkgs, nurpkgs, firefox-nightly, nixgl_, ... }:
let
  nixGLWrap = pkg: pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
    mkdir $out
    ln -s ${pkg}/* $out
    rm $out/bin
    mkdir $out/bin
    for bin in ${pkg}/bin/*; do
     wrapped_bin=$out/bin/$(basename $bin)
     echo "exec ${pkgs.lib.getExe pkgs.nixgl.nixGLIntel} $bin \$@" > $wrapped_bin
     chmod +x $wrapped_bin
    done
  '';
in
{

  nixpkgs = {
    overlays = [
      nurpkgs.overlay
      nixgl_.overlay
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
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

  # The home.packages option allows you to install Nix packages into your
  # environment.


  home.packages = with pkgs; [
    nixgl.nixGLIntel

    vscode

    hyprpaper
    grim
    slurp
    wl-clipboard
    cliphist
    waybar

    (nixGLWrap alacritty)
    (nixGLWrap hyprland)
    xfce.thunar

    texlive.combined.scheme-medium
    hledger
    hledger-web

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".bin" = {
      source = ../bin;
      recursive = true;
    };
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/alex/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
    # NIXOS_OZONE_WL = "1";
    # See: https://github.com/simonmichael/hledger/issues/1033
    LOCALE_ARCHIVE = "/usr/lib/locale/locale-archive";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.configFile."alacritty/alacritty.yml".source = ./alacritty.yml;

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

  programs.git = {
    enable = true;
    userName = "Alex Sparrow";
    userEmail = "alex@alexsparrow.dev";
    aliases = {
      ci = "commit";
    };
  };
}
