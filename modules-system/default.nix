{ pkgs, lib, ... }:

{
  imports = [
    ./services/nvidia.nix
  ];
}
