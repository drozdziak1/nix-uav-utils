{
  description = "Flake for installing betaflight tools";

  inputs =
    {
      nixpkgs.url = github:NixOS/nixpkgs/release-22.05;
      betaflight-blackbox-explorer-src = {
        flake = false;
        url = "https://github.com/betaflight/blackbox-log-viewer/releases/download/3.6.0/betaflight-blackbox-explorer_3.6.0_linux64-portable.zip";
      };
      betaflight-configurator-src = {
        flake = false;
        url = "https://github.com/betaflight/betaflight-configurator/releases/download/10.8.0/betaflight-configurator_10.8.0_linux64-portable.zip";
      };
    };
  outputs = { self, nixpkgs, betaflight-blackbox-explorer-src, betaflight-configurator-src }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system} = {
        betaflight-blackbox-explorer =
          pkgs.callPackage ./betaflight-blackbox-explorer.nix {
            src = betaflight-blackbox-explorer-src;
          };
        betaflight-configurator =
          pkgs.callPackage ./betaflight-configurator.nix {
            src = betaflight-configurator-src;
          };
      };
    };
}
