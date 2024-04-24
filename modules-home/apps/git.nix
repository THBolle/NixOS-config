{ config, pkgs, userSettings, lib, ... }:

{
  options = {
    git.enable =
      lib.mkEnableOption "Enable git";
  };

  config = lib.mkIf config.git.enable {
    # home.packages = [ pkgs.git ];
    programs.git = {
      enable = true;
      userName = userSettings.profile;
      userEmail = userSettings.email;
      extraConfig = {
        init.defaultBranch = "main";
        safe.directory = "/home/" + userSettings.profile + "/.dotfiles";
      };
    };
  };
}
