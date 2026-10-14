{
  description = "Alex's NixOS (home-manager) and nix-darwin configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # zotero doesn't build on unstable: firefox-esr-140 was dropped but zotero
    # 10 still needs it (NixOS/nixpkgs#568692). ./overlays takes zotero from
    # here instead; drop this input once unstable is fixed.
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Linux
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Darwin
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util.url = "github:hraban/mac-app-util";

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
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nix-darwin,
      ...
    }:
    let
      inherit (nixpkgs) lib;

      linuxSystem = "x86_64-linux";
      darwinSystem = "aarch64-darwin";

      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          overlays = import ./overlays { inherit inputs; };
          config.allowUnfree = true;
        };

      # Standalone home-manager, as used on NixOS. The system configuration
      # itself lives outside this repo (/etc/nixos).
      mkHome =
        {
          system ? linuxSystem,
          modules,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs system;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./modules/home/common ] ++ modules;
        };

      # nix-darwin, with home-manager wired in as a system module.
      mkDarwin =
        {
          system ? darwinSystem,
          modules,
        }:
        nix-darwin.lib.darwinSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./modules/darwin
            inputs.nix-homebrew.darwinModules.nix-homebrew
            inputs.mac-app-util.darwinModules.default
            home-manager.darwinModules.home-manager
            {
              nixpkgs.hostPlatform = system;
              nixpkgs.overlays = import ./overlays { inherit inputs; };

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                sharedModules = [ inputs.mac-app-util.homeManagerModules.default ];
                users.alex = {
                  imports = [
                    ./modules/home/common
                    ./modules/home/darwin
                  ];
                };
              };
            }
          ]
          ++ modules;
        };
    in
    {
      homeConfigurations = {
        alex-fw = mkHome { modules = [ ./hosts/fw.nix ]; };
        alex-nuc = mkHome { modules = [ ./hosts/nuc.nix ]; };
      };

      darwinConfigurations."Alexs-MacBook-Pro" = mkDarwin {
        modules = [ ./hosts/macbook-pro.nix ];
      };

      formatter = lib.genAttrs [ linuxSystem darwinSystem ] (system: (mkPkgs system).nixfmt);
    };
}
