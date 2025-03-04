{
  description = "Handles package management for my system";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
  };

  outputs = { self, nixpkgs-unstable, nixpkgs-stable }: let
    system = "x86_64-darwin";

    unstable = import nixpkgs-unstable { inherit system; };
    stable = import nixpkgs-stable { inherit system; };
  in {
    packages.${system}.default = unstable.buildEnv {
      name = "My Packages";
      paths = [
        unstable.aerospace
        unstable.neovim
        unstable.bat
        unstable.delta
        unstable.elixir
        unstable.elixir-ls
        unstable.eza
        unstable.fd
        unstable.fzf
        unstable.gitui
        unstable.gnupg
        unstable.gopls
        unstable.jq
        unstable.nodejs_20
        stable.pgcli
        unstable.podman
        unstable.podman-compose
        unstable.pwgen
        unstable.python312
        unstable.python312Packages.python-lsp-server
        unstable.python312Packages.python-lsp-ruff
        unstable.python312Packages.pylsp-mypy
        unstable.ripgrep
        unstable.ruff
        unstable.s5cmd
        unstable.yq-go
        unstable.zsh-autopair
        unstable.zsh-autosuggestions
        unstable.zsh-history-substring-search
        unstable.zsh-powerlevel10k
        unstable.zsh-syntax-highlighting
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
