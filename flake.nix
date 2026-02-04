{
  description = "Handles package management for my system";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
  };

  outputs = { self, nixpkgs-unstable, nixpkgs-stable }: let
    system = "x86_64-darwin";

    unstable = import nixpkgs-unstable { inherit system; };
    stable = import nixpkgs-stable { inherit system; };
  in {
    packages.${system}.default = unstable.buildEnv {
      name = "My Packages";
      paths = [
        unstable.bat
        unstable.codex
        unstable.delta
        unstable.elixir
        unstable.elixir-ls
        unstable.eza
        unstable.fd
        unstable.fish
        unstable.fzf
        unstable.gitui
        unstable.gnupg
        unstable.go-task
        unstable.gopls
        unstable.jq
        unstable.mise
        unstable.neovim
        unstable.nodejs_24
        unstable.opencode
        unstable.pgcli
        unstable.podman
        unstable.podman-compose
        unstable.postgresql_15
        unstable.pwgen
        unstable.python313
        unstable.python313Packages.pylsp-mypy
        unstable.python313Packages.python-lsp-ruff
        unstable.python313Packages.python-lsp-server
        unstable.ripgrep
        unstable.ruff
        unstable.s5cmd
        unstable.stylua
        unstable.typst
      ];
    };

    devShells.${system}.default = unstable.mkShell {
      name = "dotfiles";
      packages = [
        unstable.ansible
      ];
    };
  };
}
