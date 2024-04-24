{pkgs, config, lib, ...}:

{
  options = {
    vscode.enable =
      lib.mkEnableOption "enables vscode";
  };

  config = lib.mkIf config.vscode.enable {
    programs.vscode.enable = true;
    # environment.systemPackages = with pkgs; [ vscode];
    # home.programs = [
    #  vscode.enable = true;
    # ];
  };
}
