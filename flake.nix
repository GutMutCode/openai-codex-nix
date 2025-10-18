{
  description = "OpenAI Codex CLI for NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      overlays.default = import ./overlay.nix;

      nixosModules.default = import ./module.nix;

      homeManagerModules.default = import ./module.nix;

      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
          };
        in
        {
          openai-codex = pkgs.openai-codex;
          default = pkgs.openai-codex;
        }
      );

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.openai-codex}/bin/codex";
        };
      });

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = [ self.packages.${system}.openai-codex ];
            shellHook = ''
              echo "OpenAI Codex CLI development environment"
              echo "Run 'codex' to start"
            '';
          };
        }
      );
    };
}
