{
  description = "Personal home-manager configuration for Abrar Habib";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim-config = {
      url = "github:dddictionary/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim-config, ... }:
    {
      homeConfigurations = {
        # macOS: home-manager switch --flake .#darwin
        "darwin" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = [ ./home.nix ];
          extraSpecialArgs = {
            inherit nixvim-config;
            system = "aarch64-darwin";
            features = [];
            homeDirectory = "/Users/abrar";
          };
        };

        # Linux: home-manager switch --flake .#linux
        "linux" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [ ./home.nix ];
          extraSpecialArgs = {
            inherit nixvim-config;
            system = "x86_64-linux";
            features = [];
            homeDirectory = "/home/abrar";
          };
        };
      };
    };
}
