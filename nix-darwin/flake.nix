{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
      mac-app-util.url = "github:hraban/mac-app-util";

    android-nixpkgs = {
      # url = "github:tadfisher/android-nixpkgs";

      # The main branch follows the "canary" channel of the Android SDK
      # repository. Use another android-nixpkgs branch to explicitly
      # track an SDK release channel.
      #
      url = "github:tadfisher/android-nixpkgs/stable";
      # url = "github:tadfisher/android-nixpkgs/beta";
      # url = "github:tadfisher/android-nixpkgs/preview";
      # url = "github:tadfisher/android-nixpkgs/canary";

      # If you have nixpkgs as an input, this will replace the "nixpkgs" input
      # for the "android" flake.
      #
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      homebrew-bundle,
      homebrew-core,
      homebrew-cask,
      home-manager,
      mac-app-util,
      android-nixpkgs,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            pkgs.vim
            pkgs.tmux
            pkgs.jdk25
            pkgs.jdk17

            pkgs.devenv
          ];

          users = {
            users.alex = {
              name = "alex";
              home = "/Users/alex";
            };
          };

          system.activationScripts.extraActivation.text = ''
            ln -sf "${pkgs.jdk25}" "/Library/Java/JavaVirtualMachines/25.jdk"
            ln -sf "${pkgs.jdk17}" "/Library/Java/JavaVirtualMachines/17.jdk"
          '';

          launchd.user.envVariables = {
            JAVA_HOME = "/Library/Java/JavaVirtualMachines/17.jdk";
            EDITOR = "vim";
          };

          programs.zsh.variables = {
            JAVA_HOME = "/Library/Java/JavaVirtualMachines/17.jdk";
            EDITOR = "vim";
          };

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          programs.zsh.enable = true;

          services.emacs.enable = true;

          system.primaryUser = "alex";

          # Allow determinate to manage
          # nix.enable = false;

          nix-homebrew = {
            user = "alex";
            enable = true;
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
            };
            mutableTaps = false;
            autoMigrate = true;
          };

          homebrew = {
            enable = true;
            brews = [];
            casks = [ "ghostty" "android-studio" ];
          };

          fonts.packages = with pkgs; [
            nerd-fonts.fira-code
            nerd-fonts.jetbrains-mono
            # Needed for doom emacs in particular
            nerd-fonts.symbols-only
          ];

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          nixpkgs.config.allowUnfree = true;

          # needed for cachix with devenv
          nix.settings.trusted-users = [ "root" "alex" ];
        };
    in
    {
      # Build darwin flake using:
      darwinConfigurations."Alexs-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; }; # This passes inputs to system modules
        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          configuration
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          {
            nixpkgs.overlays = [
          android-nixpkgs.overlays.default
        ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # To enable it for all users:
            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
            ];
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.alex = import ./home.nix;
          }
        ];
      };
    };
}
