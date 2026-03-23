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
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim-config, spicetify-nix, ... }:
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

        # Linux (Plasma): home-manager switch --flake .#linux
        "linux" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [ ./home.nix spicetify-nix.homeManagerModules.default ];
          extraSpecialArgs = {
            inherit nixvim-config spicetify-nix;
            system = "x86_64-linux";
            features = [];
            homeDirectory = "/home/abrar";
          };
        };

        # Linux (Hyprland): home-manager switch --flake .#hyprland
        "hyprland" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [ ./home.nix ./programs/hyprland.nix ./programs/waybar.nix spicetify-nix.homeManagerModules.default ];
          extraSpecialArgs = {
            inherit nixvim-config spicetify-nix;
            system = "x86_64-linux";
            features = [];
            homeDirectory = "/home/abrar";
          };
        };
      };
    };
}
