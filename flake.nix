{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { flake-parts, self, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      flake.overlays.default = final: prev: {
        haskellPackages = prev.haskellPackages.override (old: {
          overrides = final.lib.composeExtensions (old.overrides or (_: _: { })) (
            hself: hsuper: {
              advent-of-code = hself.generateOptparseApplicativeCompletions [ "advent-of-code" ] (
                prev.haskellPackages.callPackage ./nix { }
              );
            }
          );
        });
      };
      perSystem =
        { pkgs, system, ... }:
        let
          hPkgs = pkgs.haskellPackages;
          hLib = pkgs.haskell.lib;
        in
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
            config = { };
          };

          devShells.default = hPkgs.shellFor {
            packages = p: [ p.advent-of-code ];
            nativeBuildInputs = with pkgs; [
              cabal-install
              cabal2nix # cd nix && cabal2nix ../. > default.nix && ..
              ghcid
              haskell-language-server
              hpack
              hlint
              haskellPackages.retrie # refactoring tool
              haskellPackages.implicit-hie # auto-generate hie.yaml file
            ];
          };

          formatter = pkgs.nixfmt-rfc-style;

          packages.default = hLib.justStaticExecutables pkgs.haskellPackages.advent-of-code;
        };
    };

  nixConfig = {
    extra-substituters = [ "https://attic.winston.sh/public" ];
    extra-trusted-public-keys = [ "public:gqpCDffg2eWolOCakuF0FhU0hmPHvOiBy2Z2rpyf8Mg=" ];
  };
}
