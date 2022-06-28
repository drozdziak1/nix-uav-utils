{
  description = "Flake for installing betaflight tools";

  inputs =
    {
      nixpkgs.url = github:NixOS/nixpkgs/release-22.05;
      betaflight-blackbox-explorer-src = {
        flake = false;
        url = "https://github.com/betaflight/blackbox-log-viewer/releases/download/3.6.0/betaflight-blackbox-explorer_3.6.0_linux64-portable.zip";
      };
    };
  outputs = { self, nixpkgs, betaflight-blackbox-explorer-src }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system}.betaflight-blackbox-explorer = pkgs.callPackage ./blackbox-explorer.nix { src = betaflight-blackbox-explorer-src; };
      defaultPackage.${system} = self.packages.${system}.betaflight-blackbox-explorer;
    };
}
