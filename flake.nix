{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }: {
    packages."x86_64-darwin".default = let
      pkgs = nixpkgs.legacyPackages."x86_64-darwin";
    in pkgs.buildEnv {
      name = "my-packages";
      paths = with pkgs; [
        bat
      ];
    };
  };
}
