{
  description = "A very basic flake";

  inputs.nixpkgs.url =
    "github:nixos/nixpkgs/e76e8cf22e8639250266df96a90f4746c9c34f95";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
      in {
        packages = {
          kong = pkgs.callPackage ./pkg {};
        };

        devShell =
          pkgs.mkShell { 
            LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
              pkgs.zlib
            ];

            buildInputs = [ 
              pkgs.nix-prefetch-git
              pkgs.nixfmt
              pkgs.arion
            ];
          };
      });
}
