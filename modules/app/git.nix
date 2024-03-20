{ config, pkgs, userSettings, ... }:

{
  home.packages = [ pkgs.git ];
  programs.git = {
    enable = true;
    userName = userSettings.profile;
    userEmail = userSettings.email;
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/home/" + userSettings.profile + "/.dotfiles";
    };
  };
}
