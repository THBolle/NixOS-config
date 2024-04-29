{ pkgs, lib, ... }:

{
  imports = [
    ./apps/git.nix
    ./apps/vscode.nix
    ./services/zsh/zsh.nix
    ./services/nvim/nvim.nix
  ];
}
