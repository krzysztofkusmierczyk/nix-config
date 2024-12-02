{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./amdgraphics.nix
    ./steam.nix
    ./one-password.nix
  ];
}
