{
  description = "My first flake!";


  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
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
          modules = [
          # load configuration.nix from selected system profile
            (./. + "/system" + ("/" + systemSettings.profile) + /configuration.nix) 
             ./modules-system
          ];
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };
      homeConfigurations = {
        bolle = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            # load home.nix from selected user profile
            (./. + "/user" + ("/" + userSettings.profile) + /home.nix)
            ./modules-home
          ];
          extraSpecialArgs ={
            inherit systemSettings;
            inherit userSettings;
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

  };
}
