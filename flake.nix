{
  description = "Noikos dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs_24
            pnpm
            postgresql_18
          ];

          shellHook = ''
            echo "🏠 Noikos dev environment"
            echo "Node: $(node --version)"
            echo "pnpm: $(pnpm --version)"
            export NODE_NO_WARNINGS=1

          '';
        };
      }
    );
}
