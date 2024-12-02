{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      perSystem =
        { lib, pkgs, ... }:
        let
          # need to match Stackage LTS version from stack.yaml snapshot
          hPkgs = pkgs.haskell.packages.ghc982;

          # Wrap Stack to use the flake Haskell packages
          stack-wrapped = pkgs.symlinkJoin {
            name = "stack";
            paths = [ pkgs.stack ];
            buildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              wrapProgram $out/bin/stack \
                --add-flags "--no-nix --system-ghc --no-install-ghc"
            '';
          };

          myDevTools = [
            # GHC compiler in the desired version (will be available on PATH)
            hPkgs.ghc
            # Continuous terminal Haskell compile checker
            hPkgs.ghcid
            # Haskell formatter
            hPkgs.fourmolu
            # Haskell codestyle checker
            hPkgs.hlint
            # Lookup Haskell documentation
            hPkgs.hoogle
            # LSP server for editor
            hPkgs.haskell-language-server
            # auto generate LSP hie.yaml file from cabal
            hPkgs.implicit-hie
            # Haskell refactoring tool
            hPkgs.retrie
            # Haskell build tool
            stack-wrapped
          ] ++ lib.optionals pkgs.stdenv.isDarwin [ ];
        in
        {
          devShells.default = pkgs.mkShell {
            buildInputs = myDevTools;
            env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath myDevTools;
          };
          formatter = pkgs.nixfmt-rfc-style;
        };
    };

  nixConfig = {
    extra-substituters = [ "https://attic.winston.sh/public" ];
    extra-trusted-public-keys = [ "public:gqpCDffg2eWolOCakuF0FhU0hmPHvOiBy2Z2rpyf8Mg=" ];
  };
}
