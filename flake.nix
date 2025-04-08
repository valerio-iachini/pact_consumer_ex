{
  inputs = {
    systems.url = "github:nix-systems/default";
  };

  outputs = {
    systems,
    nixpkgs,
    ...
  } @ inputs: let
    eachSystem = f:
      nixpkgs.lib.genAttrs (import systems) (
        system:
          f nixpkgs.legacyPackages.${system}
      );
  in {
    devShells = eachSystem (pkgs: {
      default = pkgs.mkShell {
        buildInputs = [
          pkgs.rustc
          pkgs.rustfmt 
          pkgs.rust-analyzer
          pkgs.clippy
          pkgs.cargo
          pkgs.erlang_27
          pkgs.elixir_1_18
        ];
      };
    });
  };
}
