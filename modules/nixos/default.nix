{ pkgs, lib, ... }: {
  imports = [
    ./amdgraphics.nix
    ./steam.nix
  ];
}
