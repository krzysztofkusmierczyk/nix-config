{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./slack.nix
    ./vscode.nix
    ./neovim
  ];
}
