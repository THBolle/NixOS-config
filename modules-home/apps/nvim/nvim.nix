{ config, pkgs, lib, nvim-kickstart, ... }:

{
  options = {
    nvim.enable =
      lib.mkEnableOption "Enable nvim";
  };

  config = lib.mkIf config.nvim.enable {
    programs.ripgrep.enable = true;

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
      ];

      extraLuaConfig = ''
      ${builtins.readFile ./plugins/init.lua}
      '';
    };
  };
}
