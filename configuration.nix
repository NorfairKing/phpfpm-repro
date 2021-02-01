{ config, lib, pkgs, ... }:
{
  imports = [
    ./repro1.nix
    ./repro2.nix
  ];
}
