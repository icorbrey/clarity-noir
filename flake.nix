{
  inputs.nix-colorizer.url = "github:nutsalhan87/nix-colorizer";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  
  outputs = { nixpkgs, nix-colorizer, ... }: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  in {
    packages = builtins.listToAttrs (map (system: {
      name = system;
      value = let
        pkgs = import nixpkgs {
          inherit system;
        };

        lib = pkgs.lib;

        palette = import ./src/palette.nix {
          inherit (nix-colorizer) hex oklch;
        };

        roles = import ./src/roles.nix {
          inherit palette;
        };
      in {
        palette = import ./targets/palette.nix {
          inherit (nix-colorizer) hex oklch;
          inherit lib palette pkgs;
        };
      };
    }) systems);
  };
}
