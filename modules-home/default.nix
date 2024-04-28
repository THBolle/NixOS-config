{ pkgs, lib, ... }:

{
  imports = [
    ./apps/git.nix
    ./apps/vscode.nix
    ./service/zsh/zsh.nix
  ];
}
