{
  description = "Handles package management for my system";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
  };

  outputs = { self, nixpkgs-unstable, nixpkgs-stable }: let
    system = "x86_64-darwin";

    unstable = import nixpkgs-unstable { inherit system; };
    stable = import nixpkgs-stable { inherit system; };

    neovim = unstable.neovim-unwrapped.override rec {
        treesitter-parsers = {};
    };
  in {
    packages.${system}.default = unstable.buildEnv {
      name = "My Packages";
      paths = [
        neovim
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
        unstable.podman # Requires vfkit in PATH
        unstable.podman-compose
        unstable.pwgen
        unstable.python312Packages.python-lsp-server
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
