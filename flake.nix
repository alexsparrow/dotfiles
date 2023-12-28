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
  };

  outputs = { nixpkgs, nurpkgs, home-manager, firefox-nightly, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      foo = builtins.trace nurpkgs;
    in
    {
      homeConfigurations.alex = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          firefox-nightly = firefox-nightly;
          nurpkgs = nurpkgs;
        };
        modules = [ ./home.nix ];
      };
    };
}
