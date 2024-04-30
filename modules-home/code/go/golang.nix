{pkgs, config, lib, ...}:

{
  options = {
    golang.enable =
      lib.mkEnableOption "enables golang";
  };

  config = lib.mkIf config.golang.enable {
    programs.go.enable = true;
  };
}
