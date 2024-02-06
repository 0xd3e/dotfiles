{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable }: let
    system = "x86_64-darwin";
    pkgs = import nixpkgs { inherit system; };
    unstable-pkgs = import nixpkgs-unstable {
      inherit system;
      # config = { allowUnfree = true; };
    };
  in {
    packages.${system}.default = pkgs.buildEnv {
      name = "My Packages";
      paths = [
        pkgs.bat
        pkgs.delta
        unstable-pkgs.eza
        pkgs.fd
        pkgs.fzf
        pkgs.gitui
        pkgs.gnupg
        pkgs.jq
        unstable-pkgs.pgcli
        unstable-pkgs.podman
        unstable-pkgs.podman-compose
        pkgs.pwgen
        unstable-pkgs.qemu # Dependency of Podman
        pkgs.ripgrep
        pkgs.spaceship-prompt
        unstable-pkgs.neovim
        pkgs.yq-go
        pkgs.zsh
        pkgs.zsh-autopair
        pkgs.zsh-autosuggestions
        pkgs.zsh-history-substring-search
        pkgs.zsh-syntax-highlighting
      ];
    };

    devShells.${system}.default = pkgs.mkShell {
      name = "dotfiles";
      packages = [
        pkgs.ansible
      ];
    };
  };
}
