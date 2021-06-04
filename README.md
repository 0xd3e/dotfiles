# Dotfiles

This repository contains my dotfiles and other stuff I need to get going. The
dotfiles are managed by [chezmoi][chezmoi].

The ZSH plugins are installed and managed using [Antibody][antibody].

In the `misc` directory you can find various scripts for installing packages,
fonts and so on.

## Usage

### 1. Install MacPorts

See the [MacPorts Installation Guide][macports-install].

### 2. Install Ports

```shell
$ sh misc/install_ports.sh
```

### 3. Apply Dotfiles

```shell
$ chezmoi init https://github.com/0xIDANT/dotfiles.git
```

### 4. Install ZSH Plugins

```shell
$ antibody bundle < /path/to/this/repo/misc/zsh_plugins
```

[antibody]: https://getantibody.github.io
[chezmoi]: https://www.chezmoi.io
[macports-install]: https://www.macports.org/install.php
