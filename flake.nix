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
    textfox = {
      url = "github:adriankarlen/textfox";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim-config,
    spicetify-nix,
    textfox,
    vicinae,
    llm-agents,
    sops-nix,
    ...
  }: {
    homeConfigurations = {
      # macOS: home-manager switch --flake .#darwin
      "darwin" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [./home.nix sops-nix.homeManagerModules.sops spicetify-nix.homeManagerModules.default textfox.homeManagerModules.default];
        extraSpecialArgs = {
          inherit nixvim-config spicetify-nix llm-agents;
          system = "aarch64-darwin";
          features = [];
          username = "abrarhabib";
          homeDirectory = "/Users/abrarhabib";
        };
      };

      # Linux (Plasma): home-manager switch --flake .#plasma
      "plasma" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./home.nix sops-nix.homeManagerModules.sops spicetify-nix.homeManagerModules.default textfox.homeManagerModules.default];
        extraSpecialArgs = {
          inherit nixvim-config spicetify-nix llm-agents;
          system = "x86_64-linux";
          features = [];
          username = "abrar";
          homeDirectory = "/home/abrar";
        };
      };

      # Linux (Hyprland): home-manager switch --flake .#hyprland
      "hyprland" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./home.nix ./programs/hyprland.nix ./programs/waybar.nix sops-nix.homeManagerModules.sops spicetify-nix.homeManagerModules.default textfox.homeManagerModules.default vicinae.homeManagerModules.default];
        extraSpecialArgs = {
          inherit nixvim-config spicetify-nix llm-agents;
          system = "x86_64-linux";
          features = [];
          username = "abrar";
          homeDirectory = "/home/abrar";
        };
      };
    };
  };
}
