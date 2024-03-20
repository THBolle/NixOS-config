{
  description = "My first flake!";


  outputs = inputs@{ self, nixpkgs, home-manager, nixvim, ... }:
    let
      # ----SYSTEM SETTINGS---- #
      systemSettings = {
        system = "x86_64-linux";
        hostname = "nixos";
        profile = "personal"; # select a profile defined from system directory
        timezone = "Europe/Oslo";
        locale = "nb_NO.UTF-8";
      };

      # ----USER SETTINGS----- #
      userSettings = {
        username = "bolle";
        profile = "bolle"; # select a profile defined from user directory
        email = "thomas_bolle@yahoo.com";
        dotfilesDir = "~/.dotfiles"; # Absolute path of the local repo
      };
      # ----MODULE LINKS----- #
      ML = {
        vscode = /modules/app/vscode.nix;
        git = /modules/app/git.nix;
      };
      # Configure lib
      lib = nixpkgs.lib;

      # Configure pkgs
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
      #pkgs = {
      #  nixpkgs.legacyPackages.${systemSettings.system};
      #  config = {
      #    allowUnfree = true;
      #    allowUnfreePredicate = (_: true);
      #  };
      #};

    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          system = systemSettings.system;
          modules = [ (./. + "/system" + ("/" + systemSettings.profile)
            + /configuration.nix) ]; # load configuration.nix from selected system profile
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };
      homeConfigurations = {
        bolle = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ (./. + "/user" + ("/" + userSettings.profile)
            + /home.nix) ]; # load home.nix from selected user profile
          extraSpecialArgs ={
            inherit systemSettings;
            inherit userSettings;
            inherit ML;
          };
        };
      };
    };

  inputs = {
    #nixpkgs.url = "nixpkgs/nixos-23.11";
    #home-manager.url = "github:nix-community/home-manager/release-23.11";
    #home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Unstable branch
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nixvim not in use
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
