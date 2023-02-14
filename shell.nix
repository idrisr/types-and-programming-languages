with import <nixpkgs> { };
mkShell {
  buildInputs = [
    (ghc.withPackages
      (x: with x; [ cabal-install hoogle ghcid haskell-language-server ]))
  ];
}
