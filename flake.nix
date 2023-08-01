{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/23.05";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system} = rec {
        dev = with pkgs;
          mkShell {
            buildInputs = [
              (ghc.withPackages (x:
                with x; [
                  cabal-install
                  hoogle
                  ghcid
                  haskell-language-server
                ]))
            ];
          };
        default = dev;
      };
    };
}
