{
  description = "Alex's home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-nightly = {
      url = "github:colemickens/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nurpkgs.url = "github:nix-community/NUR";
    nixgl.url = "github:guibou/nixGL";

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # See: https://github.com/nix-community/nix-doom-emacs/issues/409#issuecomment-1753412481
    # and: https://github.com/nix-community/nix-straight.el/pull/4
    # nix-straight = {
    #   url = "github:codingkoi/nix-straight.el?ref=codingkoi/apply-librephoenixs-fix";
    #   flake = false;
    # };
    # nix-doom-emacs = {
    #   url = "github:nix-community/nix-doom-emacs";
    #   inputs = {
    #     nix-straight.follows = "nix-straight";
    #     # ... whatever other follows you might want to set like nixpkgs or emacs-overlay
    #   };
    # };
  };

  outputs =
    { nixpkgs
    , nurpkgs
    , home-manager
    , firefox-nightly
    , nixgl
    , emacs-overlay
    , #nix-doom-emacs,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {

      homeConfigurations.alex = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          firefox-nightly = firefox-nightly;
          nurpkgs = nurpkgs;
          nixgl_ = nixgl;
          # nix-doom-emacs = nix-doom-emacs;
          emacs-overlay = emacs-overlay;
        };

        modules = [
          ./home-manager/dunst.nix
          ./home-manager/emacs.nix
          ./home-manager/firefox.nix
          ./home-manager/git.nix
          ./home-manager/home.nix
          ./home-manager/hyprland.nix
          ./home-manager/session-vars.nix
          ./home-manager/vscode.nix
          ./home-manager/zotero.nix
          ./home-manager/zsh.nix
        ];
      };
    };
}
