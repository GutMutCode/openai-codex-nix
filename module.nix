{ config, lib, pkgs, ... }:

{
  config = {
    nixpkgs.overlays = [ (import ./overlay.nix) ];
  };
}
