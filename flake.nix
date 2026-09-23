{
  description = "marketing-mix-model dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        pythonEnv = pkgs.python312.withPackages (ps: with ps; [
          # notebook / modeling stack
          numpy
          pandas
          matplotlib
          pymc
          arviz
          jupyter

          # api
          fastapi
          uvicorn
        ]);
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pythonEnv
            pkgs.ruff
          ];

          shellHook = ''
            echo "marketing-mix-model dev shell (python $(python3 --version))"
            echo "lint/format: ruff check . / ruff format ."
            echo "run api:     uvicorn main:app --reload"
          '';
        };
      });
}
