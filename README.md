# PHPFPM repro

To run the test: 

```
NIX_PATH="nixpkgs=/path/to/the/nixpkgs/you/want/to/test" nix-build test.nix
```

To jump into the vm:

```
nix-build test.nix -A driver
./result/bin/nixos-run-vms
```
