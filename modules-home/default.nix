{ pkgs, lib, ... }:

{
  imports = [
    ./apps/git.nix
    ./apps/vscode.nix
    ./services/zsh/zsh.nix
    ./apps/nvim/nvim.nix
    ./code/go/golang.nix
  ];
}
