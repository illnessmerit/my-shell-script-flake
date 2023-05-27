{
  inputs.nixpkgs.url = "github:nixos/nixpkgs";

  outputs = { self, nixpkgs }: let
    pkgs = nixpkgs.legacyPackages.aarch64-darwin;
  in {
    packages.aarch64-darwin.my-shell-script = pkgs.stdenv.mkDerivation {
      name = "my-shell-script";
      src = ./my-shell-script.sh;
      phases = [ "installPhase" ];
      installPhase = ''
        mkdir -p $out/bin
        cp $src $out/bin/my-shell-script
        chmod +x $out/bin/my-shell-script
      '';
    };

    defaultPackage.aarch64-darwin = self.packages.aarch64-darwin.my-shell-script;

    devShell.aarch64-darwin = pkgs.mkShell {
      buildInputs = [ self.packages.aarch64-darwin.my-shell-script ];
    };
  };
}
