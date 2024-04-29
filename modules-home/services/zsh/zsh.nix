{ config, pkgs, lib, ... }:

{
  options = {
    zsh.enable =
      lib.mkEnableOption "Enable zsh";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh= {
      enable = true;
      initExtraBeforeCompInit = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
      '';
      initExtra = ''
        #source ~/.dotfiles/modules-home/services/zsh/p10k-config/p10k.zsh
      '';

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k-theme";
        }
        #{
         # name = "powerlevel10k-config";
          #src = ./p10k-config;
          #file = "p10k.zsh";
        #}
      ];
    };
  };
}
